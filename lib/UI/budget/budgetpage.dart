import 'package:flutter/material.dart';
import 'package:money_management_app/widget/listtilebudgetwidget.dart';
import 'package:provider/provider.dart';
import '../../utils/colors.dart';
import '../home/provider.dart';
import 'budget_model.dart';
import 'budget_provider.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({Key? key}) : super(key: key);

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  @override
  void initState() {
    final budgetProvider = Provider.of<BudgetProvider>(context , listen: false);
    budgetProvider.getBudgetElement();
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Consumer2<BudgetProvider, AddListProvider>(
      builder: (context, snapshot, snapshot2, _) {
        return Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: white,
            title: Text(
              "Budget",
              style: TextStyle(fontWeight: FontWeight.bold, color: black),
            ),
          ),
          body: Column(
            children: [
              snapshot.budgetedList.isEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          width: width * 0.65,
                          height: height * 0.25,
                          child: Image.asset(
                            "asset/images/notbudgeted.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        const Text(
                          "Budget Not Set For This Month",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Total Budget",
                              style: TextStyle(
                                  color: black, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "\u{20B9} ${snapshot.totalBudget}",
                              style: TextStyle(
                                color: black,
                              ),
                            ), // display the budget
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Total Spend",
                              style: TextStyle(
                                  color: black, fontWeight: FontWeight.bold),
                            ),

                            Text(
                              "\u{20B9} ${snapshot.totalspendAmount}",
                              style: const TextStyle(color: Colors.red),
                            ), // display the Spend
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Total Remaining",
                              style: TextStyle(
                                  color: black, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "\u{20B9} ${snapshot.totalRemaining}",
                              style: TextStyle(color: teal),
                            ), // display the Left
                          ],
                        ),
                      ],
                    ),
              const SizedBox(
                height: 15,
              ),
              snapshot.budgetedList.isEmpty
                  ? const Text(
                      "",
                    )
                  : Text(
                      "Budgeted Categories",
                      style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              Visibility(
                visible: snapshot.budgetedList.isNotEmpty,
                child: SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.budgetedList.length,
                    itemBuilder: (context, index) {
                      BudgetModel category = snapshot.budgetedList[index];
                      return ListTileWidget(
                        category: category.categories,
                        icon: category.icon,
                        isBudgeted: true,
                        spendAmount: snapshot.budgetedList[index].spendAmount,
                        remainingAmount: category.remainingAmount,
                        id: snapshot.budgetedList[index].id!,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Not Budgeted Categories",
                style: TextStyle(
                  color: black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.nonBudgetedList.length,
                  itemBuilder: (context, index) {
                    BudgetModel category = snapshot.nonBudgetedList[index];
                    return ListTileWidget(
                      category: category.categories,
                      icon: category.icon,
                      isBudgeted: category.isBudgeted,
                      spendAmount: snapshot.nonBudgetedList[index].spendAmount,
                      id: snapshot.nonBudgetedList[index].id!,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
