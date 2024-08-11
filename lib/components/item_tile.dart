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
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 35),
          child: Divider(
            thickness: 0.5,
          ),
        ),
        Row(
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
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    widget.item,
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1,
                      decoration: ticked
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
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
        ),
      ],
    );
  }

  void _showUpdateDialog(BuildContext context) {
    final TextEditingController editController =
        TextEditingController(text: widget.item);

    String? errorText;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // StatefulBuilder to manage state within the dialog.
        //Can call setState within the dialog to update the UI when needed.
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: TextField(
                controller: editController,
                decoration: InputDecoration(
                  errorText: errorText,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (editController.text.isNotEmpty) {
                      widget.onUpdate(editController.text);
                      Navigator.of(context).pop();
                    } else {
                      setState(() {
                        errorText = 'Input cannot be empty';
                      });
                    }
                  },
                  child: const Text('Update'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
