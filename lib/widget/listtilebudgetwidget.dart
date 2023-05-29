import 'package:flutter/material.dart';
import 'package:money_management_app/UI/budget/budget_model.dart';
import 'package:money_management_app/UI/budget/budget_provider.dart';
import 'package:provider/provider.dart';
import '../utils/colors.dart';

class ListTileWidget extends StatefulWidget {
  ListTileWidget(
      {Key? key,
      required this.category,
      required this.icon,
      required this.isBudgeted})
      : super(key: key);
  final String category;
  IconData icon;
  bool isBudgeted;

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
          orElse: () => BudgetModel(0, 0,'', false, Icons.add),
        );
        TextEditingController setLimitController = TextEditingController();
        TextEditingController updateValueController =
            TextEditingController(text: budgetModel.setLimitvalue.toString());
        return ListTile(
          leading: Icon(
            widget.icon,
            color: black,
          ),
          title: Text(
            widget.category,
            style: TextStyle(color: black, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            widget.isBudgeted
                ? "Remaining: \u{20B9} ${budgetModel.spendAmount.toString()}"
                : "Spends: \u{20B9} 0",
            style: TextStyle(color: black),
          ),
          trailing: widget.isBudgeted
              ? InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          insetPadding:
                              const EdgeInsets.fromLTRB(0, 150, 0, 360),
                          title: const Text(
                            "Edit Budget",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          content: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(widget.icon),
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
                                    budgetModel: budgetModel,
                                    context: context,
                                    category: widget.category);
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
                                    category: widget.category);
                                snapshot.updateTotalBudget();
                              },
                              child: Text(
                                "Update",
                                style: TextStyle(
                                  color: teal,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
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
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          insetPadding:
                              const EdgeInsets.fromLTRB(0, 150, 0, 360),
                          title: const Text(
                            "Set Budget",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          content: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(widget.icon),
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
                                  int.parse(
                                    setLimitController.text.trim(),
                                  ),
                                  widget.category,
                                  isBudgeted = true,
                                  widget.icon,
                                );
                                snapshot.settingLimit(access);
                                snapshot.totalRemSpend(widget.category,
                                    remAmount: int.parse(
                                      setLimitController.text.trim(),
                                    ));
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
                        );
                      },
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
