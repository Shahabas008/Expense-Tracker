import 'package:flutter/material.dart';

import '../Model/more_settings_model.dart';
class MoreSettingsContainer extends StatelessWidget {
  MoreSettingsContainer({Key? key}) : super(key: key);
  List<MoreSettingsModel> moreSettingsList = [
    MoreSettingsModel("Change Currency",  Icons.currency_exchange_outlined,),
    MoreSettingsModel("Share", Icons.share_outlined),
    MoreSettingsModel("Rate Us", Icons.rate_review_outlined),
    MoreSettingsModel("About Developer", Icons.developer_mode_outlined),

  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height ,
      child:
        ListView.builder(
          shrinkWrap: true,
          itemCount: moreSettingsList.length,
            itemBuilder: (context , index) {
          final data = moreSettingsList[index];
          return GestureDetector(
            onTap: () {
              //NAVIGATING TO THE TILE
            },
            child: ListTile(
              leading: Icon(data.sectionIcon,
              color: Colors.black,size: 20.0,),
              title: Text(data.sectionName,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),),
                trailing: const Icon(Icons.chevron_right,
                size: 20.0,
                color: Colors.black,),
            ),
          );

        })
    );
  }
}
