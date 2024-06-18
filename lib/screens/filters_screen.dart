import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.selectedFilters});

  final Map<Filter, bool> selectedFilters;

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class _FiltersScreenState extends State<FiltersScreen> {
  var isGluttenFree = false;
  var isLactoseFree = false;
  var isVegetarian = false;
  var isVegan = false;

  @override
  void initState() {
    super.initState();
    isGluttenFree = widget.selectedFilters[Filter.glutenFree]!;
    isLactoseFree = widget.selectedFilters[Filter.lactoseFree]!;
    isVegetarian = widget.selectedFilters[Filter.vegetarian]!;
    isVegan = widget.selectedFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),

      //PopScope allows to handle what to do after the screen pops, here we want to set the filters to the meals items after the filter screen pops
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          //PopScope autoamtically pops the screen but we want to return some value, hence we used manual popping to return which filters were chosen.
          if (didPop) {
            return;
          }
          Navigator.of(context).pop({
            Filter.glutenFree: isGluttenFree,
            Filter.lactoseFree: isLactoseFree,
            Filter.vegetarian: isVegetarian,
            Filter.vegan: isVegan
          });
        },
        child: Column(
          children: [
            SwitchListTile(
              value: isGluttenFree,
              onChanged: (isChecked) {
                setState(() {
                  isGluttenFree = isChecked;
                });
              },
              title: Text("Glutten-Free",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white)),
              activeColor: Theme.of(context).colorScheme.tertiary,
              subtitle: Text("Only glutten free foods here",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white)),
              contentPadding: const EdgeInsets.only(left: 35, right: 44),
            ),
            SwitchListTile(
              value: isLactoseFree,
              onChanged: (isChecked) {
                setState(() {
                  isLactoseFree = isChecked;
                });
              },
              title: Text("Lactose-Free",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white)),
              activeColor: Theme.of(context).colorScheme.tertiary,
              subtitle: Text("Only Lactose free foods here",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white)),
              contentPadding: const EdgeInsets.only(left: 35, right: 44),
            ),
            SwitchListTile(
              value: isVegetarian,
              onChanged: (isChecked) {
                setState(() {
                  isVegetarian = isChecked;
                });
              },
              title: Text("Vegetarian",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white)),
              activeColor: Theme.of(context).colorScheme.tertiary,
              subtitle: Text("Only Vegetarian foods here",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white)),
              contentPadding: const EdgeInsets.only(left: 35, right: 44),
            ),
            SwitchListTile(
              value: isVegan,
              onChanged: (isChecked) {
                setState(() {
                  isVegan = isChecked;
                });
              },
              title: Text("Vegan Foods",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white)),
              activeColor: Theme.of(context).colorScheme.tertiary,
              subtitle: Text("Only Vegan foods here",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white)),
              contentPadding: const EdgeInsets.only(left: 35, right: 44),
            ),
          ],
        ),
      ),
    );
  }
}
