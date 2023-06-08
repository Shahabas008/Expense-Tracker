import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
part 'addbudgetmodel.g.dart';

@HiveType(typeId: 1)
class AddBudgetModel {
  @HiveField(0)
  IconData icon;
  @HiveField(1)
  String text;
  @HiveField(2)
  Color bgcolor;
  @HiveField(3)
  int containerIndex;
  @HiveField(4)
  bool boolean;
  AddBudgetModel(
      this.boolean, this.containerIndex, this.text, this.bgcolor, this.icon);
}
