import 'package:hive_flutter/adapters.dart';
part 'model.g.dart';

@HiveType(typeId: 3)
  class ValueOfTextForm {
  @HiveField(0)
  String categoryName;

  @HiveField(1)
  int incomeAmount;
  
  @HiveField(2)
  int expenseAmount;
  
  @HiveField(3)
  String title;
  
  @HiveField(4)
  String note;
  
  @HiveField(5)
  int selectedIndexHome;

  @HiveField(6)
  String categoryIcon;
  
  @HiveField(7)
  String bgColorOfContainer;
  
  @HiveField(8)
  String currentDate;
  
  @HiveField(9)
  String currentTime;

  @HiveField(10)
  int? id;

  ValueOfTextForm(
      this.categoryName,
      this.incomeAmount,
      this.expenseAmount,
      this.note,
      this.title,
      this.selectedIndexHome,
      this.categoryIcon,
      this.bgColorOfContainer,
      this.currentDate,
      this.currentTime,
      this.id
      );
}
