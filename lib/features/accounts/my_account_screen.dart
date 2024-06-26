import 'package:eid_moo/features/auth/welcome_screen.dart';
import 'package:eid_moo/features/general/models/user_details_card.dart';
import 'package:eid_moo/shared/components/em_button.dart';
import 'package:eid_moo/shared/components/em_fetch.dart';
import 'package:eid_moo/shared/utils/firebase/em_auth_instance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  Future<dynamic>? fetchAndSetUserDetails;

  Future<UserInfoCardModel?> getUserDetails() async {
    try {
      final response = await EMFetch(
        '/users/info',
        method: EMFetchMethod.GET,
      ).authorizedRequest();

      if (response['success']) {
        final responseItem = UserInfoCardModel.fromJson(response);

        // if ((responseItem.data?.masjid?.length ?? 0) > 0) {
        //   setState(() {
        //     allowMyMasjid = true;
        //   });
        // }

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

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
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

              final pData = snapshot.data as UserInfoCardModel?;

              return SizedBox(
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Account',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Name: ${pData?.data?.name}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Email: ${pData?.data?.email}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Phone: ${pData?.data?.phoneNumber}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const Spacer(),
                    EMButton(
                      isLoading: isLoading,
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });

                        const storage = FlutterSecureStorage();

                        final item = await EMAuthInstance.signOutFromGoogle();

                        if (item) {
                          await storage.deleteAll();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const WelcomeScreen(),
                            ),
                            (route) => false,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('An error occurred!'),
                            ),
                          );
                        }

                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: const Center(
                        child: Text('Logout'),
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
