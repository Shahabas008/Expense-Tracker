import 'package:flutter/material.dart';
import 'package:money_management_app/UI/addBugdet/addbudget.dart';
import 'package:money_management_app/UI/bottomnavigationbar.dart';
import 'package:money_management_app/UI/budget/budget_provider.dart';
import 'package:money_management_app/UI/budget/budgetpage.dart';
import 'package:money_management_app/UI/home/homepage.dart';
import 'package:money_management_app/UI/home/provider.dart';
import 'package:money_management_app/UI/morepage.dart';
import 'package:money_management_app/UI/stats.dart';
import 'package:provider/provider.dart';

import 'UI/addBugdet/addBudgetprovider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AddListProvider()),
        ChangeNotifierProvider(create: (_) => BudgetProvider()),
        ChangeNotifierProvider(create: (_) => AddBudgetProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AddBudget(),
      ),
    );
  }
}
