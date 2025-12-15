import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/model/home/home_page_model.dart';
import 'package:mvtravel/utilis/nav.dart';
// import 'package:mvtravel/view_model/featured_destinations_view_model.dart';
import 'package:mvtravel/view_model/home/featured_destinations_view_model.dart';
import 'package:mvtravel/views/homepage/visa_detail_screen/visa_detail_view.dart';
import 'package:provider/provider.dart';

class FeaturedDestinationsWidget extends StatefulWidget {
  final List<TravelDestination> destinations;

  const FeaturedDestinationsWidget({Key? key, required this.destinations})
    : super(key: key);

  @override
  State<FeaturedDestinationsWidget> createState() =>
      _FeaturedDestinationsWidgetState();
}

class _FeaturedDestinationsWidgetState
    extends State<FeaturedDestinationsWidget> {
  late FeaturedDestinationsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = FeaturedDestinationsViewModel(
      destinations: widget.destinations,
    );
    _viewModel.init();
  }

  @override
  void dispose() {
    _viewModel.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.destinations.isEmpty) return SizedBox.shrink();

    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Consumer<FeaturedDestinationsViewModel>(
        builder: (context, vm, child) => Column(
          children: [
            SizedBox(
              height: 220.h,
              child: PageView.builder(
                controller: vm.pageController,
                itemCount: vm.destinations.length,
                itemBuilder: (context, index) {
                  final destination = vm.destinations[index];
                  return _buildDestinationCard(destination, index, vm);
                },
              ),
            ),
            SizedBox(height: 12.h),
            _buildPageIndicator(vm),
          ],
        ),
      ),
    );
  }

  Widget _buildDestinationCard(
    TravelDestination destination,
    int index,
    FeaturedDestinationsViewModel vm,
  ) {
    return GestureDetector(
      onTap: () {
        // Navigate to detail page with the selected destination
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VisaDetailScreen(destination: destination),
          ),
        );
      },
      child: AnimatedBuilder(
        animation: vm.pageController,
        builder: (context, child) {
          double value = 1.0;
          if (vm.pageController.position.haveDimensions) {
            value = vm.pageController.page! - index;
            value = (1 - (value.abs() * 0.15)).clamp(0.85, 1.0);
          }
          return Center(
            child: SizedBox(
              height: Curves.easeInOut.transform(value) * 220.h,
              child: child,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(destination.imageUrl, fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.7),
                        ],
                        stops: [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20.w,
                    right: 20.w,
                    bottom: 20.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${destination.country}, ${destination.cityName}',
                          style: TextStyle(
                            fontSize: FontSizes.f20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          destination.formattedArrival,
                          style: TextStyle(
                            fontSize: FontSizes.f12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.95),
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator(FeaturedDestinationsViewModel vm) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        vm.destinations.length,
        (index) => AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: vm.currentPage == index ? 24.w : 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: vm.currentPage == index
                ? AppColors.blue1
                : AppColors.grey1.withOpacity(0.5),
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ),
    );
  }
}
