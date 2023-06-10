import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
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
    BudgetModel(
        0, 0, 0, "Bills and Utilities", false, Icons.payment_outlined.toString(), 0),
    BudgetModel(0, 0, 0, "Others", false, Icons.note_outlined.toString(), 0),
    BudgetModel(0, 0, 0, "Food and Drinks", false, Icons.fastfood_outlined.toString(), 0),
    BudgetModel(0, 0, 0, "Entertainment", false, Icons.tv.toString(), 0),
    BudgetModel(0, 0, 0, "Investment", false, Icons.savings_outlined.toString(), 0),
    BudgetModel(
        0, 0, 0, "Transportations", false, Icons.directions_bus_outlined.toString(), 0),
    BudgetModel(0, 0, 0, "Shopping", false, Icons.shopping_bag_outlined.toString(), 0),
    BudgetModel(0, 0, 0, "Medical", false, Icons.medical_services_outlined.toString(), 0),
    BudgetModel(0, 0, 0, "Education", false, Icons.school_outlined.toString(), 0),
    BudgetModel(
        0, 0, 0, "Gifts and Donations", false, Icons.card_giftcard_outlined.toString(), 0),
    BudgetModel(0, 0, 0, "Insurance", false, Icons.newspaper_outlined.toString(), 0),
    BudgetModel(0, 0, 0, "Taxes", false, Icons.money_off_csred_outlined.toString(), 0),
  ];
  List<BudgetModel> setLimit = [];

  //FUNCTIONS

  Future<void> settingLimit(BudgetModel value, BuildContext context , int id) async {
    if (value.isBudgeted) {
      //ADDING BUDGET LIST
      final budgetListBox = await Hive.openBox<BudgetModel>("BudgetListBox");
      final budgetListId = await budgetListBox.add(value);
      value.id = budgetListId;
      await budgetListBox.put(budgetListId, value);
      budgetedList.add(value);
      // DELETING NONBUDGETED LIST
       final nonBudgetedListBox =
        await Hive.openBox<BudgetModel>('NonBudgetedListBox');
      nonBudgetedListBox.delete(id);
      getBudgetElement();
      nonBudgetedList
          .removeWhere((element) => element.categories == value.categories);
      category = value.categories;
    }
    setLimit.add(value);
    //WORKING HERE
    totalBudget += value.setLimitvalue;
    totalRemaining += value.setLimitvalue;
    final provider = Provider.of<AddListProvider>(context, listen: false);
    provider.totalSpendAmount(context: context);
    totalRemaining = totalBudget - provider.totalSpendValue;
    value.isBudgeted = value.setLimitvalue == 0 ? false : true;
    updateTotalBudget();
    notifyListeners();
  }

  //GETTING THE DATA FROM THE HIVE AND DISPLAY IT ON THE BUDGET PAGE
  Future<void> getBudgetElement() async {
    final nonBudgetedListBox =
        await Hive.openBox<BudgetModel>('NonBudgetedListBox');
  for(int i = 0 ; i < nonBudgetedList.length ; i++){
    final eachElement = nonBudgetedList[i];
    final eachElementId = await nonBudgetedListBox.add(eachElement);
    await nonBudgetedListBox.put(eachElementId, eachElement);
  }

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
    for (int i = 0; i < nonBudgetedList.length; i++) {
      nonBudgetedList[i].spendAmount = 0;
      for (int j = 0; j < homeProvider.incomeTextFormValues.value.length; j++) {
        if (homeProvider.incomeTextFormValues.value[j].categoryName ==
            nonBudgetedList[i].categories) {
          nonBudgetedList[i].spendAmount +=
              homeProvider.incomeTextFormValues.value[j].expenseAmount;
        }
      }
    }
    notifyListeners();
  }

  //Function for the category remaining
  void categoryRemaining(BuildContext context) {
    final homeProvider = Provider.of<AddListProvider>(context, listen: false);
    for (int i = 0; i < budgetedList.length; i++) {
      budgetedList[i].spendAmount = 0;
      for (int j = 0; j < homeProvider.incomeTextFormValues.value.length; j++) {
        if (homeProvider.incomeTextFormValues.value[j].categoryName ==
            budgetedList[i].categories) {
          budgetedList[i].spendAmount +=
              homeProvider.incomeTextFormValues.value[j].expenseAmount;
        }
      }
    }
    for (int i = 0; i < budgetedList.length; i++) {
      budgetedList[i].remainingAmount = 0;
      budgetedList[i].remainingAmount =
          budgetedList[i].setLimitvalue - budgetedList[i].spendAmount;
    }
  }
}
