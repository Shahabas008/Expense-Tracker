import 'dart:developer';

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
  ValueNotifier<List<ValueOfTextForm>> incomeTextFormValues = ValueNotifier([]);

  //Functions
  void addingIncome(ValueOfTextForm value, BuildContext context) {
    incomeTextFormValues.value.add(value);
    incomeHome += value.amount;
    balanceHome += value.amount;
    selectedIndexHome = value.selectedIndexHome;
    Navigator.pop(context);
    notifyListeners();
  }

  void addingExpense(ValueOfTextForm value, BuildContext context) {
    incomeTextFormValues.value.add(value);
    balanceHome = balanceHome - value.amount;
    expenseHome += value.amount;
    selectedIndexHome = value.selectedIndexHome;
    Navigator.pop(context);
    notifyListeners();
  }

  //Updating the elements of the list in the updating page
  void updateListElements(
      {required String titleController,
      required String widgetTitle,
      required int amountController,
      required int widgetAmount,
      required String noteController,
      required String widgetNote}) {
    final titleIndex = incomeTextFormValues.value
        .indexWhere((element) => element.title == widgetTitle);
    final noteIndex = incomeTextFormValues.value
        .indexWhere((element) => element.note == widgetNote);
    final amountIndex = incomeTextFormValues.value
        .indexWhere((element) => element.amount == widgetAmount);

    if (titleIndex != -1 && noteIndex != -1 && amountIndex != -1) {
      final updatedTitleElement = titleController;
      incomeTextFormValues.value[titleIndex].title = updatedTitleElement;
      final updatedNoteElement = noteController;
      incomeTextFormValues.value[noteIndex].title = updatedNoteElement;
      final updatedAmountElement = amountController;
      incomeTextFormValues.value[titleIndex].title =
          updatedAmountElement.toString();
    } else {
      log('Error');
    }
    notifyListeners();
  }
}
