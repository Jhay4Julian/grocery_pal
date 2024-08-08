import 'package:flutter/material.dart';

class ItemTile extends StatefulWidget {
  final String item;
  final VoidCallback onPressed;
  ItemTile({
    super.key,
    required this.item,
    required this.onPressed,
  });

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  bool ticked = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                value: ticked,
                onChanged: (value) {
                  setState(() {
                    ticked = !ticked;
                  });
                },
              ),
              const SizedBox(width: 10),
              Text(
                widget.item,
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 1,
                  decoration:
                      ticked ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: widget.onPressed,
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
