import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management_app/UI/addBugdet/addbudgetprovider.dart';
import 'package:money_management_app/UI/home/model.dart';
import 'package:money_management_app/UI/home/provider.dart';
import 'package:money_management_app/utils/snackbars.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../budget/budget_provider.dart';

class AddBudget extends StatefulWidget {
  const AddBudget({Key? key, this.homePageItems}) : super(key: key);
  final ValueOfTextForm? homePageItems;

  @override
  State<AddBudget> createState() => _AddBudgetState();
}

class _AddBudgetState extends State<AddBudget> {
  TextEditingController incomeAmountController = TextEditingController();
  TextEditingController expenseAmountController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isExpanded = true;
  GlobalKey widgetKey = GlobalKey();
  double childHeight = 0.0;
  Icon? iconCategory;
  Color bgColorOfContainer = Colors.transparent;
  bool isEdit = false;
  String categoryName = "";
  String? currentDate;
  String? currentTime;
  String? pickedDate;
  String? pickedTime;
  @override
  void initState() {
    super.initState();
    currentDate = DateFormat('EEE, MMM dd, yyyy').format(DateTime.now());
    currentTime = DateFormat("hh:mm a").format(DateTime.now());
    pickedDate = currentDate;
    pickedTime = currentTime;
    if (widget.homePageItems != null &&
        widget.homePageItems!.title.isNotEmpty) {
      isEdit = true;
      final incomeAmount = widget.homePageItems!.incomeAmount;
      final expenseAmount = widget.homePageItems!.expenseAmount;
      final title = widget.homePageItems!.title;
      final note = widget.homePageItems!.note;
      final selectedWidgetContainerIndex =
          widget.homePageItems!.selectedIndexHome;
      incomeAmountController.text = incomeAmount.toString();
      expenseAmountController.text = expenseAmount.toString();
      titleController.text = title;
      noteController.text = note;
      log(selectedWidgetContainerIndex.toString(),name: "this is the widget container index");
      final homeProvider = Provider.of<AddListProvider>(context, listen : false);
      homeProvider.selectedContainerIndex = selectedWidgetContainerIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          id: widget.homePageItems!.id!,
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
                            snapshot.changeColor(containerIndex: 1);
                          },
                          child: Material(
                            color: white,
                            elevation: 8,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            shadowColor:
                            snapshot.selectedContainerIndex == 1
                                ? Colors.white
                                : black,
                            child: Container(
                              height: height * 0.05,
                              width: width * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                border: Border.all(
                                  color: snapshot.selectedContainerIndex == 1
                                      ? teal
                                      : Colors.grey,
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
                                      color:
                                          snapshot.selectedContainerIndex == 1
                                              ? black
                                              : primary,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_upward_outlined,
                                    color: snapshot.selectedContainerIndex == 1
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
                            snapshot.changeColor(containerIndex: 2);
                          },
                          child: Material(
                            color: white,
                            elevation: 8,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            shadowColor: snapshot.selectedContainerIndex == 2
                                ? Colors.white
                                : black,
                            child: Container(
                              height: height * 0.05,
                              width: width * 0.3,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                  color: snapshot.selectedContainerIndex == 2
                                      ? teal
                                      : Colors.grey,
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
                                      color:
                                          snapshot.selectedContainerIndex == 2
                                              ? black
                                              : primary,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_downward_outlined,
                                    color: snapshot.selectedContainerIndex == 2
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
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.grey.shade800,
                              ),
                              onPressed: () async {
                                DateTime? pickedDateTime = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2023),
                                  lastDate: DateTime(2040),
                                );
                                String pickedDateNow =
                                    DateFormat('EEE, MMM dd, yyyy')
                                        .format(pickedDateTime!);
                                setState(() {
                                  pickedDate = pickedDateNow;
                                });
                              },
                              icon: Icon(
                                Icons.calendar_today_outlined,
                                size: 20.0,
                                color: primary,
                              ),
                              label: Text(
                                isEdit
                                    ? widget.homePageItems!.currentDate
                                    : pickedDate!,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                ),
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
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.grey.shade800,
                              ),
                              onPressed: () async {
                                TimeOfDay? pickedTimeNow = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                String pickedTimeChange =
                                    pickedTimeNow!.format(context);
                                setState(() {
                                  pickedTime = pickedTimeChange;
                                });
                              },
                              icon: Icon(
                                Icons.access_time_outlined,
                                size: 20.0,
                                color: primary,
                              ),
                              label: Text(
                                isEdit
                                    ? widget.homePageItems!.currentTime
                                    : pickedTime!,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    snapshot.selectedContainerIndex == 1
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
                    snapshot.selectedContainerIndex == 1
                        ?
                        //CATEGORY CONTAINER FOR THE INCOME
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
                                              iconCategory = Icon(snapshot2
                                                  .incomeContainerList[index]
                                                  .icon);
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
                                          "Categories : ",
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        snapshot2.expenseCategoryName.isEmpty
                                            ? Text(
                                                "",
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
                                              iconCategory = Icon(snapshot2
                                                  .expenseContainerList[index]
                                                  .icon);
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
                                if (iconCategory == null) {
                                  Snack.showSnackbar(
                                      context: context,
                                      message: "Please select a category.");
                                }
                                final value = ValueOfTextForm(
                                    categoryName,
                                    int.parse(
                                        incomeAmountController.text.trim()),
                                    int.parse(
                                        expenseAmountController.text.trim()),
                                    noteController.text.trim(),
                                    titleController.text.trim(),
                                    snapshot.selectedContainerIndex,
                                    iconCategory!.toString(),
                                    bgColorOfContainer.toString(),
                                    pickedDate!,
                                    pickedTime!,
                                    widget.homePageItems!.id);
                                snapshot.updateListElements(
                                  value: value,
                                  id: widget.homePageItems!.id!,
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
                              //To get the latest time and date, while storing data.

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
                                    snapshot.selectedContainerIndex,
                                    //saving the icon to access in the homepage.
                                    iconCategory!.toString(),
                                    //saving the bgColor to access in the homepage.
                                    bgColorOfContainer.toString(),
                                    pickedDate!,
                                    pickedTime!,
                                    0);
                                snapshot.selectedContainerIndex == 1
                                    ? snapshot.addingIncome(access, context)
                                    : snapshot.addingExpense(access, context);

                                if (snapshot.selectedContainerIndex == 2) {
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
