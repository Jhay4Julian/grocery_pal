import 'package:flutter/material.dart';

import 'components/item_tile.dart';

class GroceryPage extends StatefulWidget {
  const GroceryPage({super.key});

  @override
  State<GroceryPage> createState() => _GroceryPageState();
}

class _GroceryPageState extends State<GroceryPage> {
  final TextEditingController _controller = TextEditingController();
  List<String> items = [];

  void _addItem() {
    setState(() {
      items.add(_controller.text);
      _controller.clear();
    });
  }

  void _deleteItem(String item) {
    setState(() {
      items.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Grocery Pal',
                      style: TextStyle(fontSize: 25),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 35,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 0, left: 10, right: 10),
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 33,
                            child: MaterialButton(
                              onPressed: _addItem,
                              color: Colors.blue[300],
                              child: const Padding(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                child: Text(
                                  'Add Item',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: items.map((item) {
                        return ItemTile(
                          item: item,
                          key: ValueKey(item),
                          onPressed: () => _deleteItem(item),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
