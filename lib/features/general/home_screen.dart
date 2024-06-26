import 'package:eid_moo/features/booking/make_booking_screen.dart';
import 'package:eid_moo/features/general/models/user_details_card.dart';
import 'package:eid_moo/features/general/models/whats_new_model.dart';
import 'package:eid_moo/shared/components/em_fetch.dart';
import 'package:eid_moo/shared/utils/theme/em_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<dynamic>? fetchAndSetGetWhatsNew;
  Future<dynamic>? fetchAndSetGetUserDetails;

  Future<UserInfoCardModel?> getUserDetails() async {
    try {
      final response = await EMFetch(
        '/users/info',
        method: EMFetchMethod.GET,
      ).authorizedRequest();

      if (response['success']) {
        final responseItem = UserInfoCardModel.fromJson(response);

        return responseItem;
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred!'),
        ),
      );
    }

    return null;
  }

  Future<WhatsNewModel?> getWhatsNew() async {
    try {
      final response = await EMFetch(
        '/users/posts/whats-new',
        method: EMFetchMethod.GET,
      ).authorizedRequest();

      if (response['success']) {
        final responseItem = WhatsNewModel.fromJson(response);
        return responseItem;
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred!'),
        ),
      );
    }

    return null;
  }

  @override
  void initState() {
    fetchAndSetGetWhatsNew = getWhatsNew();
    fetchAndSetGetUserDetails = getUserDetails();
    super.initState();
  }

  Future<void> fetcher() async {
    fetchAndSetGetUserDetails = getUserDetails();
    fetchAndSetGetWhatsNew = getWhatsNew();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/eidmoo_logo.png',
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 8),
            const Text(
              'EidMoo',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                FutureBuilder(
                    future: fetchAndSetGetUserDetails,
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

                      final item = snapshot.data as UserInfoCardModel?;

                      return Container(
                        height: 80,
                        padding: const EdgeInsets.all(12),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: EidMooTheme.primaryVariant,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item?.data?.name ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  item?.data?.email ?? '',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            Text(
                              '${item?.data?.booking?.length ?? 0} bookings',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    }),
                const SizedBox(height: 20),
                const Text(
                  'What\'s new',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                FutureBuilder(
                  future: fetchAndSetGetWhatsNew,
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

                    final item = snapshot.data as WhatsNewModel?;

                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final pricePerParts = ((item?.data?[index].price ?? 0) /
                                (item?.data?[index].part ?? 0))
                            .toStringAsFixed(2);

                        return GestureDetector(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MakeBookingScreen(
                                  postId: item?.data?[index].id ?? '',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.all(12),
                            height: 130,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  color: EidMooTheme.primaryVariant,
                                  blurRadius: 2,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item?.data?[index].masjid?.name ?? '',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Divider(
                                  height: 20,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item?.data?[index].description ??
                                                '',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            'RM $pricePerParts per part',
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        DateFormat('dd MMM yyyy hh:mm a')
                                            .format(
                                          item?.data?[index].createdAt ??
                                              DateTime.now(),
                                        ),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                      itemCount: item?.data?.length ?? 0,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
