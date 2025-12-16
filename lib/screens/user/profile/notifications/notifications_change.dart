import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsChangeScreen extends ConsumerStatefulWidget {
  const NotificationsChangeScreen({super.key});

  @override
  ConsumerState createState() => _NotificationsChangeScreenState();
}

class _NotificationsChangeScreenState extends ConsumerState<NotificationsChangeScreen> {
  final controller1 = ValueNotifier<bool>(false);
  final controller2 = ValueNotifier<bool>(false);
  final controller3 = ValueNotifier<bool>(false);
  final controller4 = ValueNotifier<bool>(false);
  final controller5 = ValueNotifier<bool>(false);
  final controller6 = ValueNotifier<bool>(false);
  final controller7 = ValueNotifier<bool>(false);
  final controller8 = ValueNotifier<bool>(false);
  final controller9 = ValueNotifier<bool>(false);
  final controller10 = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Notifications',
          style: GoogleFonts.inter(
              fontSize: 19,
              fontWeight: FontWeight.w500,
              color: Colors.black
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Common',
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                    ),
                  ),
                  switchTile('General Notification', controller1),
                  switchTile('Sound', controller2),
                  switchTile('Vibrate', controller3),
                ],
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Divider(color: Color(0xffEEEEEE)),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'System & services update',
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                    ),
                  ),
                  switchTile('App updates', controller4),
                  switchTile('Bill Reminder', controller5),
                  switchTile('Promotion', controller6),
                  switchTile('Discount Avaiable', controller7),
                  switchTile('Payment Request', controller8),
                ],
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Divider(color: Color(0xffEEEEEE)),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Others',
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                    ),
                  ),
                  switchTile('New Service Available', controller9),
                  switchTile('New Tips Available', controller10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget switchTile(String title, ValueNotifier<bool> controller){
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: Colors.black
        ),
      ),
      trailing: AdvancedSwitch(
        controller: controller,
        height: 25,
        width: 50,
        activeColor: const Color(0xff0689FF),
        inactiveColor: const Color(0xffCBD5E1),
        thumb: ValueListenableBuilder<bool>(
          valueListenable: controller,
          builder: (_, value, __) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.white,
                width: 18,
                height: 18,
              ),
            );
          },
        ),
      ),
    );
  }
}
