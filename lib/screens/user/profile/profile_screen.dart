import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:janadem/screens/splash_screen.dart';
import 'package:janadem/screens/user/profile/edit_profile/edit_profile.dart';
import 'package:janadem/screens/user/profile/language/language_screen.dart';
import 'package:janadem/screens/user/profile/notifications/notifications_change.dart';
import 'package:janadem/screens/user/profile/privacy_policy/privacy_profile.dart';
import 'package:janadem/screens/widgets/wait_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String name = '';
  String lastname = '';
  String phone = '';
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (doc.exists) {
          name = doc['name'] ?? '';
          lastname = doc['lastname'] ?? '';
          phone = doc['phone'] ?? '';
        }
      }
    } catch (e) {
      // можно проигнорировать
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          children: [
            // Avatar
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/ava.jpg'),
            ),
            const SizedBox(height: 8),

            Text(
              loading ? 'Loading...' : '$lastname $name',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Text(
              loading ? '' : phone,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),


            const SizedBox(height: 20),
            mainContainer(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  rowOfElements('merch_store', 'My Merch', false, Container(), () {
                    showWaitingAlert(context);
                  }),
                  rowOfElements('transactions', 'Transactions', false, Container(), () {
                    showWaitingAlert(context);
                  }),
                ],
              ),
            ),

            mainContainer(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  rowOfElements('help_and_support', 'Help & Support', false, Container(), () {
                    showWaitingAlert(context);
                  }),
                  rowOfElements('contact_us', 'Contact us', false, Container(), () {
                    showWaitingAlert(context);
                  }),
                  rowOfElements('privacy_policy', 'Privacy policy', false, Container(), () {
                    Get.to(() => const PrivacyPolicy());
                  }),
                ],
              ),
            ),

            mainContainer(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  rowOfElements('edit_profile', 'Edit profile information', false, Container(), () {
                    Get.to(() => const EditProfileScreen());
                  }),
                  rowOfElements('notification', 'Notifications', true,
                      Text(
                        'ON',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: const Color(0xff056C5F)
                        ),
                      ),
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const NotificationsChangeScreen()),
                        );
                      }
                  ),

                  rowOfElements('language', 'Language', true,
                      Text(
                        'English',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: const Color(0xff056C5F)
                        ),
                      ),
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const LanguageScreen()),
                        );
                      }
                  ),
                ],
              ),
            ),

            mainContainer(
              InkWell(
                onTap: () {
                  Get.offAll(() => const SplashScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset('assets/icons/logout.svg', width: 20, height: 20),
                      const SizedBox(width: 12),
                      Text(
                        'Log out',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xffEB4335),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mainContainer(Widget child) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget rowOfElements(String icon, String title, bool suffixExists, Widget suffixWidget, void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset('assets/icons/$icon.svg', width: 20, height: 20),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            suffixExists ? suffixWidget : Container(),
          ],
        ),
      ),
    );
  }
}
