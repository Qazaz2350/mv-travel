import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Header
          _shimmerBox(height: 20, width: 120),
          const SizedBox(height: 16),

          // 🔹 Search Bar
          _shimmerBox(height: 48, radius: 24),
          const SizedBox(height: 16),

          // 🔹 Categories
          Row(
            children: List.generate(
              4,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _shimmerBox(height: 36, width: 80, radius: 20),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // 🔹 Image Slider Card
          _shimmerBox(height: 180, radius: 16),
          const SizedBox(height: 24),

          // 🔹 Active Application Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _shimmerBox(height: 18, width: 160),
              _shimmerBox(height: 14, width: 60),
            ],
          ),
          const SizedBox(height: 16),

          // 🔹 Visa Card
          _shimmerBox(height: 190, radius: 16),
        ],
      ),
    );
  }

  // 🔹 Reusable Shimmer Box
  Widget _shimmerBox({
    double height = 16,
    double width = double.infinity,
    double radius = 8,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
