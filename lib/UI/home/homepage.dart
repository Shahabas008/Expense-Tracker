import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management_app/UI/addBugdet/addbudget.dart';
import 'package:money_management_app/UI/home/provider.dart';
import 'package:money_management_app/utils/animation.dart';
import 'package:money_management_app/utils/gradienttext.dart';
import 'package:provider/provider.dart';
import '../../utils/colors.dart';
import '../addBugdet/addbudgetprovider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Consumer2<AddListProvider, AddBudgetProvider>(
      builder: (context, snapshot, snapshot2, _) {
        return Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: white,
            title: GradientText(
              "Coin Control",
              gradient: LinearGradient(
                colors: [
                  teal,
                  teal,
                  Colors.black,
                ],
              ),
              style: const TextStyle(fontSize: 40),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: height,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            currentDate = currentDate.subtract(
                              const Duration(
                                days: 30,
                              ),
                            );
                          });
                        },
                        icon: const Icon(
                          Icons.chevron_left,
                          color: Colors.black,
                          size: 18.0,
                        ),
                      ),
                      Text(
                        DateFormat('MMMM y').format(
                          currentDate,
                        ),
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            currentDate = currentDate.add(
                              const Duration(
                                days: 30,
                              ),
                            );
                          });
                        },
                        icon: const Icon(
                          Icons.chevron_right,
                          color: Colors.black,
                          size: 18.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Material(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            20,
                          ),
                        ),
                        elevation: 10.0,
                        child: Container(
                          height: height * 0.1,
                          width: width * 0.3,
                          decoration: BoxDecoration(
                            color: white,
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
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                      "Income",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: black),
                                    ),
                                    Text(
                                      '\u{20B9} ${snapshot.incomeHome}',
                                      style: TextStyle(color: black),
                                    ), // Display the amount of income
                                  ],
                                ),
                                const Icon(
                                  Icons.attach_money,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Material(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            20,
                          ),
                        ),
                        elevation: 10.0,
                        child: Container(
                          height: height * 0.1,
                          width: width * 0.3,
                          decoration: BoxDecoration(
                            color: white,
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
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                      "Expense",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: black),
                                    ),
                                    Text(
                                      "\u{20B9} ${snapshot.expenseHome}",
                                      style: TextStyle(color: black),
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
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: height * 0.05,
                    width: width * 0.35,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    height: 25.0,
                  ),
                  snapshot.isIncomeExpenseDataLoading
                      ? const CircularProgressIndicator()
                      : snapshot.incomeTextFormValues.value.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: height * 0.3,
                                  child: Image.asset(
                                    "asset/images/HOMEPAGE.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
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
                                    color: primary,
                                  ),
                                ),
                              ],
                            )
                          : Expanded(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      DateFormat('EEE d MMMM').format(
                                        DateTime.now(),
                                      ),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                    height: 3.0,
                                    thickness: 1.0,
                                    indent: 0.0,
                                    endIndent: 300.0,
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Expanded(
                                    child: ListView.separated(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return Divider(
                                          color: Colors.grey.shade300,
                                          height: 15.0,
                                          thickness: 1.0,
                                          indent: 10.0,
                                          endIndent: 10.0,
                                        );
                                      },
                                      itemCount: snapshot
                                          .incomeTextFormValues.value.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () {
                                            final itemIndex = snapshot.incomeTextFormValues.value[index];
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => AddBudget(
                                                  homePageItems: itemIndex,
                                                ),
                                              ),
                                            );
                                          },
                                          child: ListTile(
                                            // leading:
                                            //   snapshot.incomeTextFormValues
                                            //       .value[index].categoryIcon,
                                            // color: snapshot.incomeTextFormValues
                                            //     .value[index].bgColorOfContainer,
                                            //display the category icon here
                                            subtitle: Text(
                                              snapshot.incomeTextFormValues
                                                  .value[index].note,
                                              style: const TextStyle(
                                                fontSize: 15.0,
                                              ),
                                            ),
                                            title: Text(
                                              snapshot.incomeTextFormValues
                                                  .value[index].title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                            trailing: Column(
                                              children: [
                                                Text(
                                                  snapshot.incomeTextFormValues
                                                      .value[index].currentTime,
                                                  style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 111, 110, 110),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 13,
                                                ),
                                                snapshot
                                                            .incomeTextFormValues
                                                            .value[index]
                                                            .selectedIndexHome ==
                                                        1
                                                    ? Text(
                                                        "+ \u{20B9} ${snapshot.incomeTextFormValues.value[index].incomeAmount}",
                                                        style: const TextStyle(
                                                          color: Colors.green,
                                                        ),
                                                      )
                                                    : Text(
                                                        " - \u{20B9} ${snapshot.incomeTextFormValues.value[index].expenseAmount}",
                                                        style: const TextStyle(
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: white,
            foregroundColor: teal,
            elevation: 8,
            onPressed: () {
              Navigator.of(context)
                  .push(AnimationClass().navigateToAddBudgetPage());
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
