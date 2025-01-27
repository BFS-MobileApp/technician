import 'package:flutter/material.dart';
import 'package:technician/feature/claim%20details/data/models/claim_details_model.dart';

class TimelineLinePainter extends CustomPainter {
  final GlobalKey timelineKey;
  final List<Log> logList;

  TimelineLinePainter({required this.timelineKey , required this.logList});

  @override
  void paint(Canvas canvas, Size size) {
    final context = timelineKey.currentContext;
    if (context == null) return; // If the context is not available, return early.

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final double listHeight = renderBox.size.height;

    // Handle the case for a single item in the list.
    double startPosition = 0.0;
    double endPosition = 0.0;

    if (logList.length == 1) {
      // Fixed size line when there's only one item.
      startPosition = size.height / 7 - 50; // Adjust the position as needed
      endPosition = startPosition + 100;    // Set a fixed line height
    } else {
      // Calculate positions for the first and last item for multiple items.
      startPosition = _getPositionOfItem(0); // Get the position of the first item
      endPosition = _getPositionOfItem(logList.length - 1); // Get the position of the last item
    }

    Paint paint = Paint()
      ..color = Colors.blue[100]!
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    // Draw the vertical line between the positions
    canvas.drawLine(
      Offset(size.width / 2, startPosition),
      Offset(size.width / 2, endPosition),
      paint,
    );
  }

  // Get the position of an item based on its index in the list
  double _getPositionOfItem(int index) {
    // Calculate the position based on the index of the item
    return 50.0 + (index * 140.0); // Adjust the multiplier based on the item size
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
