import 'package:flutter/cupertino.dart';

class BudgetModel {
  int setLimitvalue;
  int spendAmount;
  String categories;
  bool isBudgeted;
  IconData icon;
  BudgetModel(this.setLimitvalue,this.spendAmount, this.categories, this.isBudgeted, this.icon);
}
