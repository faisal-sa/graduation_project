import 'package:shared_preferences/shared_preferences.dart';

class CompanyLocalStorage {
  static const _companyIdKey = 'company_id';

  static Future<void> saveCompanyId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_companyIdKey, id);
  }

  static Future<String?> getCompanyId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_companyIdKey);
  }

  static Future<void> clearCompanyId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_companyIdKey);
  }
}
