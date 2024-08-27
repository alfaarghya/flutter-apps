import 'package:flutter/material.dart';

enum SwipeDirection {
  up,
  down,
  left,
  right,
}

class SwipeDetector extends StatefulWidget {
  const SwipeDetector({
    Key? key,
    this.behavior,
    this.onSwipe,
    this.onSwipeUp,
    this.onSwipeDown,
    this.onSwipeLeft,
    this.onSwipeRight,
    required this.child,
  }) : super(key: key);

  final HitTestBehavior? behavior;
  final Widget child;
  final void Function(SwipeDirection direction)? onSwipe;
  final VoidCallback? onSwipeUp;
  final VoidCallback? onSwipeDown;
  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;

  @override
  _SwipeDetectorState createState() => _SwipeDetectorState();
}

class _SwipeDetectorState extends State<SwipeDetector> {
  late Offset _startPosition;
  late Offset _updatePosition;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: widget.behavior,
      onPanStart: (details) {
        _startPosition = details.globalPosition;
      },
      onPanUpdate: (details) {
        _updatePosition = details.globalPosition;
      },
      onPanEnd: (details) {
        final delta = _updatePosition - _startPosition;
        final direction = _getSwipeDirection(delta);
        _executeCallbacks(direction);
      },
      child: widget.child,
    );
  }

  void _executeCallbacks(SwipeDirection direction) {
    if (widget.onSwipe != null) {
      widget.onSwipe!(direction);
    }
    switch (direction) {
      case SwipeDirection.up:
        if (widget.onSwipeUp != null) {
          widget.onSwipeUp!();
        }
        break;
      case SwipeDirection.down:
        if (widget.onSwipeDown != null) {
          widget.onSwipeDown!();
        }
        break;
      case SwipeDirection.left:
        if (widget.onSwipeLeft != null) {
          widget.onSwipeLeft!();
        }
        break;
      case SwipeDirection.right:
        if (widget.onSwipeRight != null) {
          widget.onSwipeRight!();
        }
        break;
    }
  }

  SwipeDirection _getSwipeDirection(Offset delta) {
    const threshold = 20; // Adjust this value to increase/decrease sensitivity

    if (delta.dx.abs() > delta.dy.abs()) {
      if (delta.dx > threshold) {
        return SwipeDirection.right;
      } else if (delta.dx < -threshold) {
        return SwipeDirection.left;
      }
    } else {
      if (delta.dy > threshold) {
        return SwipeDirection.down;
      } else if (delta.dy < -threshold) {
        return SwipeDirection.up;
      }
    }

    return delta.dx.abs() > delta.dy.abs()
        ? (delta.dx > 0 ? SwipeDirection.right : SwipeDirection.left)
        : (delta.dy > 0 ? SwipeDirection.down : SwipeDirection.up);
  }
}
