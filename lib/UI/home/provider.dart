import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'model.dart';

class AddListProvider extends ChangeNotifier {
  //Variables
  int incomeHome = 0;
  int expenseHome = 0;
  int balanceHome = 0;
  late int selectedIndexHome;
  String currentDate = DateFormat('EEE, MMM dd, yyyy').format(DateTime.now());
  String currentTime = DateFormat("hh:mm a").format(DateTime.now());
  List<ValueOfTextForm> incomeTextFormValues = [];

  //Functions
  void addingIncome(ValueOfTextForm value, BuildContext context) {
    incomeTextFormValues.add(value);
    incomeHome += value.amount;
    balanceHome += value.amount;
    selectedIndexHome = value.selectedIndexHome;
    Navigator.pop(context);
    notifyListeners();
  }

  void addingExpense(ValueOfTextForm value, BuildContext context) {
    incomeTextFormValues.add(value);
    balanceHome = balanceHome - value.amount;
    expenseHome += value.amount;
    selectedIndexHome = value.selectedIndexHome;
    Navigator.pop(context);
    notifyListeners();
  }
}
