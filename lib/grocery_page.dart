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
      if (_controller.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),
            backgroundColor: Colors.red,
            margin: EdgeInsets.all(20),
            content: Text('Input cannot be empty'),
          ),
        );
      } else {
        items.add(_controller.text);
        _controller.clear();
        FocusScope.of(context).unfocus();
      }
    });
  }

  void _deleteItem(String item) {
    setState(() {
      items.remove(item);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          margin: EdgeInsets.all(20),
          content: Text('Deleted'),
        ),
      );
    });
  }

  void _updateItem(String oldItem, String newItem) {
    setState(() {
      int index = items.indexOf(oldItem);
      if (index != -1) {
        items[index] = newItem;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'Tasks',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 40),
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
                                      top: 0,
                                      left: 10,
                                      right: 10,
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[250],
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                      ),
                                    ),
                                  ),
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              InkWell(
                                onTap: _addItem,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Save',
                                      style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 1,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Column(
                          children: items.map((item) {
                            return ItemTile(
                              item: item,
                              key: ValueKey(item),
                              onPressed: () => _deleteItem(item),
                              onUpdate: (newItem) => _updateItem(item, newItem),
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
        ),
      ),
    );
  }
}
