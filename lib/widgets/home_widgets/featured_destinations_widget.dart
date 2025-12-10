import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mvtravel/utilis/FontSizes.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/model/home_page_model.dart';

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
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.88);
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.destinations.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      children: [
        SizedBox(
          height: 220.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.destinations.length,
            itemBuilder: (context, index) {
              final destination = widget.destinations[index];
              return _buildDestinationCard(destination, index);
            },
          ),
        ),
        SizedBox(height: 12.h),
        _buildPageIndicator(),
      ],
    );
  }

  Widget _buildDestinationCard(TravelDestination destination, int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 1.0;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page! - index;
          value = (1 - (value.abs() * 0.15)).clamp(0.85, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 220.h,
            child: child,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w),
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
              // Background Image
              Image.asset(destination.imageUrl, fit: BoxFit.cover),
              // Gradient Overlay
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
              // Text Content
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
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.destinations.length,
        (index) => AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: _currentPage == index ? 24.w : 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? AppColors.blue1
                : AppColors.grey1.withOpacity(0.5),
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ),
    );
  }
}
