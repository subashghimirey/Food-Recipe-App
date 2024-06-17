import 'package:flutter/material.dart';

import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/my_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
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

  void onSelectMenuItem(String identifier) {
    Navigator.pop(context);
    if (identifier == "filter") {
      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
        return const FiltersScreen();
      }));
    } 
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = CategoriesScreen(
      onToggleFavorite: _toggleFavoriteFood,
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
