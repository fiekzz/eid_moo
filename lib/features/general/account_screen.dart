import 'package:eid_moo/features/general/models/user_details_card.dart';
import 'package:eid_moo/shared/components/em_fetch.dart';
import 'package:eid_moo/shared/utils/theme/em_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ionicons/ionicons.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  Future<dynamic>? fetchAndSetUserDetails;

  bool allowMyMasjid = false;

  Future<UserInfoCardModel?> getUserDetails() async {
    try {
      
      final response = await EMFetch(
        '/users/info',
        method: EMFetchMethod.GET,
      ).authorizedRequest();

      if (response['success']) {
        final responseItem = UserInfoCardModel.fromJson(response);

        if ((responseItem.data?.masjid?.length ?? 0) > 0) {
          setState(() {
            allowMyMasjid = true;
          });
        }

        return responseItem;
      }

    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  void initState() {
    fetchAndSetUserDetails = getUserDetails();
    super.initState();
  }

  final List<EMPageItem> _accountItems = [
    EMPageItem(
      label: 'My account',
      route: '/account/my-account',
    ),
    EMPageItem(
      label: 'History',
      route: '/account/history',
    ),
    EMPageItem(
      label: 'Register masjid',
      route: '/account/register-masjid',
    ),
    EMPageItem(
      label: 'My masjid',
      route: '/account/my-masjid',
    ),
  ];

  final List<EMPageItem> _settingsItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: EidMooTheme.primaryVariant,
      ),
      backgroundColor: EidMooTheme.primaryVariant,
      body: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              height: 300,
              decoration: const BoxDecoration(color: Colors.white),
            ),
          ),
          Positioned.fill(
            child: RefreshIndicator(
              onRefresh: () async {
              },
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.only(
                          bottom: 20,
                        ),
                        decoration: const BoxDecoration(
                            color: EidMooTheme.primaryVariant),
                        child: FutureBuilder(
                          future: fetchAndSetUserDetails,
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

                            if (snapshot.data == false) {
                              return const Center(
                                child: Text('Access denied!'),
                              );
                            }

                            final itemData = snapshot.data as UserInfoCardModel?;

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    const storage = FlutterSecureStorage();

                                    final item = await storage.read(key: 'token');

                                    print(item);
                                  },
                                  child: Container(
                                    width: 120,
                                    height: 120,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: EidMooTheme.secondary,
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: Image.network(
                                      'https://picsum.photos/200',
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return const CircularProgressIndicator();
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  itemData?.data?.name ?? '',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          }
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              child: Text(
                                'My account',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            ListView.builder(
                              itemCount: _accountItems.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (itemBuilder, index) {
                                return Container(
                                  color: Colors.white,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      splashColor: Colors.grey.shade200,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        // print('test');
                                        Navigator.of(context).pushNamed(
                                          _accountItems[index].route,
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 16,
                                        ),
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey,
                                              width: .5,
                                            ),
                                          ),
                                        ),
                                        width: double.maxFinite,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              _accountItems[index].label,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const Icon(
                                              Ionicons.chevron_forward,
                                              color: Colors.grey,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _settingsItems.length,
                              shrinkWrap: true,
                              itemBuilder: (itemBuilder, index) {
                                return Container(
                                  color: Colors.white,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          _settingsItems[index].route,
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 16,
                                        ),
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey,
                                              width: .5,
                                            ),
                                          ),
                                        ),
                                        width: double.maxFinite,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              _settingsItems[index].label,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const Icon(
                                              Ionicons.chevron_forward,
                                              color: Colors.grey,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EMPageItem {
  final String label;
  final String route;

  EMPageItem({
    required this.label,
    required this.route,
  });
}
