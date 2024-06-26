import 'package:eid_moo/shared/components/em_bottomnavbar.dart';
import 'package:eid_moo/shared/components/em_button.dart';
import 'package:eid_moo/shared/components/em_fetch.dart';
import 'package:eid_moo/shared/utils/theme/em_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    super.key,
    required this.wantOneThird,
    required this.postId,
    required this.qty,
  });

  final bool wantOneThird;
  final String postId;
  final int qty;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool emailCopied = false;
  bool whatsappCopied = false;

  bool isLoading = false;

  Future<void> makePayment() async {
    try {
      final response = await EMFetch(
        '/users/booking/make-booking',
        method: EMFetchMethod.POST,
        body: {
          'postId': widget.postId,
          'qty': widget.qty,
          'wantOneThird': widget.wantOneThird,
        },
      ).authorizedRequest();

      if (response['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Payment successful'),
          ),
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const EMBottomNavbar(),
          ),
          (route) => false,
        );
      }
    } catch (e) {
      //
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SizedBox(
          width: double.maxFinite,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/eidmoo_logo.png', width: 100),
                const SizedBox(height: 20),
                const Text(
                  'To be connected to the payment gateway soon. For now, please make a direct bank transfer to the following account:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: EidMooTheme.primaryVariant,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Maybank',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        '1234567890',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        'EidMoo Sdn Bhd',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Please send the proof of payment to',
                        style: TextStyle(fontSize: 16),
                      ),
                      Row(
                        children: [
                          const Text(
                            'eidmoopaid@eidmoo.com.my',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 5),
                          IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () async {
                              await Clipboard.setData(
                                const ClipboardData(
                                  text: 'eidmoopaid@eidmoo.com.my',
                                ),
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'eidmoopaid@eidmoo.com.my Copied to clipboard'),
                                ),
                              );

                              setState(() {
                                emailCopied = true;
                              });
                            },
                            icon: !emailCopied
                                ? const Icon(Ionicons.copy_outline)
                                : const Icon(
                                    Ionicons.checkmark,
                                  ),
                          ),
                        ],
                      ),
                      const Text(
                        'or',
                        style: TextStyle(fontSize: 16),
                      ),
                      Row(
                        children: [
                          const Text(
                            '01155046571 (whatsapp)',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 5),
                          IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () async {
                              await Clipboard.setData(
                                const ClipboardData(
                                  text: '601155046571',
                                ),
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('601155046571 Copied to clipboard'),
                                ),
                              );

                              setState(() {
                                whatsappCopied = true;
                              });
                            },
                            icon: !whatsappCopied
                                ? const Icon(Ionicons.copy_outline)
                                : const Icon(
                                    Ionicons.checkmark,
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.maxFinite,
                  child: EMButton(
                    isLoading: isLoading,
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      await makePayment();
                    },
                    child: const Text('I have made the payment'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.maxFinite,
                  child: EMButton(
                    backgroundColor: Colors.white,
                    borderColor: Colors.black,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel Payment',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class PaymentScreen extends StatelessWidget {
//   const PaymentScreen({
//     super.key,
//     required this.wantOneThird,
//     required this.postId,
//     required this.qty,
//   });

//   final bool wantOneThird;
//   final String postId;
//   final int qty;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Payment'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12),
//         child: SizedBox(
//           width: double.maxFinite,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Image.asset('assets/images/eidmoo_logo.png', width: 100),
//                 const SizedBox(height: 20),
//                 const Text(
//                   'To be connected to the payment gateway soon. For now, please make a direct bank transfer to the following account:',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Container(
//                   width: double.maxFinite,
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(
//                       color: EidMooTheme.primaryVariant,
//                     ),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         'Maybank',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const Text(
//                         '1234567890',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const Text(
//                         'EidMoo Sdn Bhd',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       const Text(
//                         'Please send the proof of payment to',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       Row(
//                         children: [
//                           const Text(
//                             'eidmoopaid@eidmoo.com.my',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           const SizedBox(width: 5),
//                           IconButton(
//                             splashColor: Colors.transparent,
//                             highlightColor: Colors.transparent,
//                             onPressed: () async {
//                               await Clipboard.setData(
//                                 const ClipboardData(
//                                   text: 'eidmoopaid@eidmoo.com.my',
//                                 ),
//                               );

//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text('Copied to clipboard'),
//                                 ),
//                               );
//                             },
//                             icon: const Icon(
//                               Ionicons.copy_outline
//                             ),
//                           ),
//                         ],
//                       ),
//                       const Text(
//                         'or',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       const Text(
//                         '01155046571 (whatsapp)',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 SizedBox(
//                   width: double.maxFinite,
//                   child: EMButton(
//                     onPressed: () {},
//                     child: const Text('I have made the payment'),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 SizedBox(
//                   width: double.maxFinite,
//                   child: EMButton(
//                     backgroundColor: Colors.white,
//                     borderColor: Colors.black,
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Text(
//                       'Cancel Payment',
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
