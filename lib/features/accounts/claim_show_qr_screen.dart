import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ClaimShowQrScreen extends StatefulWidget {
  const ClaimShowQrScreen({
    super.key,
    required this.bookId,
  });

  final String bookId;

  @override
  State<ClaimShowQrScreen> createState() => _ClaimShowQrScreenState();
}

class _ClaimShowQrScreenState extends State<ClaimShowQrScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Claim Show QR'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(12),
        child: Center(
          child: QrImageView(
            data: widget.bookId,
          ),
        ),
      ),
    );
  }
}
