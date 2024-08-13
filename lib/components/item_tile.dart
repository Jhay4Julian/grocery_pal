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
  bool isShort = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Divider(
            thickness: 0.3,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
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
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isShort = !isShort;
                        });
                      },
                      child: Text(
                        widget.item,
                        style: TextStyle(
                          fontSize: 16,
                          decoration: ticked
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                        softWrap: true,
                        maxLines: isShort ? 2 : null,
                        overflow: isShort ? TextOverflow.ellipsis : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuButton(
              position: PopupMenuPosition.under,
              onSelected: (value) {
                // Future.delayed to show the dialog after the popup menu is closed
                if (value == 0) {
                  Future.delayed(
                      Duration.zero, () => _showUpdateDialog(context));
                } else if (value == 1) {
                  Future.delayed(
                      Duration.zero, () => _showDeleteDialog(context));
                }
              },
              itemBuilder: (BuildContext context) {
                return const [
                  PopupMenuItem(
                    value: 0,
                    child: Text('Edit'),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Text('Delete'),
                  ),
                ];
              },
            ),
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
                    style: TextStyle(color: Colors.blueGrey),
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

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Padding(
            padding: EdgeInsets.only(top: 15, left: 15),
            child: Text(
              'Are you sure?',
              style: TextStyle(fontSize: 16),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.blueGrey),
              ),
            ),
            ElevatedButton(
              onPressed: widget.onPressed,
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
