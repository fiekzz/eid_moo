import 'package:eid_moo/features/accounts/claim_show_qr_screen.dart';
import 'package:eid_moo/features/accounts/models/user_booking_history_model.dart';
import 'package:eid_moo/shared/components/em_fetch.dart';
import 'package:eid_moo/shared/utils/theme/em_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Future<dynamic>? fetchAndSetHistoryModel;

  Future<UserBookingHistoryModel?> getHistoryModel() async {
    try {
      final response = await EMFetch(
        '/users/posts/booking-history',
        method: EMFetchMethod.GET,
      ).authorizedRequest();

      final responseItem = UserBookingHistoryModel.fromJson(response);

      return responseItem;
    } catch (error) {
      return null;
    }
  }

  @override
  void initState() {
    fetchAndSetHistoryModel = getHistoryModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: FutureBuilder(
          future: fetchAndSetHistoryModel,
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

            final pData = snapshot.data as UserBookingHistoryModel?;

            return Padding(
              padding: const EdgeInsets.only(top: 12),
              child: SizedBox(
                width: double.maxFinite,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    bool showCheckmark =
                        ((pData?.data?[index].wantOneThird ?? false) &&
                            (pData?.data?[index].claimedOneThird ?? false));

                    return Container(
                      padding: const EdgeInsets.all(12),
                      width: double.maxFinite,
                      constraints: const BoxConstraints(
                        minHeight: 100,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pData?.data?[index].post?.description ?? '',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                DateFormat('dd MMMM yyyy').format(
                                  pData?.data?[index].createdAt ??
                                      DateTime.now(),
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'RM ${pData?.data?[index].price?.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: EidMooTheme.primaryVariant,
                                ),
                              ),
                              const SizedBox(width: 5),
                              showCheckmark
                                  ? const Icon(
                                      Ionicons.checkmark_circle,
                                      color: EidMooTheme.primaryVariant,
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => ClaimShowQrScreen(
                                              bookId:
                                                  pData?.data?[index].id ?? '',
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Ionicons.qr_code,
                                        color: EidMooTheme.primaryVariant,
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemCount: pData?.data?.length ?? 0,
                  shrinkWrap: true,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
