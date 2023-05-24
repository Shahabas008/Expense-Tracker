import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../UI/addBugdet/addBudgetprovider.dart';
import '../utils/colors.dart';

class ContainerAddBudget extends StatefulWidget {
  ContainerAddBudget({
    Key? key,
    required this.icon,
    required this.text,
    required this.bgcolor,
    required this.containerIndex,
    required this.boolean,
  }) : super(key: key);
  IconData icon;
  String text;
  Color bgcolor;
  int containerIndex;
  bool boolean;

  @override
  State<ContainerAddBudget> createState() => _ContainerAddBudgetState();
}

class _ContainerAddBudgetState extends State<ContainerAddBudget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddBudgetProvider>(
      builder: (context, snapshot, _) {
        return GestureDetector(
          onTap: () {
            snapshot.selectedContainerColorChange(widget.containerIndex);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.only(
              right: 5.0,
            ),
            decoration: BoxDecoration(
              color: widget.containerIndex == snapshot.selectedIndex
                  ? widget.bgcolor
                  : white,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              border: Border.all(
                color: widget.containerIndex == snapshot.selectedIndex
                    ? widget.bgcolor
                    : Colors.grey.shade500,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: widget.bgcolor,
                  radius: 15,
                  child: Icon(
                    widget.icon,
                    size: 20,
                    color: black,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                FittedBox(
                  child: Text(
                    widget.text,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
