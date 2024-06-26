import 'package:eid_moo/features/accounts/claim_scan_qr_screen.dart';
import 'package:eid_moo/features/accounts/create_post_screen.dart';
import 'package:eid_moo/features/accounts/models/mymasjiddetailsmodel.dart';
import 'package:eid_moo/features/accounts/parts_details_screen.dart';
import 'package:eid_moo/shared/components/em_fetch.dart';
import 'package:eid_moo/shared/utils/theme/em_theme.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MasjidDetailsScreen extends StatefulWidget {
  const MasjidDetailsScreen({
    super.key,
    required this.masjidId,
  });

  final String masjidId;

  @override
  State<MasjidDetailsScreen> createState() => _MasjidDetailsScreenState();
}

class _MasjidDetailsScreenState extends State<MasjidDetailsScreen> {
  Future<dynamic>? fetchAndSetGetMasjidDetails;

  Future<MyMasjidDetailsModel?> getMasjid() async {
    try {
      final response = await EMFetch(
        '/masjid/details/${widget.masjidId}',
        method: EMFetchMethod.GET,
      ).authorizedRequest();

      final responseItem = MyMasjidDetailsModel.fromJson(response);
      return responseItem;
    } catch (error) {
      return null;
    }
  }

  @override
  void initState() {
    fetchAndSetGetMasjidDetails = getMasjid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Masjid Details'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ClaimScanQrScreen(),
                ),
              );
            },
            icon: const Icon(Ionicons.qr_code),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreatePostScreen(
                masjidId: widget.masjidId,
              ),
            ),
          );
        },
        backgroundColor: EidMooTheme.primaryVariant,
        child: const Icon(
          Ionicons.add,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: FutureBuilder(
          future: fetchAndSetGetMasjidDetails,
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

            final item = snapshot.data as MyMasjidDetailsModel?;
            final itemdata = item?.data;

            return SingleChildScrollView(
              clipBehavior: Clip.none,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: 200,
                    decoration: BoxDecoration(
                      color: EidMooTheme.primaryVariant,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            itemdata?.name ?? '',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            itemdata?.address ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'RM ${itemdata?.sales?.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Posts',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final itemdata = item?.data;

                      int bookedParts = 0;

                      for (Booking d in itemdata?.post?[index].booking ?? []) {
                        bookedParts += d.part ?? 0;
                      }

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PartsDetailsScreen(
                                postId: itemdata?.post?[index].id ?? '',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          width: double.maxFinite,
                          height: 80,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    itemdata?.post?[index].description ?? '',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'RM ${itemdata?.post?[index].price?.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              LinearPercentIndicator(
                                width: 100,
                                lineHeight: 10,
                                percent: bookedParts /
                                    (itemdata?.post?[index].part ?? 0),
                                progressColor: EidMooTheme.primaryVariant,
                                barRadius: const Radius.circular(10),
                                animation: true,
                                animationDuration: 1000,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                    itemCount: itemdata?.post?.length ?? 0,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
