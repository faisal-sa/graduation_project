import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

//  ==================  cr info model  =================== //
class CrInfoModel {
  final String crNationalNumber;
  final String crNumber;
  final int versionNo;
  final String name;
  final int duration;
  final bool isMain;
  final String issueDateGregorian;
  final String issueDateHijri;
  final String? mainCrNationalNumber;
  final String? mainCrNumber;
  final bool inLiquidationProcess;
  final bool hasEcommerce;
  final int headquarterCityId;
  final String headquarterCityName;
  final bool isLicenseBased;
  final EntityType entityType;
  final Status status;
  final List<Activity> activities;

  CrInfoModel({
    required this.crNationalNumber,
    required this.crNumber,
    required this.versionNo,
    required this.name,
    required this.duration,
    required this.isMain,
    required this.issueDateGregorian,
    required this.issueDateHijri,
    this.mainCrNationalNumber,
    this.mainCrNumber,
    required this.inLiquidationProcess,
    required this.hasEcommerce,
    required this.headquarterCityId,
    required this.headquarterCityName,
    required this.isLicenseBased,
    required this.entityType,
    required this.status,
    required this.activities,
  });

  factory CrInfoModel.fromMap(Map<String, dynamic> map) {
    return CrInfoModel(
      crNationalNumber: map['crNationalNumber'] as String? ?? '',
      crNumber: map['crNumber'] as String? ?? '',
      versionNo: map['versionNo'] as int? ?? 0,
      name: map['name'] as String? ?? '',
      duration: map['duration'] as int? ?? 0,
      isMain: map['isMain'] as bool? ?? false,
      issueDateGregorian: map['issueDateGregorian'] as String? ?? '',
      issueDateHijri: map['issueDateHijri'] as String? ?? '',
      mainCrNationalNumber: map['mainCrNationalNumber'] as String?,
      mainCrNumber: map['mainCrNumber'] as String?,
      inLiquidationProcess: map['inLiquidationProcess'] as bool? ?? false,
      hasEcommerce: map['hasEcommerce'] as bool? ?? false,
      headquarterCityId: map['headquarterCityId'] as int? ?? 0,
      headquarterCityName: map['headquarterCityName'] as String? ?? '',
      isLicenseBased: map['isLicenseBased'] as bool? ?? false,
      entityType: EntityType.fromMap(
        map['entityType'] as Map<String, dynamic>? ?? {},
      ),
      status: Status.fromMap(map['status'] as Map<String, dynamic>? ?? {}),
      activities:
          (map['activities'] as List<dynamic>?)
              ?.map((e) => Activity.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

//  ==================  entity type model  =================== //

class EntityType {
  final int id;
  final String name;
  final int formId;
  final String formName;
  final List<Character> characterList;

  EntityType({
    required this.id,
    required this.name,
    required this.formId,
    required this.formName,
    required this.characterList,
  });

  factory EntityType.fromMap(Map<String, dynamic> json) {
    return EntityType(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      formId: json['formId'] as int? ?? 0,
      formName: json['formName'] as String? ?? '',
      characterList:
          (json['characterList'] as List<dynamic>?)
              ?.map((e) => Character.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

//  ==================  character model  =================== //

class Character {
  final int id;
  final String name;

  Character({required this.id, required this.name});

  factory Character.fromMap(Map<String, dynamic> json) {
    return Character(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
    );
  }
}

//  ==================  status model  =================== //
class Status {
  final int id;
  final String name;

  Status({required this.id, required this.name});

  factory Status.fromMap(Map<String, dynamic> json) {
    return Status(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
    );
  }
}

//  ==================  activity model  =================== //

class Activity {
  final String id;
  final String name;

  Activity({required this.id, required this.name});

  factory Activity.fromMap(Map<String, dynamic> json) {
    return Activity(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );
  }
}

//  ==================  services  =================== //

class WathqService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.wathq.sa',
      headers: {
        'ApiKey': 'Gt2I30EQ6YaSAbe4vN9kcwlypG9cWp98',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  Future<CrInfoModel> getCrInfo(String crNumber) async {
    try {
      final response = await dio.get('/commercial-registration/info/$crNumber');

      if (response.statusCode == 200 && response.data != null) {
        return CrInfoModel.fromMap(response.data as Map<String, dynamic>);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: 'Invalid response from server',
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // Server responded with error status code
        final statusCode = e.response?.statusCode;
        final errorMessage =
            e.response?.data?['message'] ??
            e.response?.data?['error'] ??
            'خطأ في الخادم (${statusCode ?? 'غير معروف'})';
        throw Exception(errorMessage);
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('انتهت مهلة الاتصال. يرجى المحاولة مرة أخرى');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('خطأ في الاتصال. يرجى التحقق من اتصال الإنترنت');
      } else {
        throw Exception('حدث خطأ غير متوقع: ${e.message}');
      }
    } catch (e) {
      throw Exception('خطأ في جلب البيانات: ${e.toString()}');
    }
  }
}

//  ==================  page features  =================== //

class CrInfoPage extends StatefulWidget {
  const CrInfoPage({super.key});

  @override
  State<CrInfoPage> createState() => _CrInfoPageState();
}

class _CrInfoPageState extends State<CrInfoPage> {
  final service = WathqService();
  final TextEditingController controller = TextEditingController();

  CrInfoModel? data;
  bool loading = false;

  Future<void> fetchData() async {
    final id = controller.text.trim();

    if (id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("يرجى إدخال رقم السجل التجاري")),
      );
      return;
    }

    setState(() {
      loading = true;
      data = null;
    });

    try {
      final result = await service.getCrInfo(id);
      if (!mounted) return;
      setState(() {
        data = result;
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => loading = false);
      final errorMessage = e is Exception
          ? e.toString().replaceFirst('Exception: ', '')
          : "خطأ في جلب البيانات";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wathq API")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ============================
            //       TextField Input
            // ============================
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "رقم السجل التجاري",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: fetchData,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ============================
            //        Loading / Empty / Data
            // ============================
            Expanded(
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : data == null
                  ? const Center(child: Text("أدخل رقم السجل ثم اضغط بحث"))
                  : _buildInfo(),
            ),
          ],
        ),
      ),
    );
  }

  // ============================
  //           UI Builder
  // ============================
  Widget _buildInfo() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _item("الاسم التجاري", data!.name),
        _item("رقم السجل", data!.crNumber),
        _item("الرقم الوطني", data!.crNationalNumber),
        _item("رقم الإصدار", data!.versionNo.toString()),
        _item("المدينة", data!.headquarterCityName),
        _item("تاريخ التأسيس (ميلادي)", data!.issueDateGregorian),
        _item("تاريخ التأسيس (هجري)", data!.issueDateHijri),
        _item("المدة", "${data!.duration} سنة"),
        _item("نوع الكيان", data!.entityType.name),
        _item("الشكل القانوني", data!.entityType.formName),
        _item("الحالة", data!.status.name),
        _item("سجل رئيسي", data!.isMain ? "نعم" : "لا"),
        _item("في عملية تصفية", data!.inLiquidationProcess ? "نعم" : "لا"),
        _item("لديه تجارة إلكترونية", data!.hasEcommerce ? "نعم" : "لا"),
        _item("قائم على ترخيص", data!.isLicenseBased ? "نعم" : "لا"),
        if (data!.mainCrNumber != null)
          _item("رقم السجل الرئيسي", data!.mainCrNumber!),
        if (data!.mainCrNationalNumber != null)
          _item("الرقم الوطني للسجل الرئيسي", data!.mainCrNationalNumber!),
        if (data!.entityType.characterList.isNotEmpty) ...[
          const SizedBox(height: 20),
          const Text(
            "الخصائص:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ...data!.entityType.characterList.map(
            (e) => ListTile(title: Text(e.name), subtitle: Text("ID: ${e.id}")),
          ),
        ],
        const SizedBox(height: 20),
        const Text(
          "الأنشطة:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        if (data!.activities.isEmpty)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("لا توجد أنشطة مسجلة"),
          )
        else
          ...data!.activities.map(
            (e) => ListTile(title: Text(e.name), subtitle: Text("ID: ${e.id}")),
          ),
      ],
    );
  }

  // ==================  item builder  =================== //
  Widget _item(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text("$title: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
