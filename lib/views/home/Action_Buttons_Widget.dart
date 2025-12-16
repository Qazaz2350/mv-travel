import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/commen/half_button.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/utilis/nav.dart';
import 'package:mvtravel/view_model/home_page_viewmodel.dart';
import 'package:mvtravel/views/visa_application_screen/visa_application_view.dart';

class ActionButtonsWidget extends StatelessWidget {
  final HomePageViewModel viewModel;

  const ActionButtonsWidget({Key? key, required this.viewModel})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: ActionButton(
              textColor: AppColors.white,
              text: "All Applications",
              bgColor: AppColors.blue2,
              onTap: () {
                Nav.push(context, ApplicationsStatusScreen());
              },
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: ActionButton(
              textColor: AppColors.white,
              text: "Apply for Visa",
              bgColor: AppColors.blue3,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
