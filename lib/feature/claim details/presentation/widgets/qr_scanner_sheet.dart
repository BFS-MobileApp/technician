import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerSheet extends StatefulWidget {
  const QRScannerSheet({Key? key}) : super(key: key);

  @override
  State<QRScannerSheet> createState() => _QRScannerSheetState();
}

class _QRScannerSheetState extends State<QRScannerSheet> {
  late MobileScannerController controller;
  bool scanned = false;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            "Scan BarCode",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A2F4B),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: MobileScanner(
                controller: controller,
                onDetect: (capture) {
                  if (!scanned) {
                    scanned = true;
                    final barcode = capture.barcodes.first;
                    Navigator.pop(context, barcode.rawValue);
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  controller.start();
                },
                icon: const Icon(Icons.qr_code_scanner, color: Colors.blue, size: 30),
              ),
              const SizedBox(width: 30),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close, color: Colors.red, size: 30),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
