import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
part 'budget_model.g.dart';
@HiveType(typeId: 2)
class BudgetModel {
  @HiveField(0)
  int setLimitvalue;
  @HiveField(1)
  int spendAmount;
  @HiveField(2)
  int remainingAmount;
  @HiveField(3)
  String categories;
  @HiveField(4)
  bool isBudgeted;
  @HiveField(5)
  String icon;
  @HiveField(6)
  int? id;
  BudgetModel(this.setLimitvalue, this.spendAmount, this.remainingAmount,
      this.categories, this.isBudgeted, this.icon, this.id);
}
