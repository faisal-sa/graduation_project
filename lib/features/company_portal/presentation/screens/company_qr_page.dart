import 'package:flutter/material.dart';

class CompanyQRScannerPage extends StatelessWidget {
  const CompanyQRScannerPage({super.key});

  void _handleQRScanResult(BuildContext context, String candidateId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Scanned Candidate ID: $candidateId')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Scanner')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.qr_code_scanner, size: 100),
            const SizedBox(height: 20),
            const Text('Point the camera at a candidate\'s QR code.'),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => _handleQRScanResult(context, 'CAND_12345'),
              child: const Text('Simulate Scan'),
            ),
          ],
        ),
      ),
    );
  }
}
