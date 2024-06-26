import 'package:eid_moo/features/accounts/masjid_details_screen.dart';
import 'package:eid_moo/features/accounts/models/mymasjidmodel.dart';
import 'package:eid_moo/main.dart';
import 'package:eid_moo/shared/components/em_fetch.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class MyMasjidScreen extends StatefulWidget {
  const MyMasjidScreen({super.key});

  @override
  State<MyMasjidScreen> createState() => _MyMasjidScreenState();
}

class _MyMasjidScreenState extends State<MyMasjidScreen> {
  Future<dynamic>? fetchAndSetGetMasjid;

  Future<MyMasjidModel?> getMasjid() async {
    try {
      final response = await EMFetch(
        '/masjid/info',
        method: EMFetchMethod.GET,
      ).authorizedRequest();

      final responseItem = MyMasjidModel.fromJson(response);
      return responseItem;
    } catch (error) {
      return null;
    }
  }

  // final TextEditingController _pinController = TextEditingController();

  Future<dynamic>? allowAccess;

  Future<bool> _checkBiometrics() async {
    final LocalAuthentication localAuth = LocalAuthentication();

    bool isBiometricSupported = await localAuth.canCheckBiometrics;

    if (isBiometricSupported) {
      bool isAuthenticated = await localAuth.authenticate(
        localizedReason: 'Authenticate using biometrics',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      final tes = await localAuth.stopAuthentication();

      print(tes);

      if (isAuthenticated) {
        return true;
      } else {
        return false;
      }
    }

    return false;
  }

  @override
  void initState() {
    fetchAndSetGetMasjid = getMasjid();
    allowAccess = _checkBiometrics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Masjid'),
      ),
      body: FutureBuilder(
          future: allowAccess,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              print(snapshot.error.toString());

              return const Center(
                child: Text('An error occurred!'),
              );
            }

            if (snapshot.data == false) {
              return const Center(
                child: Text('Access denied!'),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                width: double.maxFinite,
                child: FutureBuilder(
                  future: fetchAndSetGetMasjid,
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

                    final itemData = snapshot.data as MyMasjidModel?;

                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      clipBehavior: Clip.none,
                      child: Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              print(itemData?.data?[index].name ?? '');

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => MasjidDetailsScreen(
                                        masjidId:
                                            itemData?.data?[index].id ?? '',
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
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            itemData?.data?[index].name ?? '',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            itemData?.data?[index].address ??
                                                '',
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Text(
                                        '${(itemData?.data?[index].post?.length ?? 0).toStringAsFixed(0)} Posts',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: itemData?.data?.length ?? 0,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          }),
    );
  }
}
