import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: RandomNumberList(),
      ),
    );
  }
}

class RandomNumberList extends StatefulWidget {
  @override
  _RandomNumberListState createState() => _RandomNumberListState();
}

class _RandomNumberListState extends State<RandomNumberList> {
  final Random _random = Random();
  int? _randomNumber;

  List<int> _items = List.generate(50, (index) => index);

  void _generateRandomNumber() {
    setState(() {
      _randomNumber = _items[_random.nextInt(_items.length)];
    });
  }

  void _removeItem(int item) {
    setState(() {
      _items.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FloatingActionButton(
          onPressed: _generateRandomNumber,
          child: const Text(' Random '),

        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Random Number: ${_randomNumber ?? '-'}',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (_, index) {
              final int currentItem = _items[index];
              return Dismissible(
                confirmDismiss: (direction) async {
                  return currentItem == _randomNumber;
                },
                key: Key("Index $currentItem"),
                background: Container(
                  decoration: const BoxDecoration(color: Colors.red),
                ),
                secondaryBackground: Container(
                  width: double.maxFinite,
                  height: 60,
                  decoration: BoxDecoration(color: Colors.green),
                ),
                behavior: HitTestBehavior.opaque,
                dragStartBehavior: DragStartBehavior.down,
                movementDuration: const Duration(seconds: 5),
                onDismissed: (direction) {
                  _removeItem(currentItem);
                  print("Item $currentItem dismissed");
                },
                child: Row(
                  children: [
                    const Icon(Icons.countertops),
                    Text('Item $currentItem'),
                  ],
                ),
              );
            },
            separatorBuilder: (_, __) => const Divider(),
            itemCount: _items.length,
          ),
        ),
      ],
    );
  }
}