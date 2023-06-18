import 'package:flutter/material.dart';
import 'package:money_management_app/UI/Settings/Widgets/more_settings_container.dart';
import 'package:money_management_app/UI/home/provider.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<AddListProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        title: Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.bold, color: black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.payment_outlined,
                    color: black,
                  ),
                  SizedBox(
                    width: size.width * 0.1,
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
                        "Overall : ${homeProvider.balanceHome}",
                        style: const TextStyle(
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text("New Feature"),
                            content: const Text(
                                "OOPs! Sorry the team is working on it."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                    color: teal,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      "ADD NEW",
                      style: TextStyle(
                        color: teal,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              const Divider(
                color: Colors.grey,
                height: 0.5,
                thickness: 1,
              ),
              const SizedBox(
                height: 15.0,
              ),
              MoreSettingsContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
