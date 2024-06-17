import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key, required this.onSelectDrawerMenu});

  final void Function(String identifier) onSelectDrawerMenu;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              child: const Row(
                children: [
                  Icon(
                    Icons.fastfood,
                    size: 50,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Cook Now",
                    style: TextStyle(fontSize: 25),
                  )
                ],
              )),
          ListTile(
            leading: const Icon(
              Icons.restaurant,
              size: 25,
            ),
            title: Text(
              "Meals",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white, fontSize: 25),
            ),
            onTap: () {
              onSelectDrawerMenu("meal");
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              size: 25,
            ),
            title: Text(
              "Filters",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white, fontSize: 25),
            ),
            onTap: () {
              onSelectDrawerMenu("filter");
            },
          )
        ],
      ),
    );
  }
}
