import 'package:flinnit/anonymous/models/chat_users.dart';
import 'package:flinnit/anonymous/widgets/avatar.dart';
import 'package:flinnit/anonymous/widgets/drawer_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnonymousDrawer extends StatelessWidget {
  const AnonymousDrawer({
    super.key,
    required this.myName,
    required this.myGender,
    required this.activeMode,
    required this.pageIndex,
  });

  final String myName;
  final Gender myGender;
  final Mode activeMode;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: (pageIndex == 0)
                ? (activeMode == Mode.flinnMate)
                    ? [
                        const Color.fromRGBO(152, 103, 197, 1),
                        const Color.fromRGBO(152, 103, 197, 0),
                      ]
                    : [
                        const Color.fromARGB(255, 255, 53, 111),
                        const Color.fromARGB(0, 255, 53, 111),
                      ]
                : [
                    const Color.fromRGBO(152, 103, 197, 1),
                    const Color.fromRGBO(152, 103, 197, 0),
                  ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0, 0.3],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              height: 275,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Avatar(
                      mode: activeMode,
                      gender: myGender,
                      outerRadius: 22,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        myName,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.amaranth(
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SideDrawerButton(
              buttonText: 'Profile',
              buttonIcon: Icons.person_outline_outlined,
            ),
            const SizedBox(height: 5),
            const SideDrawerButton(
              buttonText: 'Settings',
              buttonIcon: Icons.privacy_tip_outlined,
            ),
            const SizedBox(height: 5),
            const SideDrawerButton(
              buttonText: 'Invite a friend',
              buttonIcon: Icons.person_add_alt_1_outlined,
            ),
            const SizedBox(height: 5),
            const SideDrawerButton(
              buttonText: 'Help',
              buttonIcon: Icons.headset_mic_outlined,
            ),
            const SizedBox(height: 5),
            const SideDrawerButton(
              buttonText: 'Flinnit Tour',
              buttonIcon: Icons.rocket_launch_outlined,
            ),
            const SizedBox(height: 5),
            const SideDrawerButton(
              buttonText: 'Feedback',
              buttonIcon: Icons.feedback_outlined,
            ),
            const Spacer(),
            Text(
              'Developed with ❤️',
              style: GoogleFonts.amaranth(
                fontSize: 20,
                color: const Color.fromRGBO(97, 37, 112, 1),
              ),
            ),
            const SizedBox(width: 2),
            Text(
              'RKP',
              style: GoogleFonts.amaranth(
                fontSize: 20,
                color: const Color.fromRGBO(97, 37, 112, 1),
              ),
            ),
            Text(
              '2023 Version 2.0',
              style: GoogleFonts.amaranth(
                fontSize: 10,
                color: const Color.fromRGBO(97, 37, 112, 1),
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
