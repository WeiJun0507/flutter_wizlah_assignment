import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wizlah_assignment/model/person/person_info.dart';
import 'package:wizlah_assignment/pages/components/empty_state_view.dart';
import 'package:wizlah_assignment/pages/home/home_controller.dart';
import 'package:wizlah_assignment/pages/home/person/components/person_cover.dart';
import 'package:wizlah_assignment/util/color.dart';
import 'package:wizlah_assignment/util/text_style.dart';

class PersonView extends GetView<HomeController> {
  const PersonView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: Container(
          padding: const EdgeInsets.only(
            top: SysSize.paddingHuge,
            left: SysSize.paddingBig,
            right: SysSize.paddingBig,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StText.big(
                'Person',
                style: StandardTextStyle.big.copyWith(
                  fontSize: SysSize.huge,
                ),
              ),
              const SizedBox(height: SysSize.paddingBig),
              if (controller.popularPersonList.isEmpty)
                EmptyStateView(onRetry: controller.getPopularPersonList)
              else
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      controller: controller.personScrollController,
                      itemCount: controller.popularPersonList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final PersonInfo info =
                            controller.popularPersonList[index];
                        return PersonCover(
                          info: info,
                          onDetailTap: () => controller.goToPersonDetail(info),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
