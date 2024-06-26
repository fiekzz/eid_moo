import 'package:eid_moo/features/booking/models/booking_user_info_model.dart';
import 'package:eid_moo/features/booking/models/post_booking_details_model.dart';
import 'package:eid_moo/features/booking/payment_screen.dart';
import 'package:eid_moo/shared/components/em_button.dart';
import 'package:eid_moo/shared/components/em_fetch.dart';
import 'package:eid_moo/shared/utils/theme/em_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProceedBookingScreen extends StatefulWidget {
  const ProceedBookingScreen({
    super.key,
    required this.postBookingDetails,
    required this.qtyOrder,
    required this.pricePerParts,
  });

  final PostBookingDetailsModel postBookingDetails;
  final int qtyOrder;
  final double pricePerParts;

  @override
  State<ProceedBookingScreen> createState() => _ProceedBookingScreenState();
}

class _ProceedBookingScreenState extends State<ProceedBookingScreen> {
  Future<dynamic>? fetchAndSetGetBookingUserInfo;

  Future<BookingUserInfoModel?> getBookingUserInfo() async {
    try {
      final response = await EMFetch(
        '/users/info',
        method: EMFetchMethod.GET,
      ).authorizedRequest();

      if (response['success']) {
        final responseItem = BookingUserInfoModel.fromJson(response);
        return responseItem;
      }
    } catch (error) {}
    return null;
  }

  @override
  void initState() {
    fetchAndSetGetBookingUserInfo = getBookingUserInfo();
    super.initState();
  }

  bool wantOneThird = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking details'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: FutureBuilder(
            future: fetchAndSetGetBookingUserInfo,
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

              final itemData = snapshot.data as BookingUserInfoModel?;

              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  width: double.maxFinite,
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height - 160,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Invoice ${widget.postBookingDetails.data?.masjid?.name}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Quantity',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  widget.qtyOrder.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total price',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'RM ${(widget.qtyOrder * double.parse(widget.pricePerParts.toString())).toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'My details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${itemData?.data?.name}',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${itemData?.data?.email}',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${itemData?.data?.phoneNumber}',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'I want 1/3 from my booking parts',
                            style: TextStyle(fontSize: 14),
                          ),
                          CupertinoSwitch(
                            value: wantOneThird,
                            onChanged: (c) {
                              setState(() {
                                wantOneThird = c;
                              });
                            },
                            activeColor: EidMooTheme.primaryVariant,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Payment method',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.money,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Cash',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.maxFinite,
                        child: EMButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PaymentScreen(
                                  wantOneThird: wantOneThird,
                                  postId:
                                      widget.postBookingDetails.data?.id ?? '',
                                  qty: widget.qtyOrder,
                                ),
                              ),
                            );
                          },
                          child: const Text('Make payment'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// class ProceedBookingScreen extends StatelessWidget {
//   const ProceedBookingScreen({
//     super.key,
//     required this.postBookingDetails,
//     required this.qtyOrder,
//     required this.pricePerParts,
//   });

//   final PostBookingDetailsModel postBookingDetails;
//   final int qtyOrder;
//   final double pricePerParts;

//   /* 
//   Invoice
//   - Masjid name
//   - Quantity
//   - Total price

//   My details
//   - Name
//   - Email
//   - Phone number

//   I want 1/3 from my booking parts
//   - Generate QR code to be claimed later

//   Payment method
//   - Cash
//   - Online transfer
//   - Credit card
//    */

// }
