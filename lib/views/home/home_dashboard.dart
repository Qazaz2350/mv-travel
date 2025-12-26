import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/view_model/home_page_viewmodel.dart';

import 'package:mvtravel/views/home/tabbar/tabbar.dart';

import 'package:mvtravel/views/home/floating_buttons_widget.dart';
import 'package:mvtravel/views/home/home_header_widget.dart';
import 'package:mvtravel/views/home/searchtab.dart';
import 'package:mvtravel/widgets/shimmer.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late HomePageViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomePageViewModel();
    _viewModel.addListener(_onUpdate);
  }

  void _onUpdate() => setState(() {});

  @override
  void dispose() {
    _viewModel.removeListener(_onUpdate);
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _viewModel.isLoading
            ? const HomeShimmer()
            : RefreshIndicator(
                onRefresh: _viewModel.refreshData,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderWidget(viewModel: _viewModel),
                      SizedBox(height: 6.h),

                      SearchBarWidget(viewModel: _viewModel),
                      SizedBox(height: 20.h),

                      HomeTabbar(viewModel: _viewModel),

                      // FeaturedDestinationsWidget(
                      //   destinations: _viewModel.homeData.featuredDestinations,
                      // ),

                      // SizedBox(height: 24.h),
                      // //
                      // GestureDetector(
                      //   onTap: () {},

                      //   child: ActiveApplicationWidget(viewModel: _viewModel),
                      // ),
                      // SizedBox(height: 20.h),

                      // ActionButtonsWidget(viewModel: _viewModel),
                      // SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingButtonsWidget(),
    );
  }
}
