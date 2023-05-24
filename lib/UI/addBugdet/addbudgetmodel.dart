import 'package:flutter/material.dart';

class AddBudgetModel {
  IconData icon;
  String text;
  Color bgcolor;
  int containerIndex;
  bool boolean;
  AddBudgetModel(
      this.boolean, this.containerIndex, this.text, this.bgcolor, this.icon);
}
