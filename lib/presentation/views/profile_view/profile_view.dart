import 'package:flutter/material.dart';

import '../../../constants/extensions.dart';
import '../../../domain/services/session_manager.dart';
import '../auth/login_sign_up_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F4F9),
      appBar: AppBar(
        backgroundColor: Color(0xffF1F4F9),
        surfaceTintColor: Color(0xffF1F4F9),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.adaptive.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder(
            future: SessionManager().getCurrentUser(),
            builder: (context, snap) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 133,
                    width: 133,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: snap.data?.profileImage != null
                            ? DecorationImage(
                                image: NetworkImage(
                                  snap.data!.profileImage!,
                                ),
                                fit: BoxFit.cover)
                            : null,
                        border: Border.all(width: 3, color: Color(0xff4FBFB5)),
                        color: Color(0xff757575)),
                  ),
                  10.height,
                  if (snap.data != null) ...[
                    Text(
                      snap.data?.name ?? "",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      snap.data?.email ?? "",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    )
                  ] else
                    ElevatedButton.icon(
                            onPressed: () async {
                              try {
                                await SessionManager().clearSession();
                                if (context.mounted) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LoginSignUpView()),
                                    (route) => false,
                                  );
                                }
                              } catch (e) {
                                debugPrint(e.toString());
                              }
                            },
                            iconAlignment: IconAlignment.end,
                            icon: Icon(
                              Icons.adaptive.arrow_forward,
                              color: Colors.black,
                            ),
                            label: Text('Don\'t have an account,Login'))
                        .space(width: double.infinity, height: 54),
                  44.height,
                  if (snap.data != null) ...[
                    Container(
                      height: 54,
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                      decoration: BoxDecoration(
                          color: context.colorScheme.onPrimary,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x40C0C0C0),
                              // #C0C0C040 in Flutter (Hex + opacity)
                              offset: Offset(0, 1),
                              // Horizontal and vertical offset
                              blurRadius: 4,
                              // How much the shadow is blurred
                              spreadRadius: 0, // How much the shadow spreads
                            ),
                          ]),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Color(0xffA9B0B6),
                          ),
                          12.width,
                          Expanded(
                              child: Text(
                            'Booking Requests',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          )),
                          5.width,
                          Icon(
                            Icons.adaptive.arrow_forward,
                            color: Color(0xffA9B0B6),
                          )
                        ],
                      ),
                    ),
                    12.height,
                    Container(
                      height: 54,
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                      decoration: BoxDecoration(
                          color: context.colorScheme.onPrimary,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x40C0C0C0),
                              // #C0C0C040 in Flutter (Hex + opacity)
                              offset: Offset(0, 1),
                              // Horizontal and vertical offset
                              blurRadius: 4,
                              // How much the shadow is blurred
                              spreadRadius: 0, // How much the shadow spreads
                            ),
                          ]),
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Color(0xffA9B0B6),
                          ),
                          12.width,
                          Expanded(
                              child: Text(
                            'My Favorites',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          )),
                          5.width,
                          Icon(
                            Icons.adaptive.arrow_forward,
                            color: Color(0xffA9B0B6),
                          )
                        ],
                      ),
                    ),
                    12.height,
                    Container(
                      height: 54,
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                      decoration: BoxDecoration(
                          color: context.colorScheme.onPrimary,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x40C0C0C0),
                              // #C0C0C040 in Flutter (Hex + opacity)
                              offset: Offset(0, 1),
                              // Horizontal and vertical offset
                              blurRadius: 4,
                              // How much the shadow is blurred
                              spreadRadius: 0, // How much the shadow spreads
                            ),
                          ]),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Color(0xffA9B0B6),
                          ),
                          12.width,
                          Expanded(
                              child: Text(
                            'My Rides',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          )),
                          5.width,
                          Icon(
                            Icons.adaptive.arrow_forward,
                            color: Color(0xffA9B0B6),
                          )
                        ],
                      ),
                    ),
                    12.height,
                  ],
                  Container(
                    height: 54,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                    decoration: BoxDecoration(
                        color: context.colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x40C0C0C0),
                            // #C0C0C040 in Flutter (Hex + opacity)
                            offset: Offset(0, 1),
                            // Horizontal and vertical offset
                            blurRadius: 4,
                            // How much the shadow is blurred
                            spreadRadius: 0, // How much the shadow spreads
                          ),
                        ]),
                    child: Row(
                      children: [
                        Icon(
                          Icons.support_agent,
                          color: Color(0xffA9B0B6),
                        ),
                        12.width,
                        Expanded(
                            child: Text(
                          'Contact us',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        )),
                        5.width,
                        Icon(
                          Icons.adaptive.arrow_forward,
                          color: Color(0xffA9B0B6),
                        )
                      ],
                    ),
                  ),
                  28.height,
                  if (snap.data != null)
                    Center(
                        child: OutlinedButton(
                            onPressed: () async {
                              try {
                                await SessionManager().clearSession();
                                if (context.mounted) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LoginSignUpView()),
                                    (route) => false,
                                  );
                                }
                              } catch (e) {
                                debugPrint(e.toString());
                              }
                            },
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Color(0xffCCCCCC)),
                                foregroundColor:
                                    context.colorScheme.onSecondary),
                            child: Text('Log Out')))
                ],
              );
            }),
      ),
    );
  }
}
