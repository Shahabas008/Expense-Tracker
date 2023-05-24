import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_management_app/UI/addBugdet/addbudgetmodel.dart';

class AddBudgetProvider extends ChangeNotifier {
  List<AddBudgetModel> expenseContainerList = [
    AddBudgetModel(
      false,
      0,
      'Others',
      Colors.grey,
      Icons.note_outlined,
    ),
    AddBudgetModel(
      false,
      1,
      'Bills and Utilities',
      Colors.yellow.shade300,
      Icons.note_outlined,
    ),
    AddBudgetModel(
      false,
      2,
      'Food and Drinks',
      Colors.blue.shade200,
      Icons.fastfood_outlined,
    ),
    AddBudgetModel(
      false,
      3,
      'Entertainment',
      Colors.brown.shade700,
      Icons.tv,
    ),
    AddBudgetModel(
      false,
      4,
      'Investment',
      Colors.green.shade300,
      Icons.savings_outlined,
    ),
    AddBudgetModel(
      false,
      5,
      'Transportations',
      Colors.blueAccent,
      Icons.directions_bus_outlined,
    ),
    AddBudgetModel(
      false,
      6,
      'Shopping',
      Colors.pink.shade100,
      Icons.shopping_bag_outlined,
    ),
    AddBudgetModel(
      false,
      7,
      'Medical',
      Colors.indigo.shade400,
      Icons.medical_services_outlined,
    ),
    AddBudgetModel(
      false,
      8,
      'Education',
      Colors.teal.shade200,
      Icons.school_outlined,
    ),
    AddBudgetModel(
      false,
      9,
      'Gifts and Donations',
      Colors.deepOrange.shade200,
      Icons.card_giftcard_outlined,
    ),
    AddBudgetModel(
      false,
      10,
      'Insurance',
      Colors.indigo.shade100,
      Icons.newspaper_outlined,
    ),
    AddBudgetModel(
      false,
      11,
      'Tax',
      Colors.red,
      Icons.money_off_csred_outlined,
    ),
  ];
  List<AddBudgetModel> incomeContainerList = [
    AddBudgetModel(
      false,
      0,
      "Others",
      Colors.grey,
      Icons.note_outlined,
    ),
    AddBudgetModel(
        false, 1, 'Salary', Colors.lightGreen, Icons.payment_outlined),
    AddBudgetModel(
        false, 2, 'Sales', Colors.pink.shade300, Icons.trending_up_sharp),
    AddBudgetModel(
        false, 3, 'Awards', Colors.tealAccent, Icons.language_outlined),
    AddBudgetModel(false, 4, 'Business', Colors.yellowAccent, Icons.euro_outlined),
  ];

  //making the container change the color.
  int selectedIndex = 0;
  String expenseCategoryName = '';
  String incomeCategoryName = '';

  void selectedContainerColorChange(int newIndex) {
    selectedIndex = newIndex;
    for (int i = 0; i < expenseContainerList.length; i++) {
      expenseContainerList[i].boolean = false;
    }
    expenseContainerList[newIndex].boolean = true;
    expenseCategoryName = expenseContainerList[newIndex].text;
    // incomeCategoryName = incomeContainerList[newIndex].text;
    notifyListeners();
  }
}
