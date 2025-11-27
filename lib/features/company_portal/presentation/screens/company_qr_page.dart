import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/company_portal/presentation/blocs/bloc/company_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CompanyQRScannerPage extends StatefulWidget {
  const CompanyQRScannerPage({super.key});

  @override
  State<CompanyQRScannerPage> createState() => _CompanyQRScannerPageState();
}

class _CompanyQRScannerPageState extends State<CompanyQRScannerPage> {
  bool _isProcessing = false;
  String? _lastScannedId;

  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📷 ماسح رمز الباحث عن عمل'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // شاشة الكاميرا
          Expanded(
            flex: 3,
            child: MobileScanner(
              fit: BoxFit.contain,
              onDetect: (capture) async {
                final barcodes = capture.barcodes;
                if (_isProcessing) return;
                if (barcodes.isNotEmpty) {
                  final candidateId = barcodes.first.rawValue;
                  if (candidateId != null &&
                      candidateId != _lastScannedId &&
                      candidateId.isNotEmpty) {
                    _isProcessing = true;
                    _lastScannedId = candidateId;
                    await _showCandidateDialog(context, candidateId);
                    Future.delayed(const Duration(seconds: 1), () {
                      _isProcessing = false;
                    });
                  }
                }
              },
            ),
          ),

          // النص التوضيحي
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.qr_code_scanner,
                    size: 60,
                    color: Colors.blueAccent,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'وجّه الكاميرا نحو رمز الباحث\nلعرض بياناته وإضافته للمفضلة',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// عرض بيانات الباحث بعد المسح
  Future<void> _showCandidateDialog(
    BuildContext context,
    String candidateId,
  ) async {
    try {
      final candidateData = await supabase
          .from('candidates')
          .select('id, full_name, skills, city')
          .eq('id', candidateId)
          .maybeSingle();

      if (candidateData == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('⚠️ لم يتم العثور على المرشح.')),
          );
        }
        return;
      }

      if (!mounted) return;

      showDialog(
        context: context,
        builder: (ctx) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.person, size: 60, color: Colors.blueAccent),
                  const SizedBox(height: 12),
                  Text(
                    candidateData['full_name'] ?? 'مرشح غير معروف',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('المهارات: ${candidateData['skills'] ?? 'غير محددة'}'),
                  Text('المدينة: ${candidateData['city'] ?? '-'}'),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.favorite_border),
                    label: const Text('إضافة إلى المفضلة'),
                    onPressed: () {
                      final state = context.read<CompanyBloc>().state;
                      if (state is CompanyLoaded) {
                        context.read<CompanyBloc>().add(
                          AddCandidateBookmarkEvent(candidateData['id']),
                        );
                        Navigator.of(ctx).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('✅ تمت إضافة الباحث إلى المفضلة'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('⚠️ يجب تحميل حساب الشركة أولاً.'),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('إغلاق'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ أثناء جلب البيانات: $e')),
        );
      }
    }
  }
}
