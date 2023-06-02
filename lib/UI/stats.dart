import 'package:flutter/material.dart';
import 'package:money_management_app/UI/home/provider.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final provider = Provider.of<AddListProvider>(context, listen: false);
    Map<String, double> data = {
      "Income": provider.incomeHome.toDouble(),
      "Expense": provider.expenseHome.toDouble(),
    };
    final colorList = <Color>[
      Colors.green,
      Colors.red,
    ];

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Statistics",
          style: TextStyle(
            color: black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: provider.expenseHome == 0 && provider.incomeHome == 0
          ? Column(
            children: [
              Center(
                  child: Image.asset("asset/stats.png",
                  width: width*0.6,
                  height: height*0.6,),
                ),
               Text("You Haven't Added Expense/Income To Show The Statistics.",
              style: TextStyle(
                color: primary,
                fontWeight: FontWeight.bold,
              ),)
            ],
          )
          : Center(
              child: PieChart(
                chartRadius: 200.0,
                dataMap: data,
                colorList: colorList,
              ),
            ),
    );
  }
}
