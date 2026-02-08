import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NumberSelector extends StatefulWidget {
  final String title;
  final int minNumber;
  final int maxNumber;
  final int initialNumber;
  final ValueChanged<int> onNumberSelected;
  final VoidCallback? onCancel;

  const NumberSelector({
    Key? key,
    required this.title,
    this.minNumber = 1,
    this.maxNumber = 300,
    required this.initialNumber,
    required this.onNumberSelected,
    this.onCancel,
  }) : super(key: key);

  @override
  State<NumberSelector> createState() => _NumberSelectorState();
}

class _NumberSelectorState extends State<NumberSelector> {
  late int selectedNumber;
  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    selectedNumber = widget.initialNumber;

    // Calculate the initial index
    int initialIndex = widget.initialNumber - widget.minNumber;
    _scrollController = FixedExtentScrollController(initialItem: initialIndex);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Header with Cancel and Done buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Cancel Button
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    if (widget.onCancel != null) {
                      widget.onCancel!();
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // Title
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                // Done Button
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    widget.onNumberSelected(selectedNumber);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 1, color: Colors.grey.shade300),

          // Number Picker
          Expanded(
            child: CupertinoPicker(
              scrollController: _scrollController,
              itemExtent: 40,
              backgroundColor: Colors.white,
              squeeze: 1.0,
              diameterRatio: 1.5,
              onSelectedItemChanged: (index) {
                setState(() {
                  selectedNumber = widget.minNumber + index;
                });
              },
              children: List.generate(widget.maxNumber - widget.minNumber + 1, (
                index,
              ) {
                int number = widget.minNumber + index;
                return Center(
                  child: Text(
                    '$number',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
