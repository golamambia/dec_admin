import 'package:decora_admin/assignmnent/controller/assignment_controller.dart';
import 'package:decora_admin/assignmnent/view/assignment_List.dart';
import 'package:decora_admin/dashboard/controller/dashboard_controller.dart';
import 'package:decora_admin/dashboard/model/dashboard_model.dart';
import 'package:decora_admin/dashboard/view/dashboard.dart';
import 'package:decora_admin/fee/view/fee_page.dart';
import 'package:decora_admin/notification/controller/notification_controller.dart';
import 'package:decora_admin/notification/view/notification_page.dart';
import 'package:decora_admin/resource/assets_manger.dart';
import 'package:decora_admin/resource/color_manager.dart';
import 'package:decora_admin/resource/font_manager.dart';
import 'package:decora_admin/resource/styles_manager.dart';
import 'package:decora_admin/util/Ams.dart';
import 'package:decora_admin/util/Icon_type.dart';
import 'package:decora_admin/util/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glass/glass.dart';

import '../../chat/controller/chat_controller.dart';
import '../../chat/view/chat_tab_view.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController _tabController;
  int _index = 0;
  final _tabIndex = 0.obs;
  late var _data;

  var controller = Get.put(DashboardController());


  @override
  void initState() {
    _data = controller.dashboardService.postDashboard();
    _tabController = TabController(vsync: this, length: 2);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: _data,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: const Center(
                      child: Text("Loading page..."),
                    ));
              }

              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Container for image and header
                      Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 180.h,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.6),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      // "${controller.dashboardService.dashboardModel.value.schoolProfile?.first.mobileAppBG != "" ? controller.dashboardService.dashboardModel.value.schoolProfile?.first.mobileAppBG : ImageAssets.networkDummyImgSchool}"
                                    "${EndPoints.baseDownloadUrl+controller.dashboardService.dashboardModel.value.schoolProfile!.first.mobileAppBG!}"
                                  ),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.3),
                                      BlendMode.darken),
                                ),
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.zero,
                                    bottom: Radius.circular(16.0))),
                            child: Column(
                              children: [
                                // menu and notification
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: controller.toggleSidebar,
                                        child: Image(
                                          image: const AssetImage(
                                              ImageAssets.iconBarWhite),
                                          width: 30.w,
                                          height: 30.h,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(()=>NotificationPage(),binding: BindingsBuilder.put(()=>NotificationController()));
                                        },
                                        child: Image(
                                          image: const AssetImage(
                                              ImageAssets.iconNoty),
                                          width: 30.w,
                                          height: 30.h,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                //school name
                                Text(
                                  // "St. Joseph International School",
                                  controller
                                          .dashboardService
                                          .dashboardModel
                                          .value
                                          .schoolProfile
                                          ?.first
                                          .branchName ??
                                      "",
                                  textAlign: TextAlign.center,
                                  style: getBFStyle(
                                      color: ColorManager.white,
                                      fontSize: FontSize.h5),
                                ),
                                Text(
                                  // "josephschool123@gmail.com",
                                  controller.dashboardService.dashboardModel
                                          .value.schoolProfile?[0].emailID ??
                                      "",
                                  style: getRFStyle(
                                      color: ColorManager.white,
                                      fontSize: FontSize.title1),
                                ),

                                Text(
                                  // "Phone: 9865305475/8952457853",
                                  "Phone: ${controller.dashboardService.dashboardModel.value.schoolProfile?[0].contactNo ?? ""}",
                                  style: getRFStyle(
                                      color: ColorManager.white,
                                      fontSize: FontSize.title1),
                                ),
                                //Email
                                //phone
                              ],
                            ),
                          ),
                          Positioned(
                              top: MediaQuery.sizeOf(context).height / 4 - 40.h,
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                width: 340.w,
                                // height: 150.h,
                                child: Column(
                                  children: [
                                    Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      children: [
                                        /*Container(
                                          width: 60.w,
                                          height: 60.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.r),
                                            color: ColorManager.grayMedium,
                                          ),
                                        ),*/
                                        Ams().imageWidget(
                                            '${EndPoints.baseDownloadUrl+controller.dashboardService.dashboardModel.value.profile![0].emp_Photo!}',
                                            width: 60.w,
                                            height: 60.h),
                                        SizedBox(
                                          width: 30.w,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              // "Mr. Narayan Murti",
                                              controller
                                                      .dashboardService
                                                      .dashboardModel
                                                      .value
                                                      .profile?[0]
                                                      .emp_Name ??
                                                  "",
                                              style: getMFStyle(
                                                  color: ColorManager.white,
                                                  fontSize: FontSize.title1),
                                            ),
                                            Text(
                                              controller
                                                      .dashboardService
                                                      .dashboardModel
                                                      .value
                                                      .profile?[0]
                                                      .emp_EmailID ??
                                                  "",
                                              style: getRFStyle(
                                                  color: ColorManager.white,
                                                  fontSize: FontSize.body),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    //card List
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        _buildInfoCard(
                                            label: "Boy's",
                                            count: controller
                                                    .dashboardService
                                                    .dashboardModel
                                                    .value
                                                    .count
                                                    ?.first
                                                    .boys ??
                                                "",
                                            imageAssets: ImageAssets.iconboy,
                                            fgColor: ColorManager.primary,
                                            bgColor: ColorManager.primaryLight),
                                        _buildInfoCard(
                                            label: "Girl's",
                                            count: controller
                                                    .dashboardService
                                                    .dashboardModel
                                                    .value
                                                    .count
                                                    ?.first
                                                    .girls ??
                                                "",
                                            imageAssets: ImageAssets.icongirl,
                                            fgColor: ColorManager.pinkDark,
                                            bgColor: ColorManager.pinkLight),
                                        _buildInfoCard(
                                            label: "P",
                                            count: controller
                                                    .dashboardService
                                                    .dashboardModel
                                                    .value
                                                    .count
                                                    ?.first
                                                    .teacherPresent ??
                                                "",
                                            imageAssets:
                                                ImageAssets.iconTeacher,
                                            iconData: Icons.telegram,
                                            fgColor: ColorManager.irisDark,
                                            bgColor: ColorManager.irisLight),
                                        _buildInfoCard(
                                            label: "A",
                                            count: controller
                                                    .dashboardService
                                                    .dashboardModel
                                                    .value
                                                    .count
                                                    ?.first
                                                    .teachertAbsent ??
                                                "",
                                            imageAssets:
                                                ImageAssets.iconTeacher,
                                            fgColor: ColorManager.stateInfo,
                                            bgColor: ColorManager.stateInfo
                                                .withOpacity(0.2)),
                                        _buildInfoCard(
                                            label: "Paid",
                                            count: controller
                                                    .dashboardService
                                                    .dashboardModel
                                                    .value
                                                    .count
                                                    ?.first
                                                    .todayCollection ??
                                                "",
                                            imageAssets:
                                                ImageAssets.iconRupeeBag,
                                            fgColor: ColorManager.secondary,
                                            bgColor:
                                                ColorManager.secondaryLight),
                                      ],
                                    )
                                  ],
                                ),
                              ).asGlass(
                                  blurX: 10.0,
                                  blurY: 10.0,
                                  clipBorderRadius:
                                      BorderRadius.circular(8.r))),
                        ],
                      ),
                      SizedBox(
                        height: 120.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: ColorManager.greyLight,
                                    width: 2.w))),
                        width: double.infinity,
                        child: TabBar(
                          controller: _tabController,
                          onTap: (value) {
                            _tabIndex.value = value;
                          },
                          dividerColor: ColorManager.primary,
                          indicatorColor: ColorManager.primary,
                          tabs: [
                            Obx(
                              () => buildTab(
                                  label: "Academics",
                                  icon: ImageAssets.academicIcon,
                                  isActive: _tabIndex.value == 0),
                            ),
                            Obx(
                              () => buildTab(
                                  label: "School",
                                  icon: ImageAssets.quickIcon,
                                  isActive: _tabIndex.value == 1),
                            ),
                           /* Obx(
                              () => buildTab(
                                  label: "Setting",
                                  icon: ImageAssets.schoolInfoIcon,
                                  isActive: _tabIndex.value == 2),
                            )*/
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 340.h,
                        child:
                            TabBarView(controller: _tabController, children: [
                          _buildWrap(
                              menuList: controller.dashboardService
                                  .dashboardModel.value.academics!,
                              iconType: AcademicType("")),
                          _buildWrap(
                              menuList: controller.dashboardService
                                  .dashboardModel.value.school!,
                              iconType: SchoolType("")),
                         /* const Center(
                            child: Text("Third Tab View"),
                          ),*/
                        ]),
                      )
                    ],
                  ),
                );
              }

              return Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: const Center(
                    child: Text("Error in loading page"),
                  ));
            }),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.r), topLeft: Radius.circular(30.r)),
          boxShadow: const [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
          child: Obx(
            () => controller
                    .dashboardService.dashboardModel.value.footer.isNotEmpty
                ? BottomNavigationBar(
                    items:
                        controller.dashboardService.dashboardModel.value.footer
                            .asMap()
                            .entries
                            .map((e) => BottomNavigationBarItem(
                                  label: '${e.value.menuName}',
                                  icon: Icon(
                                    ic[e.key],
                                    color: ColorManager.primary,
                                  ),
                                ))
                            .toList(),
                    type: BottomNavigationBarType.shifting,
                    currentIndex: 0,
                    selectedItemColor: ColorManager.primary,
                    unselectedItemColor: ColorManager.primary,
                    selectedLabelStyle: getMFStyle(
                        color: ColorManager.black, fontSize: FontSize.s10),
                    unselectedLabelStyle: getMFStyle(
                        color: ColorManager.primary, fontSize: FontSize.s10),
                    showUnselectedLabels: true,
                    iconSize: 18.h,
                    onTap: (v) {
                      var where = controller.dashboardService.dashboardModel.value.footer[v];

                      if (where.nav == "0") Get.off(() => Dashboard());
                      if (where.nav == "5") Get.to(() => AssignmentList(),binding: BindingsBuilder.put(()=>AssignmentController()));
                      if (where.nav == "2") Get.to(() => ChatTabView(),binding: BindingsBuilder.put(()=>ChatController()));
                      if (where.nav == "3") Get.to(() => FeePage());
                    },
                    elevation: 5)
                : const SizedBox(),
          ),
        ),
      ),
    );
  }

  Wrap _buildWrap(
      {required List<MenuItem> menuList, required IconButtonType iconType}) {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      children: [
        ...menuList.map(
          (menu) => _customIconButton(
              icon: Ams.getDashboardIcon(
                  iconButtonType: switch (iconType) {
                SchoolType() => SchoolType(menu.nav!),
                AcademicType() => AcademicType(menu.nav!),
                SettingType() => SettingType(menu.nav!)
              }),
              label: menu.menuName ?? "",
              fn: () {
                Ams.routeOnTap(
                    iconButtonType: switch (iconType) {
                  SchoolType() => SchoolType(menu.nav!),
                  AcademicType() => AcademicType(menu.nav!),
                  SettingType() => SettingType(menu.nav!)
                });
              }),
        )
      ],
    );
  }

  Widget _buildInfoCard(
      {required String label,
      required String count,
      IconData? iconData,
      required String imageAssets,
      required Color fgColor,
      required Color bgColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      width: 50.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r), color: bgColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: fgColor,
            radius: 16.w,
            child: SvgPicture.asset(
                width: 24.w,
                imageAssets,
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                semanticsLabel: 'A red up arrow'),
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            count,
            style: getBFStyle(
                color: ColorManager.greyDark, fontSize: FontSize.body),
          ),
          Text(
            label,
            style: getBFStyle(color: fgColor, fontSize: FontSize.body),
          ),
        ],
      ),
    );
  }

  Widget _customIconButton(
      {required String label,
      required void Function() fn,
      required String icon}) {
    return InkWell(
      onTap: fn,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Ams().imageWidget(icon, width: 100.w, height: 80.h),
          Text(
            label,
            style: getMFStyle(
                color: ColorManager.primary, fontSize: FontSize.body),
          )
        ],
      ),
    );
  }

  Tab buildTab(
      {required String label, required String icon, required bool isActive}) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //todo: this image need to change in svg for color change
          Ams().imageWidget(icon, width: 12.w, height: 12.h),
          SizedBox(
            width: 4.w,
          ),
          Text(
            label,
            style: getMFStyle(
                color: isActive ? ColorManager.primary : ColorManager.grey,
                fontSize: FontSize.body),
          )
        ],
      ),
    );
  }

  List<IconData> ic = [
    Icons.home,
    Icons.assignment,
    Icons.chat,
    Icons.payments
  ];
}
