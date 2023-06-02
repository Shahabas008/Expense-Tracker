import 'package:flutter/cupertino.dart';

class BudgetModel {
  int setLimitvalue;
  int spendAmount;
  int remainingAmount;
  String categories;
  bool isBudgeted;
  IconData icon;
  BudgetModel(this.setLimitvalue,this.spendAmount,this.remainingAmount, this.categories, this.isBudgeted, this.icon);
}
