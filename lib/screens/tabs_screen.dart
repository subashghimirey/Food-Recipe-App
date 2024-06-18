import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';

import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/my_drawer.dart';

final kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  Map<Filter, bool> _selectedFilterOptions = kInitialFilters;

  int _currentPageIndex = 0;

  void _selectPage(var index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  void showFavMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  List<Meal> favoriteMeals = [];

  void _toggleFavoriteFood(Meal meal) {
    var favExisting = favoriteMeals.contains(meal);

    if (favExisting) {
      setState(() {
        favoriteMeals.remove(meal);
      });
      showFavMessage("Removed from Favorite");
    } else {
      setState(() {
        favoriteMeals.add(meal);
      });
      showFavMessage("Added to Favorite");
    }
  }

  //we can get teh values returned by pop of the filter screen here in the push of FilterScreen
  void onSelectMenuItem(String identifier) async {
    Navigator.pop(context);

    if (identifier == "filter") {
      final result = await Navigator.of(context)
          .push<Map<Filter, bool>>(MaterialPageRoute(builder: (ctx) {
        return FiltersScreen(selectedFilters: _selectedFilterOptions,);
      }));

      print(result);
      setState(() {
      _selectedFilterOptions = result ?? kInitialFilters;
        
           //if the result is somehow null then, the initial filter values i.e. false to all are set
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where(
      (meal) {
        if (_selectedFilterOptions[Filter.glutenFree]! && !meal.isGlutenFree) {
          return false;
        }
        if (_selectedFilterOptions[Filter.lactoseFree]! &&
            !meal.isLactoseFree) {
          return false;
        }
        if (_selectedFilterOptions[Filter.vegetarian]! && !meal.isVegetarian) {
          return false;
        }
        if (_selectedFilterOptions[Filter.vegan]! && !meal.isVegan) {
          return false;
        }
        return true;
      },
    ).toList();

    Widget activeScreen = CategoriesScreen(
      onToggleFavorite: _toggleFavoriteFood,
      availableMeals: availableMeals,
    );
    var activeTitle = "Categories";

    if (_currentPageIndex == 1) {
      activeScreen = MealsScreen(
          meals: favoriteMeals, onToggleFavorite: _toggleFavoriteFood);
      activeTitle = "Your Favorites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activeTitle),
      ),
      drawer: MyDrawer(
        onSelectDrawerMenu: onSelectMenuItem,
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentPageIndex,
          onTap: _selectPage,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.food_bank,
                ),
                label: "Categories"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favorites"),
          ]),
    );
  }
}
