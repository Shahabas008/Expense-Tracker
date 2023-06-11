import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_management_app/UI/addBugdet/addbudgetprovider.dart';
import 'package:money_management_app/UI/home/model.dart';
import 'package:money_management_app/UI/home/provider.dart';
import 'package:money_management_app/utils/snackbars.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../budget/budget_provider.dart';

class AddBudget extends StatefulWidget {
  const AddBudget(
      {Key? key,
      this.incomeAmount,
      this.expenseAmount,
      this.title,
      this.note,
      this.selectedContainer,
      this.icon,
      this.bgColor,
      this.id})
      : super(key: key);
  final int? id;
  final int? incomeAmount;
  final int? expenseAmount;
  final String? title;
  final String? note;
  final int? selectedContainer;
  final String? icon;
  final String? bgColor;

  @override
  State<AddBudget> createState() => _AddBudgetState();
}

class _AddBudgetState extends State<AddBudget> {
  TextEditingController incomeAmountController = TextEditingController();
  TextEditingController expenseAmountController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  int selectedContainerIndex = 1;
  Color container1Color = teal;
  Color container2Color = Colors.grey;
  bool isExpanded = true;
  GlobalKey widgetKey = GlobalKey();
  double childHeight = 0.0;
  IconData? iconCategory;
  Color bgColorOfContainer = Colors.transparent;
  bool isEdit = false;
  String categoryName = "";
  String? currentDate;
  String? currentTime;

  @override
  void initState() {
    super.initState();
    if (widget.title != null) {
      isEdit = true;
      final incomeAmount = widget.incomeAmount;
      final expenseAmount = widget.expenseAmount;
      final title = widget.title;
      final note = widget.note;
      final selectedWidgetContainerIndex = widget.selectedContainer;
      incomeAmountController.text = incomeAmount!.toString();
      expenseAmountController.text = expenseAmount!.toString();
      titleController.text = title!;
      noteController.text = note!;
      selectedContainerIndex = selectedWidgetContainerIndex!;
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
    setState(() {
      currentDate = DateFormat('EEE, MMM dd, yyyy').format(DateTime.now());
      currentTime = DateFormat("hh:mm a").format(DateTime.now());
    });
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: black,
              ),
            ),
            actions: [
              isEdit
                  ? IconButton(
                      onPressed: () {
                        //Deleting the category from the list
                        snapshot.removeListFromHomePage(
                          id: widget.id!,
                            // incomeWidgetAmount: widget.incomeAmount!,
                            // expenseWidgetAmount: widget.expenseAmount!,
                            // widgetTitle: widget.title!,
                            // context: context,
                            // selectedContainerIndex: selectedContainerIndex,
                            );
                            Navigator.pop(context);
                           
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
                      children: [
                        GestureDetector(
                          onTap: () {
                            changeColor(1);
                          },
                          child: Material(
                            color: white,
                            elevation: 8,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            shadowColor: selectedContainerIndex == 1
                                ? Colors.transparent
                                : black,
                            child: Container(
                              height: height * 0.05,
                              width: width * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                border: Border.all(
                                  color: selectedContainerIndex == 1
                                      ? container1Color
                                      : container2Color,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Income",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: selectedContainerIndex == 1
                                          ? black
                                          : primary,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_upward_outlined,
                                    color: selectedContainerIndex == 1
                                        ? Colors.green
                                        : primary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        GestureDetector(
                          onTap: () {
                            changeColor(2);
                            selectedContainerIndex = 2;
                          },
                          child: Material(
                            color: white,
                            elevation: 8,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            shadowColor: selectedContainerIndex == 2
                                ? Colors.transparent
                                : black,
                            child: Container(
                              height: height * 0.05,
                              width: width * 0.3,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                  color: selectedContainerIndex == 2
                                      ? container1Color
                                      : container2Color,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Expense",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: selectedContainerIndex == 2
                                          ? black
                                          : primary,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_downward_outlined,
                                    color: selectedContainerIndex == 2
                                        ? Colors.red
                                        : primary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 20.0,
                              color: primary,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              currentDate!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.access_time_outlined,
                              size: 20.0,
                              color: primary,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              currentTime!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    selectedContainerIndex == 1
                        ? TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter amount';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            cursorColor: teal,
                            controller: incomeAmountController,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primary),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: teal),
                              ),
                              hintText: "Enter Amount",
                              hintStyle: TextStyle(
                                color: primary,
                              ),
                            ),
                          )
                        : TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter amount';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            cursorColor: teal,
                            controller: expenseAmountController,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primary),
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
                          borderSide: BorderSide(color: primary),
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
                          borderSide: BorderSide(color: primary),
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
                                        Text(
                                          "Categories : ",
                                          style: TextStyle(
                                            color: primary,
                                          ),
                                        ),
                                        snapshot2.incomeCategoryName.isEmpty
                                            ? Text(
                                                "",
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
                                                      : primary,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: white,
                                                    radius: 15,
                                                    child: Icon(
                                                      snapshot2
                                                          .incomeContainerList[
                                                              index]
                                                          .icon,
                                                      size: 20,
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
                                                          : primary,
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
                                              categoryName = snapshot2
                                                  .expenseContainerList[index]
                                                  .text;
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
                                                      : primary,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: white,
                                                    radius: 15,
                                                    child: Icon(
                                                      snapshot2
                                                          .expenseContainerList[
                                                              index]
                                                          .icon,
                                                      size: 20,
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
                                                          : primary,
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
                              minimumSize: Size(width * 1.5, height * 0.07),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                final value = ValueOfTextForm(
                                  categoryName,
                                  int.parse(incomeAmountController.text.trim()),
                                  int.parse(
                                      expenseAmountController.text.trim()),
                                  noteController.text.trim(),
                                  titleController.text.trim(),
                                  selectedContainerIndex,
                                  iconCategory!.toString(),
                                  bgColorOfContainer.toString(),
                                  currentDate!,
                                  currentTime!,
                                  widget.id
                                );
                                snapshot.updateListElements(
                                  value: value,
                                  id: widget.id!,
                                );
                                snapshot.totalSpendAmount(context: context);
                                snapshot3.categorySpends();
                                snapshot3.categoryRemaining();
                                snapshot.totalRemaining(context);
                              }
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Update",
                              style: TextStyle(fontSize: 20, color: black),
                            ),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 8,
                              backgroundColor: teal,
                              minimumSize: Size(width * 1.5, height * 0.07),
                            ),
                            onPressed: () {
                              if (iconCategory == null) {
                                Snack.showSnackbar(
                                    context: context,
                                    message: "Please select a category.");
                              }
                              if (formKey.currentState!.validate()) {
                                int incomeAmount = 0;
                                int expenseAmount = 0;
                                String incomeAmountText =
                                    incomeAmountController.text.trim();
                                if (incomeAmountText.isNotEmpty) {
                                  try {
                                    incomeAmount = int.parse(incomeAmountText);
                                  } catch (e) {
                                    log("this is the Error message",
                                        name: "income");
                                  }
                                }

                                String expenseAmountText =
                                    expenseAmountController.text.trim();
                                if (expenseAmountText.isNotEmpty) {
                                  try {
                                    expenseAmount =
                                        int.parse(expenseAmountText);
                                  } catch (e) {
                                    log("this is the Error message",
                                        name: "expense");
                                  }
                                }
                                final access = ValueOfTextForm(
                                  categoryName,
                                  incomeAmount,
                                  expenseAmount,
                                  noteController.text.trim(),
                                  titleController.text.trim(),
                                  selectedContainerIndex,
                                  //saving the icon to access in the homepage.
                                  iconCategory!.toString(),
                                  //saving the bgColor to access in the homepage.
                                  bgColorOfContainer.toString(),
                                  currentDate!,
                                  currentTime!,
                                  widget.id
                                );
                                selectedContainerIndex == 1
                                    ? snapshot.addingIncome(access, context)
                                    : snapshot.addingExpense(access, context);

                                if (selectedContainerIndex == 2) {
                                  snapshot.totalSpendAmount(context: context);
                                  snapshot3.totalRemaining =
                                      snapshot3.totalBudget -
                                          snapshot.totalSpendValue;
                                  int spendAmount = 0;
                                  String expenseAmountText =
                                      expenseAmountController.text.trim();
                                  if (expenseAmountText.isNotEmpty) {
                                    try {
                                      spendAmount =
                                          int.parse(expenseAmountText);
                                    } catch (e) {
                                      log("the expense controller is null");
                                    }
                                  }
                                }
                                snapshot3.categorySpends();
                                snapshot3.categoryRemaining();
                              }
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Save",
                              style: TextStyle(
                                fontSize: 20,
                                color: black,
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
