// helpers/validation_helper.dart
// Reusable validation functions for forms

class ValidationHelper {
  static String? requiredField(
    String? value, {
    String fieldName = "هذا الحقل",
  }) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName مطلوب";
    }
    return null;
  }

  static String? email(
    String? value, {
    String fieldName = "البريد الإلكتروني",
  }) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName مطلوب";
    }
    final emailRegex = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");
    if (!emailRegex.hasMatch(value)) {
      return "صيغة البريد الإلكتروني غير صحيحة";
    }
    return null;
  }

  static String? phone(String? value, {String fieldName = "رقم الهاتف"}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName مطلوب";
    }
    final phoneRegex = RegExp(r"^[0-9]{8,15}$");
    if (!phoneRegex.hasMatch(value)) {
      return "صيغة رقم الهاتف غير صحيحة";
    }
    return null;
  }

  static String? url(String? value, {String fieldName = "الرابط"}) {
    if (value == null || value.trim().isEmpty) {
      return null; // الموقع الإلكتروني قد لا يكون مطلوبًا
    }
    final urlRegex = RegExp(
      r"^(https?:\/\/)?([\w.-]+)\.([a-z\.]{2,6})([\/\w .-]*)*\/?$",
    );
    if (!urlRegex.hasMatch(value)) {
      return "صيغة الرابط غير صحيحة";
    }
    return null;
  }
}
