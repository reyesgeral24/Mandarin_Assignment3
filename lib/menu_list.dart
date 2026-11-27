import 'package:flutter/material.dart';

import 'menu_database.dart';

class MenuList extends StatefulWidget {
  const MenuList({super.key, this.loadMenu = loadMenuItems});

  final Future<List<MenuItem>> Function() loadMenu;

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  late final Future<List<MenuItem>> _menuItems;

  /// Starts the menu query once so rebuilds reuse the same future.
  @override
  void initState() {
    super.initState();
    _menuItems = widget.loadMenu();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MenuItem>>(
      future: _menuItems,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          debugPrint('Menu load failed: ${snapshot.error}');
          return const Center(child: Text('Could not load the menu.'));
        }

        final items = snapshot.requireData;
        if (items.isEmpty) {
          return const Center(child: Text('The menu is empty.'));
        }

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(item.name),
              trailing: Text(item.formattedPrice),
            );
          },
        );
      },
    );
  }
}