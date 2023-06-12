import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_management_app/UI/budget/budget_model.dart';
import 'package:money_management_app/UI/budget/budget_provider.dart';
import 'package:provider/provider.dart';
import '../UI/home/provider.dart';
import '../utils/colors.dart';

class ListTileWidget extends StatefulWidget {
  const ListTileWidget({
    Key? key,
    required this.category,
    required this.icon,
    required this.isBudgeted,
    required this.spendAmount,
    this.remainingAmount,
    required this.id,
  }) : super(key: key);
  final String category;
  final String icon;
  final bool isBudgeted;
  final int spendAmount;
  final int? remainingAmount;
  final int id;
  @override
  State<ListTileWidget> createState() => _ListTileWidgetState();
}

class _ListTileWidgetState extends State<ListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BudgetProvider>(
      builder: (context, snapshot, _) {
        // Find the BudgetModel for the specific category
        BudgetModel? budgetModel = snapshot.setLimit.firstWhere(
          (model) => model.categories == widget.category,
          orElse: () =>
              BudgetModel(0, 0, 0, '', false, Icons.add.toString(), 0),
        );

        TextEditingController setLimitController = TextEditingController();
        TextEditingController updateValueController =
            TextEditingController(text: budgetModel.setLimitvalue.toString());
        return ListTile(
          // leading: Icon(
          //   widget.id,
          //   color: black,
          // ),
          title: Text(
            widget.category,
            style: TextStyle(color: black, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            widget.isBudgeted
                ? "Remaining: \u{20B9} ${widget.remainingAmount}"
                : "Spends: \u{20B9}  ${widget.spendAmount}",
            style: TextStyle(color: black),
          ),
          trailing: widget.isBudgeted
              ? InkWell(
                  onTap: () {
                    showGeneralDialog(
                      context: context,
                      pageBuilder: (ctx, a1, a2) {
                        return Container();
                      },
                      transitionBuilder: (ctx, a1, a2, child) {
                        var curve = Curves.easeInOut.transform(a1.value);
                        return Transform.scale(
                          scale: curve,
                          child: SingleChildScrollView(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                              child: AlertDialog(
                                insetPadding: const EdgeInsets.symmetric(
                                  horizontal: 80,
                                  vertical: 280,
                                ),
                                title: const Text(
                                  "Edit Budget",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: Column(
                                  children: [
                                    Row(
                                      children: [
                                        // Icon(widget.icon),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(widget.category),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      keyboardType: TextInputType.number,
                                      cursorColor: teal,
                                      controller: updateValueController,
                                      decoration: const InputDecoration(
                                          enabledBorder: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(),
                                          hintText: "Budget"),
                                    )
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      snapshot.removeItems(
                                          amount:
                                              updateValueController.text.trim(),
                                          id: widget.id);
                                      snapshot.categorySpends();
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Delete",
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        color: teal,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      snapshot.updateItem(
                                          updateValueController:
                                              updateValueController,
                                          context: context,
                                          category: widget.category,
                                          id: widget.id);
                                      snapshot.categoryRemaining();
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Update",
                                      style: TextStyle(
                                        color: teal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 300),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: teal),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Update",
                          style: TextStyle(
                            color: teal,
                          )),
                    ),
                  ),
                )
              : InkWell(
                  onTap: () {
                    showGeneralDialog(
                      context: context,
                      pageBuilder: (ctx, a1, a2) {
                        return Container();
                      },
                      transitionBuilder: (ctx, a1, a2, child) {
                        var curve = Curves.easeInOut.transform(a1.value);
                        return Transform.scale(
                          scale: curve,
                          child: SingleChildScrollView(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                              child: AlertDialog(
                                insetPadding: const EdgeInsets.symmetric(
                                  horizontal: 80,
                                  vertical: 280,
                                ),
                                title: const Text(
                                  "Set Budget",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: Column(
                                  children: [
                                    Row(
                                      children: [
                                        // Icon(widget.icon),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(widget.category),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      cursorColor: teal,
                                      controller: setLimitController,
                                      decoration: const InputDecoration(
                                          enabledBorder: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(),
                                          hintText: "Budget"),
                                    )
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        color: teal,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      bool isBudgeted;
                                      final access = BudgetModel(
                                        int.parse(
                                          setLimitController.text.trim(),
                                        ),
                                        0,
                                        0,
                                        widget.category,
                                        isBudgeted = true,
                                        widget.icon,
                                        widget.id,
                                      );
                                      snapshot.settingLimit(
                                          access, context, widget.id);
                                      final provider =
                                          Provider.of<AddListProvider>(context,
                                              listen: false);
                                      provider.totalSpendAmount(
                                          context: context);
                                      snapshot.categoryRemaining();
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Save",
                                      style: TextStyle(
                                        color: teal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 300),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: teal), color: teal),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Set Limit",
                          style: TextStyle(
                            color: white,
                          )),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
