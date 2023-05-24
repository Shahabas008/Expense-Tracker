import 'package:flutter/material.dart';

import '../utils/colors.dart';

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        title:  Text(
          "More",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: black
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.payment_outlined,
                  color: black,
                ),
                 SizedBox(
                  width: size.width*0.1,
                ),
                Column(
                  children: [
                    Text(
                      "Accounts",
                      style: TextStyle(
                        color: black,
                      ),
                    ),
                    Text(
                      "Overall : ",//display the current total amount
                      style: TextStyle(
                        color: black,
                      ),
                    ),
                  ],
                ),
             const Spacer(),
                TextButton(onPressed: () {}, child:  Text("ADD NEW",
                style: TextStyle(
                  color: teal,
                ),)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
