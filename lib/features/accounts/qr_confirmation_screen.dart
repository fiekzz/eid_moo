import 'package:eid_moo/features/accounts/models/booking_claimed_model.dart';
import 'package:eid_moo/main.dart';
import 'package:eid_moo/shared/components/em_button.dart';
import 'package:eid_moo/shared/components/em_fetch.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class QrConfirmationScreen extends StatefulWidget {
  const QrConfirmationScreen({
    super.key,
    required this.deviceId,
  });

  final String deviceId;

  @override
  State<QrConfirmationScreen> createState() => _QrConfirmationScreenState();
}

class _QrConfirmationScreenState extends State<QrConfirmationScreen> {
  Future<dynamic>? fetchAndSetClaimed;

  Future<BookingClaimedModel?> sendConfirmation() async {
    try {
      final response = await EMFetch(
        '/masjid/booking/scan-api-claim',
        method: EMFetchMethod.POST,
        body: {
          'bookingId': widget.deviceId,
        },
      ).authorizedRequest();

      if (response['success']) {
        final responseItem = BookingClaimedModel.fromJson(response);

        return responseItem;
      } else {
        ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
          SnackBar(
            content: Text(
              response['message'] ??
                  'Something went wrong. Please try again later.',
            ),
          ),
        );

        Navigator.of(navigatorKey.currentContext!).pop();
      }

      return null;

    } catch (e) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );

      Navigator.of(navigatorKey.currentContext!).pop();

      return null;
    }
  }

  @override
  void initState() {
    fetchAndSetClaimed = sendConfirmation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Confirm',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: FutureBuilder(
          future: fetchAndSetClaimed,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {

              Navigator.pop(context, false);

              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            final dataDetails = snapshot.data as BookingClaimedModel?;

            // final checkSuccess = dataDetails?.success ?? false;

            return SafeArea(
              child: SizedBox(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Ionicons.checkmark_done,
                        color: Colors.green, size: 100),
                    const SizedBox(height: 20),
                    const Text(
                      'Claim confirmed!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Booking ID: ${dataDetails?.data?.id ?? ''}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.maxFinite,
                      child: EMButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Done'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
