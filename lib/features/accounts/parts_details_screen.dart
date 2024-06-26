import 'package:eid_moo/features/accounts/models/my_masjid_post_details_model.dart';
import 'package:eid_moo/shared/components/em_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PartsDetailsScreen extends StatefulWidget {
  const PartsDetailsScreen({
    super.key,
    required this.postId,
  });

  final String postId;

  @override
  State<PartsDetailsScreen> createState() => _PartsDetailsScreenState();
}

class _PartsDetailsScreenState extends State<PartsDetailsScreen> {
  Future<dynamic>? fetchAndSetGetPartsDetails;

  Future<MyMasjidPostDetailsModel?> getPostDetails() async {
    try {
      final response = await EMFetch(
        '/masjid/posts/post-details/${widget.postId}',
        method: EMFetchMethod.GET,
      ).authorizedRequest();

      if (response['success']) {
        final responseItem = MyMasjidPostDetailsModel.fromJson(response);

        return responseItem;
      }
    } catch (error) {
      return null;
    }

    return null;
  }

  @override
  void initState() {
    fetchAndSetGetPartsDetails = getPostDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parts Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: FutureBuilder(
          future: fetchAndSetGetPartsDetails,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text('An error occurred'),
              );
            }

            final postDetails = snapshot.data as MyMasjidPostDetailsModel?;

            final pData = postDetails?.data;

            final totalparts = pData?.part ?? 0;

            int bookedParts = 0;

            for (Booking booking in pData?.booking ?? []) {
              bookedParts += booking.part ?? 0;
            }

            return SingleChildScrollView(
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
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
                          'RM ${pData?.price ?? 0}',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total parts',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '${pData?.part ?? 0}',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Remaining parts',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '${totalparts - bookedParts}',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    LinearPercentIndicator(
                      barRadius: const Radius.circular(10),
                      animation: true,
                      animationDuration: 1000,
                      lineHeight: 20,
                      percent: (bookedParts / totalparts),
                      progressColor: Colors.green,
                      center: Text(
                          '${(((bookedParts / totalparts)) * 100).toStringAsFixed(0)}%'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Booking details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  (pData?.booking?[index].wantOneThird ?? true)
                                      ? Container(
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          padding: const EdgeInsets.all(5),
                                          child: const Text(
                                            '1/3 of the parts',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          padding: const EdgeInsets.all(5),
                                          child: const Text(
                                            'No 1/3 of the parts',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                  (pData?.booking?[index].claimedOneThird ??
                                          true)
                                      ? Container(
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          padding: const EdgeInsets.all(5),
                                          child: const Text(
                                            'Claimed',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          padding: const EdgeInsets.all(5),
                                          child: const Text(
                                            'Not claimed',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        pData?.booking?[index].userAuth?.name ??
                                            '',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        pData?.booking?[index].userAuth
                                                ?.email ??
                                            '',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        pData?.booking?[index].userAuth
                                                ?.phoneNumber ??
                                            '',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'RM ${pData?.booking?[index].price?.toStringAsFixed(2) ?? ''}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                          '${pData?.booking?[index].part ?? 0} / $totalparts parts'),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      LinearPercentIndicator(
                                        width: 100,
                                        lineHeight: 10,
                                        percent:
                                            (pData?.booking?[index].part ?? 0) /
                                                totalparts,
                                        progressColor: Colors.green,
                                        barRadius: const Radius.circular(10),
                                        animation: true,
                                        animationDuration: 1000,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: pData?.booking?.length ?? 0,
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
