import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management_app/UI/home/homepage.dart';
import 'model.dart';

class AddListProvider extends ChangeNotifier {
  //Variables
  int incomeHome = 0;
  int expenseHome = 0;
  int balanceHome = 0;
  late int selectedIndexHome;
  String currentDate = DateFormat('EEE, MMM dd, yyyy').format(DateTime.now());
  String currentTime = DateFormat("hh:mm a").format(DateTime.now());
  ValueNotifier<List<ValueOfTextForm>> incomeTextFormValues = ValueNotifier([]);

  //Functions
  void addingIncome(ValueOfTextForm value, BuildContext context) {
    incomeTextFormValues.value.add(value);
    incomeHome += value.incomeAmount;
    balanceHome += value.incomeAmount;
    selectedIndexHome = value.selectedIndexHome;
    Navigator.pop(context);
    notifyListeners();
  }

  void addingExpense(ValueOfTextForm value, BuildContext context) {
    incomeTextFormValues.value.add(value);
    balanceHome = balanceHome - value.expenseAmount;
    expenseHome += value.expenseAmount;
    selectedIndexHome = value.selectedIndexHome;
    Navigator.pop(context);
    notifyListeners();
  }

  //Updating the elements of the list in the updating page
  void updateListElements({
    required String titleController,
    required String widgetTitle,
    required int incomeAmountController,
    required int expenseAmountController,
    required int widgetIncomeAmount,
    required int widgetExpenseAmount,
    required String noteController,
    required String widgetNote,
    required BuildContext context,
    required int widgetSelectedContainerIndex,
    required int currentContainerIndex,
    required IconData icon,
    required IconData widgetIcon,
    required Color widgetContainerColor,
    required Color currentContainerColor,
  }) {
    //Fetching the index of the elements.
    final titleIndex = incomeTextFormValues.value
        .indexWhere((element) => element.title == widgetTitle);
    final noteIndex = incomeTextFormValues.value
        .indexWhere((element) => element.note == widgetNote);
    final incomeAmountIndex = incomeTextFormValues.value
        .indexWhere((element) => element.incomeAmount == widgetIncomeAmount);
    final expenseAmountIndex = incomeTextFormValues.value
        .indexWhere((element) => element.expenseAmount == widgetExpenseAmount);
    final selectedContainerIndex = incomeTextFormValues.value.indexWhere(
        (element) => element.selectedIndexHome == widgetSelectedContainerIndex);
    final iconIndex = incomeTextFormValues.value
        .indexWhere((element) => element.categoryIcon == widgetIcon);
    final containerColorIndex = incomeTextFormValues.value.indexWhere(
        (element) => element.bgColorOfContainer == widgetContainerColor);
    //If statement
    if (titleIndex != -1 &&
        noteIndex != -1 &&
        incomeAmountIndex != -1 &&
        expenseAmountIndex != -1 &&
        selectedContainerIndex != -1 &&
        iconIndex != -1 &&
        containerColorIndex != -1) {
      incomeTextFormValues.value[titleIndex].title = titleController;
      incomeTextFormValues.value[noteIndex].note = noteController;
      incomeTextFormValues.value[incomeAmountIndex].incomeAmount =
          currentContainerIndex == 1 ? incomeAmountController : 0;
      incomeTextFormValues.value[expenseAmountIndex].expenseAmount =
          currentContainerIndex == 2 ? expenseAmountController : 0;
      incomeTextFormValues.value[selectedContainerIndex].selectedIndexHome =
          currentContainerIndex;
      incomeTextFormValues.value[iconIndex].categoryIcon = icon;
      incomeTextFormValues.value[containerColorIndex].bgColorOfContainer =
          currentContainerColor;

      //updating the incomeHome and balanceHome
      incomeHome = incomeHome - widgetIncomeAmount;
      incomeHome = incomeHome +
          incomeTextFormValues.value[incomeAmountIndex].incomeAmount;
      balanceHome = balanceHome - widgetIncomeAmount;
      balanceHome = balanceHome +
          incomeTextFormValues.value[incomeAmountIndex].incomeAmount;
      //updating the expenseHome and balanceHome
      expenseHome = expenseHome - widgetExpenseAmount;
      expenseHome = expenseHome +
          incomeTextFormValues.value[expenseAmountIndex].expenseAmount;
      balanceHome = balanceHome + widgetExpenseAmount;
      balanceHome = balanceHome -
          incomeTextFormValues.value[expenseAmountIndex].expenseAmount;
      notifyListeners();
    } else {
      log('Error');
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
    notifyListeners();
  }

  //removing the list from the homepage and updating the amount and balance
  void removeListFromHomePage(
      {required BuildContext context,
      required String widgetTitle,
      required int incomeWidgetAmount,
      required int expenseWidgetAmount,
      required int selectedContainerIndex}) {
    final index = incomeTextFormValues.value
        .indexWhere((element) => element.title == widgetTitle);
    incomeTextFormValues.value.removeAt(index);
    incomeHome = incomeHome - incomeWidgetAmount;
    expenseHome = expenseHome - expenseWidgetAmount;
    selectedContainerIndex == 1
        ? balanceHome = balanceHome - incomeWidgetAmount
        : balanceHome = balanceHome + expenseWidgetAmount;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }
}
