import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_app/UI/home/model.dart';
import 'budget_model.dart';

class BudgetProvider extends ChangeNotifier {
  //VARIABLES
  int totalBudget = 0;
  int totalRemaining = 0;
  int totalspendAmount = 0;
  String category = '';
  List<BudgetModel> budgetedList = [];
  List<BudgetModel> nonBudgetedList = [
    BudgetModel(0, 0, 0, "Bills and Utilities", false,
        Icons.payment_outlined.toString(), 0),
    BudgetModel(0, 0, 0, "Others", false, Icons.note_outlined.toString(), 0),
    BudgetModel(0, 0, 0, "Food and Drinks", false,
        Icons.fastfood_outlined.toString(), 0),
    BudgetModel(0, 0, 0, "Entertainment", false, Icons.tv.toString(), 0),
    BudgetModel(
        0, 0, 0, "Investment", false, Icons.savings_outlined.toString(), 0),
    BudgetModel(0, 0, 0, "Transportations", false,
        Icons.directions_bus_outlined.toString(), 0),
    BudgetModel(
        0, 0, 0, "Shopping", false, Icons.shopping_bag_outlined.toString(), 0),
    BudgetModel(0, 0, 0, "Medical", false,
        Icons.medical_services_outlined.toString(), 0),
    BudgetModel(
        0, 0, 0, "Education", false, Icons.school_outlined.toString(), 0),
    BudgetModel(0, 0, 0, "Gifts and Donations", false,
        Icons.card_giftcard_outlined.toString(), 0),
    BudgetModel(
        0, 0, 0, "Insurance", false, Icons.newspaper_outlined.toString(), 0),
    BudgetModel(
        0, 0, 0, "Taxes", false, Icons.money_off_csred_outlined.toString(), 0),
  ];
  List<BudgetModel> setLimit = [];

  //FUNCTIONS

  Future<void> settingLimit(
      BudgetModel value, BuildContext context, int id) async {
    if (value.isBudgeted) {
      //ADDING BUDGET LIST
      final budgetListBox = await Hive.openBox<BudgetModel>("BudgetListBox");
      final budgetListId = await budgetListBox.add(value);
      value.id = budgetListId;
      await budgetListBox.put(budgetListId, value);
      budgetedList.clear();
      final budgetListBoxList = budgetListBox.values.toList();
      budgetedList.addAll(budgetListBoxList);
      // DELETING NONBUDGETED LIST
      final nonBudgetedListBox =
          await Hive.openBox<BudgetModel>('NonBudgetedListBox');
      nonBudgetedListBox.delete(id);
      nonBudgetedList
          .removeWhere((element) => element.categories == value.categories);
      category = value.categories;
      getBudgetElement();
    }
    setLimit.add(value);
    final budgetListBox = await Hive.openBox<BudgetModel>("BudgetListBox");
    final budgetListElement = budgetListBox.values.toList();
    totalBudget = 0;
    totalRemaining = 0;
    for (int i = 0; i < budgetListElement.length; i++) {
      totalBudget += budgetListElement[i].setLimitvalue;
      totalRemaining += budgetListElement[i].remainingAmount;
    }
    //ADDING THE SPEND AMOUNT TO THE BUDGET LIST
    final homePageBox = await Hive.openBox<ValueOfTextForm>("HomePageBox");
    final homePageBoxList = homePageBox.values.toList();
    for (int i = 0; i < budgetListElement.length; i++) {
      budgetListElement[i].spendAmount = 0;
      for (int j = 0; j < homePageBoxList.length; j++) {
        if (homePageBoxList[j].categoryName ==
            budgetListElement[i].categories) {
          budgetListElement[i].spendAmount += homePageBoxList[j].expenseAmount;
        }
      }
    }
    notifyListeners();
  }

  //GETTING THE DATA FROM THE HIVE AND DISPLAY IT ON THE BUDGET PAGE
  Future<void> getBudgetElement() async {
    //ADDING THE NONBUDGETEDLIST TO THE HIVE LIST
    final nonBudgetedListBox =
        await Hive.openBox<BudgetModel>('NonBudgetedListBox');
    nonBudgetedListBox.clear();
    for (int i = 0; i < nonBudgetedList.length; i++) {
      final eachElement = nonBudgetedList[i];
      final eachElementId = await nonBudgetedListBox.add(eachElement);
      await nonBudgetedListBox.put(eachElementId, eachElement);
    }
    //ADDING THE HIVE BUDGET LIST TO THE BUDGETEDLIST
    budgetedList.clear();
    final budgetListBox = await Hive.openBox<BudgetModel>("BudgetListBox");
    final budgetListBoxList = budgetListBox.values.toList();
    budgetedList.addAll(budgetListBoxList);
    //CATEGORY SPENDS ADD EXPENSE AMOUNT TO THE NONBUDGETLIST FROM THE HOMEPAGE
    categorySpends();
    //ADDING THE SPEND AMOUNT FROM THE HOMEPAGE TO BUDGET LIST
    final homePageBox = await Hive.openBox<ValueOfTextForm>("HomePageBox");
    final homePageBoxList = homePageBox.values.toList();
    for (int i = 0; i < budgetListBoxList.length; i++) {
      budgetListBoxList[i].spendAmount = 0;
      for (int j = 0; j < homePageBoxList.length; j++) {
        if (homePageBoxList[j].categoryName ==
            budgetListBoxList[i].categories) {
          budgetListBoxList[i].spendAmount += homePageBoxList[j].expenseAmount;
        }
      }
    }
    //ADDING THE TOTAL BUDGET , SPEND , REMAINING
    totalBudget = 0;
    totalRemaining = 0;
    totalspendAmount = 0;
    for (int i = 0; i < budgetListBoxList.length; i++) {
      totalBudget += budgetListBoxList[i].setLimitvalue;
      totalspendAmount += budgetListBoxList[i].spendAmount;
    }
    totalRemaining = totalBudget - totalspendAmount;
    categoryRemaining();
    notifyListeners();
  }

  //Removing the List element from the BudgetList and adding to the NonBudgetList.
  Future<void> removeItems({required amount, required id}) async {
    final budgetListBox = await Hive.openBox<BudgetModel>("BudgetListBox");
    final budgetListIndex = budgetListBox.get(id);
    budgetListIndex!.isBudgeted = false;
    totalBudget -= budgetListIndex.setLimitvalue;
    totalRemaining -= budgetListIndex.remainingAmount;
    await budgetListBox.delete(id);
    final nonBudgetedListBox =
        await Hive.openBox<BudgetModel>('NonBudgetedListBox');
    final nonBudgetedListBoxIndex =
        await nonBudgetedListBox.add(budgetListIndex);
    budgetListIndex.id = nonBudgetedListBoxIndex;
    nonBudgetedListBox.put(nonBudgetedListBoxIndex, budgetListIndex);
    notifyListeners();
  }

  //updating the list LimitValue of the specific category
  Future<void> updateItem(
      {required TextEditingController updateValueController,
      required BuildContext context,
      required category,
      required id}) async {
    final budgetListBox = await Hive.openBox<BudgetModel>("BudgetListBox");
    final budgetListIndex = budgetListBox.get(id);
    totalRemaining -= budgetListIndex!.setLimitvalue;
    totalBudget -= budgetListIndex.setLimitvalue;
    budgetListIndex.setLimitvalue =
        int.parse(updateValueController.text.trim());
    totalRemaining += budgetListIndex.setLimitvalue;
    totalBudget += budgetListIndex.setLimitvalue;
    notifyListeners();
  }

  //Function for the category spends.
  Future<void> categorySpends() async {
    final homePageBox = await Hive.openBox<ValueOfTextForm>("HomePageBox");
    final homePageBoxList = homePageBox.values.toList();
    final nonBudgetedListBox =
        await Hive.openBox<BudgetModel>('NonBudgetedListBox');
    final nonBudgetedListBoxList = nonBudgetedListBox.values.toList();
    for (int i = 0; i < nonBudgetedListBoxList.length; i++) {
      nonBudgetedListBoxList[i].spendAmount = 0;
      for (int j = 0; j < homePageBoxList.length; j++) {
        if (homePageBoxList[j].categoryName ==
            nonBudgetedListBoxList[i].categories) {
          nonBudgetedListBoxList[i].spendAmount +=
              homePageBoxList[j].expenseAmount;
        }
      }
    }
  }

  //Function for the category remaining
  Future<void> categoryRemaining() async {
    final budgetListBox = await Hive.openBox<BudgetModel>("BudgetListBox");
    final budgetListBoxList = budgetListBox.values.toList();
    for (int i = 0; i < budgetListBoxList.length; i++) {
      budgetListBoxList[i].remainingAmount = 0;
      budgetListBoxList[i].remainingAmount =
          budgetListBoxList[i].setLimitvalue - budgetListBoxList[i].spendAmount;
    }
  }
}
