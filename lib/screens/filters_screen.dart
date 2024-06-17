import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  var isGluttenFree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      body: Column(
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
                    .titleLarge!
                    .copyWith(color: Colors.white)),
            contentPadding: const EdgeInsets.only(left: 35, right: 44),
          ),
        ],
      ),
    );
  }
}
