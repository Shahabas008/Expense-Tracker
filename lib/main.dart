import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_app/UI/addBugdet/addbudgetmodel.dart';
import 'package:money_management_app/UI/budget/budget_model.dart';
import 'package:money_management_app/UI/budget/budget_provider.dart';
import 'package:money_management_app/UI/home/model.dart';
import 'package:money_management_app/UI/home/provider.dart';
import 'package:money_management_app/widget/bottomnavigationbar.dart';
import 'package:provider/provider.dart';
import 'UI/addBugdet/addbudgetprovider.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(BudgetModelAdapter().typeId)){
    Hive.registerAdapter(BudgetModelAdapter());
  }
  if(!Hive.isAdapterRegistered(AddBudgetModelAdapter().typeId)){
    Hive.registerAdapter(AddBudgetModelAdapter());
  }
  if(!Hive.isAdapterRegistered(ValueOfTextFormAdapter().typeId)){
    Hive.registerAdapter(ValueOfTextFormAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AddListProvider()),
        ChangeNotifierProvider(create: (_) => BudgetProvider()),
        ChangeNotifierProvider(create: (_) => AddBudgetProvider()),
      ],
      child:const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomNavigationBarPage(),
      ),
    );
  }
}
