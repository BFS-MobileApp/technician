import 'package:flutter/material.dart';

class BouncingBallsLoading extends StatefulWidget {
  final double size;
  final Color color;
  final int ballCount;
  final Duration duration;

  const BouncingBallsLoading({
    Key? key,
    this.size = 50.0,
    this.color = Colors.blue,
    this.ballCount = 3,
    this.duration = const Duration(seconds: 1),
  }) : super(key: key);

  @override
  _BouncingBallsLoadingState createState() => _BouncingBallsLoadingState();
}

class _BouncingBallsLoadingState extends State<BouncingBallsLoading> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _bounceAnimations;
  late List<Animation<double>> _scaleAnimations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();

    // Create bouncing animations
    _bounceAnimations = List.generate(
      widget.ballCount,
          (index) => Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index / widget.ballCount,
            (index + 1) / widget.ballCount,
            curve: Curves.easeInOut,
          ),
        ),
      ),
    );

    // Create scaling animations
    _scaleAnimations = List.generate(
      widget.ballCount,
          (index) => Tween<double>(
        begin: 0.8,
        end: 1.2,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index / widget.ballCount,
            (index + 1) / widget.ballCount,
            curve: Curves.easeInOut,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          widget.ballCount,
              (index) => AnimatedBuilder(
            animation: _bounceAnimations[index],
            builder: (context, child) {
              // Apply bouncing and scaling transformations
              return Transform(
                transform: Matrix4.identity()
                  ..translate(
                    0.0,
                    -_bounceAnimations[index].value * (widget.size / 2),
                  )
                  ..scale(_scaleAnimations[index].value), // Apply scaling
                child: child,
              );
            },
            child: Container(
              width: widget.size / widget.ballCount,
              height: widget.size / widget.ballCount,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
