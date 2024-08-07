import 'package:flutter/material.dart';

class ItemTile extends StatefulWidget {
  final String item;
  final ValueChanged<String> onUpdate;
  final VoidCallback onPressed;
  const ItemTile({
    super.key,
    required this.item,
    required this.onPressed,
    required this.onUpdate,
  });

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  bool ticked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
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
        Row(
          children: [
            IconButton(
              onPressed: () {
                _showUpdateDialog(context);
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.blueGrey,
              ),
            ),
            IconButton(
              onPressed: widget.onPressed,
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        )
      ],
    );
  }

  void _showUpdateDialog(BuildContext context) {
    final TextEditingController editController =
        TextEditingController(text: widget.item);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: TextField(
            controller: editController,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                widget.onUpdate(editController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
