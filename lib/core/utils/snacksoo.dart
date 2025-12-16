import 'package:flutter/material.dart';

/// ---------------------------------------------------------------------------
/// ENUM
/// ---------------------------------------------------------------------------
/// Snack bar type
/// This file doesn't know any State or Cubit
/// Only the display type (color / icon)
enum TopSnackBarType { success, error, info }

/// ---------------------------------------------------------------------------
/// PUBLIC API
/// ---------------------------------------------------------------------------
/// This is the only interface called by the UI
/// Snacksoo.show(...)
///
/// Important note:
/// - This class is "dumb"
/// - Doesn't know BLoC
/// - Doesn't know enum status
/// - Only displays a message
class Snacksoo {
  /// We keep the current OverlayEntry
  /// To remove it if a new SnackBar is shown
  static OverlayEntry? _entry;

  /// Main function to display the snack bar
  static void show(
    BuildContext context, {
    required String message,
    TopSnackBarType type = TopSnackBarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    /// If there is a visible SnackBar
    /// Remove it first (prevent duplication)
    _entry?.remove();

    /// Get the Overlay of the current page
    final overlay = Overlay.of(context);

    /// Create OverlayEntry
    _entry = OverlayEntry(
      builder: (_) => _TopSnackBarWidget(
        message: message,
        type: type,
        duration: duration,
        onDismissed: () {
          /// When the animation ends
          /// We remove the entry from the screen
          _entry?.remove();
          _entry = null;
        },
      ),
    );

    /// Add the OverlayEntry to the screen
    overlay.insert(_entry!);
  }
}

/// ---------------------------------------------------------------------------
/// INTERNAL WIDGET
/// ---------------------------------------------------------------------------
/// This widget is specific to the snack bar only
/// Responsible for:
/// - Animation
/// - Appearance
/// - Auto-hide
///
/// Not used directly from outside
class _TopSnackBarWidget extends StatefulWidget {
  final String message;
  final TopSnackBarType type;
  final Duration duration;
  final VoidCallback onDismissed;

  const _TopSnackBarWidget({
    required this.message,
    required this.type,
    required this.duration,
    required this.onDismissed,
  });

  @override
  State<_TopSnackBarWidget> createState() => _TopSnackBarWidgetState();
}

/// ---------------------------------------------------------------------------
/// STATE + ANIMATION
/// ---------------------------------------------------------------------------
/// We use StatefulWidget because:
/// - AnimationController needs lifecycle
/// - initState / dispose
class _TopSnackBarWidgetState extends State<_TopSnackBarWidget>
    with SingleTickerProviderStateMixin {
  /// Controls the animation (enter / exit)
  late final AnimationController _controller;

  /// Animation movement from top to bottom
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    /// Create AnimationController
    _controller = AnimationController(
      vsync: this, // To prevent unnecessary consumption
      duration: const Duration(milliseconds: 400),
    );

    /// Tween defines the movement:
    /// begin: Outside the screen from the top
    /// end: Its natural position
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    /// Start entry animation
    _controller.forward();

    /// After a specified duration:
    /// - Start exit animation
    /// - Then notify the external class to remove Overlay
    Future.delayed(widget.duration, () async {
      await _controller.reverse();
      widget.onDismissed();
    });
  }

  @override
  void dispose() {
    /// Very important:
    /// Stop the controller to avoid memory leaks
    _controller.dispose();
    super.dispose();
  }

  /// Determine snack bar color based on type
  Color get _backgroundColor {
    switch (widget.type) {
      case TopSnackBarType.success:
        return Colors.green;
      case TopSnackBarType.error:
        return Colors.red;
      case TopSnackBarType.info:
        return Colors.blue;
    }
  }

  /// Icon based on type (can be extended later)
  IconData get _icon {
    switch (widget.type) {
      case TopSnackBarType.success:
        return Icons.check_circle;
      case TopSnackBarType.error:
        return Icons.error;
      case TopSnackBarType.info:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      /// Ensure no overlap with the notch
      child: Align(
        alignment: Alignment.topCenter,
        child: SlideTransition(
          position: _offsetAnimation,
          child: Material(
            /// Necessary for shadow and elevation
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: _backgroundColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 10,
                    offset: Offset(0, 4),
                    color: Colors.black26,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(_icon, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.message,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
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
}
