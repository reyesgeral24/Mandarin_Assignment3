import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class MenuItem {
  const MenuItem({required this.name, required this.priceCents});

  final String name;

  // Store prices as whole cents for exact budget calculations.
  final int priceCents;

  String get formattedPrice => '\$${(priceCents / 100).toStringAsFixed(2)}';
}

const _starterMenu = [
  MenuItem(name: 'Egg Roll', priceCents: 300),
  MenuItem(name: 'Vegetable Spring Rolls', priceCents: 350),
  MenuItem(name: 'Fried Wontons', priceCents: 800),
  MenuItem(name: 'Chicken Dumplings', priceCents: 1000),
  MenuItem(name: 'Honey Garlic Chicken Wings', priceCents: 1400),
  MenuItem(name: 'Sushi Sampler', priceCents: 1200),
  MenuItem(name: 'Hot & Sour Soup', priceCents: 600),
  MenuItem(name: 'Wonton Soup', priceCents: 650),
  MenuItem(name: 'Egg Drop & Mushroom Soup', priceCents: 600),
  MenuItem(name: 'Chicken Noodle Soup', priceCents: 650),
  MenuItem(name: 'Chicken Chow Mein', priceCents: 1300),
  MenuItem(name: 'Beef Chow Mein', priceCents: 1400),
  MenuItem(name: 'Shrimp Chow Mein', priceCents: 1500),
  MenuItem(name: 'Vegetable Mushroom Chow Mein', priceCents: 1100),
  MenuItem(name: 'Steamed Rice', priceCents: 500),
  MenuItem(name: 'Plain Fried Rice', priceCents: 900),
  MenuItem(name: 'Chicken Fried Rice', priceCents: 1300),
  MenuItem(name: 'Shrimp Fried Rice', priceCents: 1500),
  MenuItem(name: 'Thai Mango Salad', priceCents: 900),
  MenuItem(name: 'Shrimp Salad', priceCents: 1200),
];

/// Opens SQLite and inserts the 20 starter dishes when the database is first created.
Future<Database> _openMenuDatabase() async {
  final databasePath = path.join(await getDatabasesPath(), 'mandarin.db');

  return openDatabase(
    databasePath,
    version: 1,
    onCreate: (database, version) async {
      await database.execute('''
        CREATE TABLE menu_items (
          id INTEGER PRIMARY KEY,
          name TEXT NOT NULL,
          price_cents INTEGER NOT NULL CHECK (price_cents >= 0)
        )
      ''');

      // Group the initial inserts into one batch.
      final batch = database.batch();
      for (final item in _starterMenu) {
        batch.insert('menu_items', {
          'name': item.name,
          'price_cents': item.priceCents,
        });
      }
      await batch.commit(noResult: true);
    },
  );
}

/// Reads the saved dishes and prices from SQLite in insertion order.
Future<List<MenuItem>> loadMenuItems() async {
  final database = await _openMenuDatabase();
  final rows = await database.query('menu_items', orderBy: 'id ASC');

  return rows.map((row) {
    return MenuItem(
      name: row['name'] as String,
      priceCents: row['price_cents'] as int,
    );
  }).toList();
}