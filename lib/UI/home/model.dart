import 'package:flutter/cupertino.dart';

class ValueOfTextForm {
  String categoryName;
  int incomeAmount;
  int expenseAmount;
  String title;
  String note;
  int selectedIndexHome;
  IconData categoryIcon;
  Color bgColorOfContainer;
  String currentDate;
  String currentTime;

  ValueOfTextForm(this.categoryName, this.incomeAmount , this.expenseAmount ,this.note, this.title, this.selectedIndexHome,
      this.categoryIcon,this.bgColorOfContainer,this.currentDate,this.currentTime);
}
