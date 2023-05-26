import 'dart:developer';

import 'package:flutter/material.dart';
import 'budget_model.dart';

class BudgetProvider extends ChangeNotifier {
  //VARIABLES
  int totalBudget = 0;
  int totalSpend = 0;
  int totalRemaining = 0;
  String category = '';

  List<BudgetModel> budgetedList = [];
  List<BudgetModel> nonBudgetedList = [
    BudgetModel(0,0, "Bills and Utilities", false, Icons.payment_outlined),
    BudgetModel(0,0, "Others", false, Icons.note_outlined),
    BudgetModel(0,0, "Food and Drinks", false, Icons.fastfood_outlined),
    BudgetModel(0,0, "Entertainment", false, Icons.tv),
    BudgetModel(0,0, "Investment", false, Icons.savings_outlined),
    BudgetModel(0,0, "Transportations", false, Icons.directions_bus_outlined),
    BudgetModel(0,0, "Shopping", false, Icons.shopping_bag_outlined),
    BudgetModel(0,0, "Medical", false, Icons.medical_services_outlined),
    BudgetModel(0,0, "Education", false, Icons.school_outlined),
    BudgetModel(0,0, "Gifts and Donations", false, Icons.card_giftcard_outlined),
    BudgetModel(0,0, "Insurance", false, Icons.newspaper_outlined),
    BudgetModel(0,0, "Taxes", false, Icons.money_off_csred_outlined),
  ];
  List<BudgetModel> setLimit = [];

  //FUNCTIONS

  void settingLimit(BudgetModel value) {
    if (value.isBudgeted) {
      budgetedList.add(value);
      nonBudgetedList
          .removeWhere((element) => element.categories == value.categories);
      category = value.categories;
      // notifyListeners();
    }
    setLimit.add(value);
    totalBudget += value.setLimitvalue;
    value.isBudgeted = value.setLimitvalue == 0 ? false : true;
    updateTotalBudget();
    notifyListeners();
  }

  //subtracting the amount of the category from the total budget when deleting the list from budgetList.
  void totalExpense(int totalExpenseValue) {
    totalBudget = totalBudget - totalExpenseValue;
    notifyListeners();
  }

  //Removing the List element from the BudgetList and adding to the NonBudgetList.
  void removeItems(
      {required BudgetModel budgetModel,
      required BuildContext context,
      required category}) {
    budgetedList.removeWhere((element) => element.categories == category);
    nonBudgetedList.add(budgetModel);
    budgetModel.isBudgeted = false;
    totalExpense(budgetModel.setLimitvalue);
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
    budgetedList[indexOfItem].setLimitvalue =
        int.parse(updateValueController.text.trim());
    notifyListeners();
    Navigator.pop(context);
  }

  //Updating the Total Budget after updating the set Limit value.
  void updateTotalBudget() {
    totalBudget = budgetedList.fold(0, (sum, item) => sum + item.setLimitvalue);
    notifyListeners();
  }

  //function for the total remaining and total spend
  void totalRemSpend( String categoryName, {int? spendAmount, int? remAmount})  {
    final int actualSpendAmount = spendAmount ?? 0;
    final int actualRemAmount = remAmount ?? 0;
    log(actualSpendAmount.toString(),name: "spendAmount");
    log(actualRemAmount.toString(),name: "remaining amount");
    log(categoryName);
    totalSpend = totalSpend + actualSpendAmount ;
    totalRemaining = totalBudget - totalSpend;
    for(int i=0 ; i < budgetedList.length ; i++){
      if(  categoryName == budgetedList[i].categories){
        budgetedList[i].spendAmount =  budgetedList[i].spendAmount - actualSpendAmount;
        budgetedList[i].setLimitvalue = budgetedList[i].spendAmount - actualSpendAmount;
        log(budgetedList[i].spendAmount.toString(),name:"spend amount after adding current spend ammount");
      }
    }
  }
}
