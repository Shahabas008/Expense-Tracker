import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:money_management_app/UI/addBugdet/addBudgetprovider.dart';
import 'package:money_management_app/UI/home/homepage.dart';
import 'package:money_management_app/UI/home/model.dart';
import 'package:money_management_app/UI/home/provider.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../budget/budget_provider.dart';

class AddBudget extends StatefulWidget {
  const AddBudget({Key? key, this.amount, this.title, this.note})
      : super(key: key);
  final int? amount;
  final String? title;
  final String? note;

  @override
  State<AddBudget> createState() => _AddBudgetState();
}

class _AddBudgetState extends State<AddBudget> {
  TextEditingController amountController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  int selectedContainerIndex = 1;
  int selectedContainerList = 1;
  Color container1Color = teal;
  Color container2Color = Colors.transparent;
  bool isExpanded = true;
  GlobalKey widgetKey = GlobalKey();
  double childHeight = 0.0;
  IconData iconCategory = Icons.add;
  Color bgColorOfContainer = Colors.transparent;
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    if (widget.title != null) {
      isEdit = true;
      final amount = widget.amount;
      final title = widget.title;
      final note = widget.note;
      amountController.text = amount!.toString();
      titleController.text = title!;
      noteController.text = note!;
    }
  }

  void changeColor(int containerIndex) {
    setState(() {
      selectedContainerIndex = containerIndex;
      if (containerIndex == 1) {
        container1Color = teal;
      } else if (containerIndex == 2) {
        container1Color = teal;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<AddListProvider, AddBudgetProvider, BudgetProvider>(
      builder: (BuildContext context, snapshot, snapshot2, snapshot3, _) {
        return Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: white,
            title: Text(
              "Main Account",
              style: TextStyle(color: black, fontWeight: FontWeight.bold),
            ),
            leading: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: black,
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Icon(
                  Icons.wallet,
                  color: black,
                ),
              ],
            ),
            actions: [
              isEdit
                  ? IconButton(
                      onPressed: () {
                        //Deleting the category from the list
                        snapshot.incomeTextFormValues.value.removeWhere(
                            (element) => widget.title == element.title);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.delete_outline,
                        color: black,
                      ),
                    )
                  : Container(),
            ],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            changeColor(1);
                          },
                          child: Container(
                            height: 60,
                            width: 130,
                            decoration: BoxDecoration(
                              color: selectedContainerIndex == 1
                                  ? container1Color
                                  : container2Color,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              border: Border.all(color: teal),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Income",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: selectedContainerIndex == 1
                                        ? white
                                        : black,
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_upward_outlined,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            changeColor(2);
                          },
                          child: Container(
                            height: 60,
                            width: 130,
                            decoration: BoxDecoration(
                                color: selectedContainerIndex == 2
                                    ? container1Color
                                    : container2Color,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                border: Border.all(color: teal)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Expense",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: selectedContainerIndex == 2
                                        ? white
                                        : black,
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_downward_outlined,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 35,
                          width: 175,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                color: teal,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(Icons.calendar_today_outlined),
                              Text(
                                snapshot.currentDate,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 35,
                          width: 125,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                color: teal,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(Icons.access_time_outlined),
                              Text(
                                snapshot.currentTime,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter amount';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      cursorColor: teal,
                      controller: amountController,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: teal),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: teal),
                        ),
                        hintText: "Enter Amount",
                        hintStyle: TextStyle(
                          color: primary,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      cursorColor: teal,
                      controller: titleController,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: teal),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: teal),
                        ),
                        hintText: "Title",
                        hintStyle: TextStyle(
                          color: primary,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      cursorColor: teal,
                      controller: noteController,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: teal),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: teal),
                        ),
                        hintText: "Note",
                        hintStyle: TextStyle(
                          color: primary,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    selectedContainerIndex == 1
                        ?
                        //container for the income
                        Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              border: Border.all(color: teal),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                key: widgetKey,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        const Text(
                                          "Categories : ",
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        snapshot2.incomeCategoryName.isEmpty
                                            ? Text(
                                                "Others",
                                                style: TextStyle(
                                                    color: black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : Text(
                                                snapshot2.incomeCategoryName,
                                                style: TextStyle(
                                                    color: black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 100,
                                    child: Wrap(
                                      children: List.generate(
                                        snapshot2.incomeContainerList.length,
                                        (index) {
                                          return GestureDetector(
                                            onTap: () {
                                              snapshot2
                                                  .incomeSelectedContainerColorChange(
                                                      snapshot2
                                                          .incomeContainerList[
                                                              index]
                                                          .containerIndex);
                                              iconCategory = snapshot2
                                                  .incomeContainerList[index]
                                                  .icon;
                                              bgColorOfContainer = snapshot2
                                                  .incomeContainerList[index]
                                                  .bgcolor;
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.all(8),
                                              padding: const EdgeInsets.only(
                                                right: 5.0,
                                              ),
                                              decoration: BoxDecoration(
                                                color: snapshot2
                                                            .incomeContainerList[
                                                                index]
                                                            .containerIndex ==
                                                        snapshot2
                                                            .incomeSelectedIndex
                                                    ? snapshot2
                                                        .incomeContainerList[
                                                            index]
                                                        .bgcolor
                                                    : white,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                                border: Border.all(
                                                  color: snapshot2
                                                              .incomeContainerList[
                                                                  index]
                                                              .containerIndex ==
                                                          snapshot2
                                                              .incomeSelectedIndex
                                                      ? snapshot2
                                                          .incomeContainerList[
                                                              index]
                                                          .bgcolor
                                                      : Colors.grey.shade500,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: snapshot2
                                                        .incomeContainerList[
                                                            index]
                                                        .bgcolor,
                                                    radius: 15,
                                                    child: Icon(
                                                      snapshot2
                                                          .incomeContainerList[
                                                              index]
                                                          .icon,
                                                      size: 20,
                                                      color: black,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  FittedBox(
                                                    child: Text(
                                                      snapshot2
                                                          .incomeContainerList[
                                                              index]
                                                          .text,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        :
                        //container for the expense
                        Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              border: Border.all(color: teal),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                key: widgetKey,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        const Text(
                                          "Categories :",
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        snapshot2.expenseCategoryName.isEmpty
                                            ? Text(
                                                "Others",
                                                style: TextStyle(
                                                    color: black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : Text(
                                                snapshot2.expenseCategoryName,
                                                style: TextStyle(
                                                    color: black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: isExpanded ? 130 : childHeight + 20,
                                    child: Wrap(
                                      children: List.generate(
                                        isExpanded
                                            ? 5
                                            : snapshot2
                                                .expenseContainerList.length,
                                        (index) {
                                          return GestureDetector(
                                            onTap: () {
                                              snapshot2
                                                  .expenseSelectedContainerColorChange(
                                                      snapshot2
                                                          .expenseContainerList[
                                                              index]
                                                          .containerIndex);
                                              iconCategory = snapshot2
                                                  .expenseContainerList[index]
                                                  .icon;
                                              bgColorOfContainer = snapshot2
                                                  .expenseContainerList[index]
                                                  .bgcolor;
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.all(8),
                                              padding: const EdgeInsets.only(
                                                right: 5.0,
                                              ),
                                              decoration: BoxDecoration(
                                                color: snapshot2
                                                            .expenseContainerList[
                                                                index]
                                                            .containerIndex ==
                                                        snapshot2
                                                            .expenseSelectedIndex
                                                    ? snapshot2
                                                        .expenseContainerList[
                                                            index]
                                                        .bgcolor
                                                    : white,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                                border: Border.all(
                                                  color: snapshot2
                                                              .expenseContainerList[
                                                                  index]
                                                              .containerIndex ==
                                                          snapshot2
                                                              .expenseSelectedIndex
                                                      ? snapshot2
                                                          .expenseContainerList[
                                                              index]
                                                          .bgcolor
                                                      : Colors.grey.shade500,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: snapshot2
                                                        .expenseContainerList[
                                                            index]
                                                        .bgcolor,
                                                    radius: 15,
                                                    child: Icon(
                                                      snapshot2
                                                          .expenseContainerList[
                                                              index]
                                                          .icon,
                                                      size: 20,
                                                      color: black,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  FittedBox(
                                                    child: Text(
                                                      snapshot2
                                                          .expenseContainerList[
                                                              index]
                                                          .text,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        isExpanded
                                            ? ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: white,
                                                    elevation: 0),
                                                onPressed: () {
                                                  findHeight();
                                                  setState(() {
                                                    isExpanded = false;
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.arrow_downward_outlined,
                                                  size: 12,
                                                  color: black,
                                                ),
                                                label: Text(
                                                  "View All",
                                                  style: TextStyle(
                                                      color: black,
                                                      fontSize: 12),
                                                ),
                                              )
                                            : ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: white,
                                                    elevation: 0),
                                                onPressed: () {
                                                  setState(() {
                                                    isExpanded = true;
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.arrow_upward_outlined,
                                                  size: 12,
                                                  color: black,
                                                ),
                                                label: Text(
                                                  "View Less",
                                                  style: TextStyle(
                                                      color: black,
                                                      fontSize: 12),
                                                )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 50,
                    ),
                    isEdit
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: teal,
                                minimumSize: const Size(350, 50)),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                snapshot.updateListElements(
                                  titleController: titleController.text.trim(),
                                  widgetTitle: widget.title!,
                                  noteController: noteController.text.trim(),
                                  widgetNote: widget.note!,
                                  amountController:
                                      int.parse(amountController.text.trim()),
                                  widgetAmount: widget.amount!,
                                );
                              }
                            },
                            child: const Text(
                              "Update",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: teal,
                                minimumSize: const Size(350, 50)),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                final access = ValueOfTextForm(
                                  int.parse(amountController.text.trim()),
                                  noteController.text.trim(),
                                  titleController.text.trim(),
                                  selectedContainerIndex,
                                  //saving the icon to access in the homepage.
                                  iconCategory,
                                  //saving the bgColor to access in the homepage.
                                  bgColorOfContainer,
                                );
                                selectedContainerIndex == 1
                                    ? snapshot.addingIncome(access, context)
                                    : snapshot.addingExpense(access, context);

                                if (selectedContainerIndex == 2) {
                                  snapshot3.totalRemSpend(
                                    snapshot2.expenseCategoryName,
                                    spendAmount: int.parse(
                                      amountController.text.trim(),
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  findHeight() {
    final RenderBox renderBox =
        widgetKey.currentContext!.findRenderObject() as RenderBox;
    childHeight = renderBox.size.height;
  }
}
