import 'package:decora_admin/activity/controller/activity_controller.dart';
import 'package:decora_admin/activity/model/activity_model.dart';
import 'package:decora_admin/activity/service/activity_type.dart';
import 'package:decora_admin/activity/view/activity_add_page.dart';
import 'package:decora_admin/activity/view/activity_card.dart';
import 'package:decora_admin/resource/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
//import 'package:skeletonizer/skeletonizer.dart';

import '../../resource/font_manager.dart';
import '../../resource/styles_manager.dart';

class ActivityPage extends StatefulWidget {
  ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  var controller = Get.put(ActivityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: ColorManager.white,
          onPressed: () => Get.back(),
        ),
        backgroundColor: ColorManager.primary,
        title: Text(
          "School Activity",
          style: getRFStyle(color: ColorManager.white, fontSize: FontSize.s14),
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Get Past', 'Up coming'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
/*
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  ),
                  hintText: 'Enter the search text...',
                  label: Text("search")),
            ),
          ),
*/
          Expanded(
            child: FutureBuilder(
              future: controller.fetchData(
                  activityType: controller.activityType.value),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.builder(
                    itemCount:
                        controller.activityModel.value.records?.length ?? 0,
                    itemBuilder: (context, index) => 
                      ActivityCard(
                      activityRecord: ActivityRecord(),
                      colorIndex: 3,
                      refresh: () {
                            setState(() {});
                      },
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  controller.count=0;
                  return ListView.builder(
                    itemCount:
                        controller.activityModel.value.records?.length ?? 0,
                    itemBuilder: (context, index) {
                      if (controller.count == 3) controller.count = 0;
                      return ActivityCard(
                        activityRecord:
                            controller.activityModel.value.records![index],
                        colorIndex: controller.count++,
                        refresh: () {
                              setState(() {});
                        },
                      );
                    },
                  );
                }
                return const Center(child: Text("NO Data!!!"));
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorManager.primary,
        onPressed: () async {
          await Get.to(() => ActivityAddPage(refresh: () {
            setState(() {});
          }));
        },
        child: Icon(
          Icons.add,
          size: 32.h,
        ),
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case "Get Past":
        setState(() {
          controller.activityType.value=ActivityType.GetAllActivityPast;
        });
        break;
      case  'Up coming':
        setState(() {
          controller.activityType.value=ActivityType.GetAllActivityUpcoming;
        });
        break;
    }
  }
}
