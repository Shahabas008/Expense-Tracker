import 'dart:developer';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../home/provider.dart';
import 'budget_model.dart';

class BudgetProvider extends ChangeNotifier {
  //VARIABLES
  int totalBudget = 0;
  int totalRemaining = 0;
  String category = '';
  List<BudgetModel> budgetedList = [];
  List<BudgetModel> nonBudgetedList = [
    BudgetModel(0, 0, "Bills and Utilities", false, Icons.payment_outlined),
    BudgetModel(0, 0, "Others", false, Icons.note_outlined),
    BudgetModel(0, 0, "Food and Drinks", false, Icons.fastfood_outlined),
    BudgetModel(0, 0, "Entertainment", false, Icons.tv),
    BudgetModel(0, 0, "Investment", false, Icons.savings_outlined),
    BudgetModel(0, 0, "Transportations", false, Icons.directions_bus_outlined),
    BudgetModel(0, 0, "Shopping", false, Icons.shopping_bag_outlined),
    BudgetModel(0, 0, "Medical", false, Icons.medical_services_outlined),
    BudgetModel(0, 0, "Education", false, Icons.school_outlined),
    BudgetModel(
        0, 0, "Gifts and Donations", false, Icons.card_giftcard_outlined),
    BudgetModel(0, 0, "Insurance", false, Icons.newspaper_outlined),
    BudgetModel(0, 0, "Taxes", false, Icons.money_off_csred_outlined),
  ];
  List<BudgetModel> setLimit = [];

  //FUNCTIONS

  void settingLimit(BudgetModel value, BuildContext context) {
    if (value.isBudgeted) {
      budgetedList.add(value);
      nonBudgetedList
          .removeWhere((element) => element.categories == value.categories);
      category = value.categories;
      // notifyListeners();
    }
    setLimit.add(value);
    totalBudget += value.setLimitvalue;
    totalRemaining += value.setLimitvalue;
    final provider = Provider.of<AddListProvider>(context, listen: false);
    provider.totalSpendAmount(context: context);
    totalRemaining = totalBudget - provider.totalSpendValue;
    value.isBudgeted = value.setLimitvalue == 0 ? false : true;
    updateTotalBudget();
    notifyListeners();
  }

  //Removing the List element from the BudgetList and adding to the NonBudgetList.
  void removeItems(
      {required BudgetModel budgetModel,
      required BuildContext context,
      required category,
      required amount}) {
    budgetedList.removeWhere((element) => element.categories == category);
    nonBudgetedList.add(budgetModel);
    budgetModel.isBudgeted = false;
    totalBudget = totalBudget - budgetModel.setLimitvalue;
    totalRemaining = totalRemaining - int.parse(amount);
    Navigator.pop(context);
    notifyListeners();
  }

  //updating the list LimitValue of the specific category
  void updateItem(
      {required TextEditingController updateValueController,
      required BuildContext context,
      required category}) {
    int indexOfItem = budgetedList.indexWhere(
      (element) => element.categories == category,
    );
    totalRemaining = totalRemaining - budgetedList[indexOfItem].setLimitvalue;
    totalBudget = totalBudget - budgetedList[indexOfItem].setLimitvalue;
    budgetedList[indexOfItem].setLimitvalue =
        int.parse(updateValueController.text.trim());
    totalRemaining = totalRemaining + budgetedList[indexOfItem].setLimitvalue;
    totalBudget = totalBudget + budgetedList[indexOfItem].setLimitvalue;
    notifyListeners();
    Navigator.pop(context);
  }

  //Updating the Total Budget after updating the set Limit value.
  void updateTotalBudget() {
    totalBudget = budgetedList.fold(0, (sum, item) => sum + item.setLimitvalue);
    notifyListeners();
  }

  //Function for the category spends.
  void categorySpends(BuildContext context) {
    final homeProvider = Provider.of<AddListProvider>(context, listen: false);
    for (int i = 0; i < homeProvider.incomeTextFormValues.value.length; i++) {
      for (int j = 0; j < nonBudgetedList.length; j++) {
        if (homeProvider.incomeTextFormValues.value[i].categoryName ==
            nonBudgetedList[j].categories) {
          nonBudgetedList[i].spendAmount = 0;
          nonBudgetedList[i].spendAmount +=
              homeProvider.incomeTextFormValues.value[i].expenseAmount;
          log(nonBudgetedList[i].spendAmount.toString(),
              name: "this is the spend amount from the nonbudgetedlist");
          log(nonBudgetedList[i].categories.toString(),
              name: "this is the category name from the nonbudgetedlist");
          break; // Break the inner loop once a match is found
        }
      }
    }
  }
}
