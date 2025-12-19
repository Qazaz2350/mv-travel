// import 'package:flutter/material.dart';

// class AnimatedPlane extends StatefulWidget {
//   @override
//   _AnimatedPlaneState createState() => _AnimatedPlaneState();
// }

// class _AnimatedPlaneState extends State<AnimatedPlane>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _controller;
//   late final Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat();

//     _animation = Tween<double>(
//       begin: -50,
//       end: 300,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (_, child) {
//         return Transform.translate(
//           offset: Offset(_animation.value, 0),
//           child: child,
//         );
//       },
//       child: Icon(Icons.airplanemode_active, color: Colors.white, size: 24),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }
