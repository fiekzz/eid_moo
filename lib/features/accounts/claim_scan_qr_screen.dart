import 'package:eid_moo/features/accounts/qr_confirmation_screen.dart';
import 'package:eid_moo/main.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:umroo/features/account/screen/qr_confirmation_screen.dart';

class ClaimScanQrScreen extends StatefulWidget {
  const ClaimScanQrScreen({super.key});

  @override
  State<ClaimScanQrScreen> createState() => _ClaimScanQrScreenState();
}

class _ClaimScanQrScreenState extends State<ClaimScanQrScreen> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Claim',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 24,
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: MobileScanner(
          // fit: BoxFit.contain,
          controller: cameraController,
          onDetect: (capture) async {
            final List<Barcode> barcodes = capture.barcodes;

            debugPrint('Barcode found! ${barcodes[0].rawValue}');

            cameraController.stop();

            try {
              final bool result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QrConfirmationScreen(
                        deviceId: barcodes[0].rawValue!,
                      ),
                    ),
                  ) ??
                  true;

              cameraController.start();

              if (!result) {
                ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
                  const SnackBar(
                    content: Text('Invalid QR code'),
                  ),
                );
              }
            } catch (e) {
              debugPrint('Error: $e');
            }
          },
        ),
      ),
    );
  }
}