
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../utils/colors.dart';



class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, double> data = {
      "Flutter": 5,
      "React": 3,
      "Xamarin": 2,
      "Ionic": 2,
    };

    return  Scaffold(
      backgroundColor: white,
      appBar:  AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Pie Chart",
        style: TextStyle(
          color: black
        ),),
      ),
      body:  Center(
        child:  PieChart(
          dataMap: data,
        ),
      ),
    );
  }
}
