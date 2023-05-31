import 'package:flutter/material.dart';
import 'package:money_management_app/widget/listtilebudgetwidget.dart';
import 'package:provider/provider.dart';
import '../../utils/colors.dart';
import 'budget_model.dart';
import 'budget_provider.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BudgetProvider>(
      builder: (context, snapshot, _) {
        return Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: white,
            centerTitle: true,
            title: Text(
              "Date",
              style: TextStyle(fontWeight: FontWeight.bold, color: black),
            ),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              snapshot.budgetedList.isEmpty
                  ? Column(
                      children: [
                        Image.asset(
                          "asset/notbudgeted.png",
                          width: 180,
                          height: 180,
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
                              snapshot.budgetedList.isEmpty
                                  ? "0"
                                  : "\u{20B9} ${snapshot.totalSpend}",
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
                              snapshot.budgetedList.isEmpty
                                  ? "0"
                                  : "\u{20B9} ${snapshot.totalRemaining}",
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
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
