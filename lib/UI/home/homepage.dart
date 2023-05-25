import 'package:flutter/material.dart';
import 'package:money_management_app/UI/addBugdet/addbudget.dart';
import 'package:money_management_app/UI/home/provider.dart';
import 'package:provider/provider.dart';
import '../../utils/colors.dart';
import '../addBugdet/addBudgetprovider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<AddListProvider, AddBudgetProvider>(
      builder: (context, snapshot, snapshot2, _) {
        return Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: white,
            title: Text(
              'Date',
              style: TextStyle(color: black, fontWeight: FontWeight.bold),
            ),
            // actions: [
            //   Row(
            //     children: [
            //       Text(
            //         'Monthly  ',
            //         style: TextStyle(color: black, fontWeight: FontWeight.bold),
            //       ),
            //       Icon(
            //         Icons.arrow_drop_down_outlined,
            //         color: black,
            //       )
            //     ],
            //   )
            // ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 55,
                      width: 150,
                      decoration: BoxDecoration(
                        color: teal,
                        border: Border.all(
                          color: primary,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            20,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Income",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: white),
                                ),
                                Text(
                                  '\u{20B9} ${snapshot.incomeHome}',
                                  style: TextStyle(color: white),
                                ), // Display the amount of income
                              ],
                            ),
                            const Icon(
                              Icons.attach_money,
                              color: Colors.green,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 55,
                      width: 150,
                      decoration: BoxDecoration(
                        color: teal,
                        border: Border.all(
                          color: primary,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            20,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Expense",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: white),
                                ),
                                Text(
                                  "\u{20B9} ${snapshot.expenseHome}",
                                  style: TextStyle(color: white),
                                ), // Display the amount of income
                              ],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.money_off,
                              color: Colors.red,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 40,
                  width: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: teal,
                    border: Border.all(
                      color: primary,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        20,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Balance  :",
                          style: TextStyle(
                            color: white,
                          ),
                        ),
                        Text(
                          "\u{20B9} ${snapshot.balanceHome}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 0.5,
                  color: black,
                ),
                const SizedBox(
                  height: 15,
                ),
                snapshot.incomeTextFormValues.isEmpty
                    ? Column(
                        children: [
                          Image.asset(
                            "asset/homepage.png",
                            width: 250,
                            height: 250,
                          ),
                          Text(
                            "No Transactions",
                            style: TextStyle(
                                color: black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Tap on '+' to add Income/Expense",
                            style: TextStyle(
                              color: black,
                            ),
                          ),
                        ],
                      )
                    : Expanded(
                        child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: snapshot.incomeTextFormValues.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 2, color: primary),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              leading: Icon(
                                snapshot
                                    .incomeTextFormValues[index].categoryIcon,
                              ),
                              //display the category icon here
                              subtitle: Text(
                                  snapshot.incomeTextFormValues[index].note),
                              title: Text(
                                  snapshot.incomeTextFormValues[index].title),
                              trailing: snapshot.incomeTextFormValues[index]
                                          .selectedIndexHome ==
                                      1
                                  ? Text(
                                      "+ \u{20B9} ${snapshot.incomeTextFormValues[index].amount}",
                                      style: const TextStyle(
                                        color: Colors.green,
                                      ),
                                    )
                                  : Text(
                                      " - \u{20B9} ${snapshot.incomeTextFormValues[index].amount}",
                                      style: const TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: teal,
            foregroundColor: white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddBudget()),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
