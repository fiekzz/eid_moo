import 'package:eid_moo/features/booking/models/post_booking_details_model.dart';
import 'package:eid_moo/features/booking/proceed_booking_screen.dart';
import 'package:eid_moo/shared/components/em_button.dart';
import 'package:eid_moo/shared/components/em_fetch.dart';
import 'package:eid_moo/shared/utils/theme/em_theme.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MakeBookingScreen extends StatefulWidget {
  const MakeBookingScreen({
    super.key,
    required this.postId,
  });

  final String postId;

  @override
  State<MakeBookingScreen> createState() => _MakeBookingScreenState();
}

class _MakeBookingScreenState extends State<MakeBookingScreen> {
  Future<dynamic>? fetchAndSetPostBookingDetails;

  Future<PostBookingDetailsModel?> getPostBookingDetails() async {
    try {
      final response = await EMFetch(
        '/users/posts/post-booking-details/${widget.postId}',
        method: EMFetchMethod.GET,
      ).authorizedRequest();

      if (response['success']) {
        final responseItem = PostBookingDetailsModel.fromJson(response);

        return responseItem;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred'),
        ),
      );
    }

    return null;
  }

  @override
  void initState() {
    fetchAndSetPostBookingDetails = getPostBookingDetails();
    super.initState();
  }

  int qtyOrder = 1;
  double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Post Booking Details',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: FutureBuilder(
            future: fetchAndSetPostBookingDetails,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error occurred!'),
                );
              }

              final itemData = snapshot.data as PostBookingDetailsModel?;

              final pricePerParts =
                  ((itemData?.data?.price ?? 0) / (itemData?.data?.part ?? 0))
                      .toStringAsFixed(2);

              int bookedParts = 0;

              for (Booking booking in itemData?.data?.booking ?? []) {
                bookedParts += booking.part ?? 0;
              }

              final availableParts = (itemData?.data?.part ?? 0) - bookedParts;

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Masjid Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: EidMooTheme.primaryVariant,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      itemData?.data?.masjid?.name ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      itemData?.data?.masjid?.address ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Post Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: EidMooTheme.primaryVariant,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      itemData?.data?.description ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'RM ${itemData?.data?.price ?? 0} (${itemData?.data?.part ?? 0} parts - RM $pricePerParts per part)',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Available parts: $availableParts',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Make Booking',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: EidMooTheme.primaryVariant,
                      ),
                    ),
                    Text(
                      'Select the number of parts you want to book',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Quantity parts',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            Ink(
                              padding: EdgeInsets.zero,
                              decoration: ShapeDecoration(
                                shape: const CircleBorder(),
                                color:
                                    EidMooTheme.primaryVariant.withOpacity(.1),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  if (qtyOrder > 1) {
                                    setState(() {
                                      qtyOrder--;
                                    });
                                  }
                                },
                                icon: const Icon(
                                  Ionicons.remove,
                                  color: EidMooTheme.primaryVariant,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                              child: Center(
                                child: Text(
                                  qtyOrder.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Ink(
                              padding: EdgeInsets.zero,
                              decoration: ShapeDecoration(
                                shape: const CircleBorder(),
                                color:
                                    EidMooTheme.primaryVariant.withOpacity(.1),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  if (qtyOrder < availableParts) {
                                    setState(() {
                                      qtyOrder++;
                                    });
                                  }
                                },
                                icon: const Icon(
                                  Ionicons.add,
                                  color: EidMooTheme.primaryVariant,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 10),
                    Text(
                      'Total Price: RM ${(qtyOrder * double.parse(pricePerParts)).toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.maxFinite,
                      child: EMButton(
                        onPressed: () {
                          if (itemData != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProceedBookingScreen(
                                  postBookingDetails: itemData,
                                  qtyOrder: qtyOrder,
                                  pricePerParts: double.tryParse(
                                          pricePerParts.toString()) ??
                                      0.00,
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'Proceed',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
