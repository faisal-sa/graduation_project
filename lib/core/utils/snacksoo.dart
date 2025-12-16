import 'package:flutter/material.dart';

/// ---------------------------------------------------------------------------
/// ENUM
/// ---------------------------------------------------------------------------
/// نوع السناك بار
/// هذا الملف لا يعرف أي State أو Cubit
/// فقط نوع العرض (لون / أيقونة)
enum TopSnackBarType { success, error, info }

/// ---------------------------------------------------------------------------
/// PUBLIC API
/// ---------------------------------------------------------------------------
/// هذه هي الواجهة الوحيدة التي يستدعيها الـ UI
/// TopSnackBar.show(...)
///
/// ملاحظة مهمة:
/// - هذا الكلاس "غبي"
/// - لا يعرف BLoC
/// - لا يعرف enum status
/// - فقط يعرض رسالة
class Snacksoo {
  /// نحتفظ بالـ OverlayEntry الحالي
  /// حتى نزيله إذا تم عرض SnackBar جديد
  static OverlayEntry? _entry;

  /// الدالة الرئيسية لعرض السناك بار
  static void show(
    BuildContext context, {
    required String message,
    TopSnackBarType type = TopSnackBarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    /// إذا كان هناك SnackBar ظاهر
    /// قم بإزالته أولًا (منع التكرار)
    _entry?.remove();

    /// الحصول على الـ Overlay الخاص بالصفحة الحالية
    final overlay = Overlay.of(context);

    /// إنشاء OverlayEntry
    _entry = OverlayEntry(
      builder: (_) => _TopSnackBarWidget(
        message: message,
        type: type,
        duration: duration,
        onDismissed: () {
          /// عند انتهاء الأنيميشن
          /// نقوم بإزالة الـ entry من الشاشة
          _entry?.remove();
          _entry = null;
        },
      ),
    );

    /// إضافة الـ OverlayEntry إلى الشاشة
    overlay.insert(_entry!);
  }
}

/// ---------------------------------------------------------------------------
/// INTERNAL WIDGET
/// ---------------------------------------------------------------------------
/// هذا الودجت خاص بالسناك بار فقط
/// مسؤول عن:
/// - الأنيميشن
/// - الشكل
/// - الإخفاء التلقائي
///
/// لا يُستخدم مباشرة من الخارج
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
/// نستخدم StatefulWidget لأن:
/// - AnimationController يحتاج lifecycle
/// - initState / dispose
class _TopSnackBarWidgetState extends State<_TopSnackBarWidget>
    with SingleTickerProviderStateMixin {
  /// يتحكم بالأنيميشن (دخول / خروج)
  late final AnimationController _controller;

  /// أنيميشن الحركة من الأعلى للأسفل
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    /// إنشاء AnimationController
    _controller = AnimationController(
      vsync: this, // لمنع استهلاك غير ضروري
      duration: const Duration(milliseconds: 400),
    );

    /// Tween يحدد الحركة:
    /// begin: خارج الشاشة من الأعلى
    /// end: مكانه الطبيعي
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    /// تشغيل أنيميشن الدخول
    _controller.forward();

    /// بعد مدة محددة:
    /// - نشغل أنيميشن الخروج
    /// - ثم نخبر الكلاس الخارجي لإزالة Overlay
    Future.delayed(widget.duration, () async {
      await _controller.reverse();
      widget.onDismissed();
    });
  }

  @override
  void dispose() {
    /// مهم جدًا:
    /// إيقاف الـ controller لتجنب memory leaks
    _controller.dispose();
    super.dispose();
  }

  /// تحديد لون السناك بار حسب النوع
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

  /// أيقونة حسب النوع (قابلة للتطوير لاحقًا)
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
      /// نضمن عدم التداخل مع النوتش
      child: Align(
        alignment: Alignment.topCenter,
        child: SlideTransition(
          position: _offsetAnimation,
          child: Material(
            /// ضروري للظل و الـ elevation
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
