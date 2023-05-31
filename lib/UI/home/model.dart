import 'package:flutter/cupertino.dart';

class ValueOfTextForm {
  int incomeAmount;
  int expenseAmount;
  String title;
  String note;
  int selectedIndexHome;
  IconData categoryIcon;
  Color bgColorOfContainer;

  ValueOfTextForm(this.incomeAmount , this.expenseAmount ,this.note, this.title, this.selectedIndexHome,
      this.categoryIcon,this.bgColorOfContainer);
}
