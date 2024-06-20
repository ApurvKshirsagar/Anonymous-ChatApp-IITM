import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flinnit/anonymous/models/chat_users.dart';
import 'package:flinnit/anonymous/screens/media_screen.dart';
import 'package:flinnit/anonymous/widgets/avatar.dart';
import 'package:flinnit/anonymous/widgets/block_alert.dart';
import 'package:flinnit/anonymous/widgets/disappear_messages_alert.dart';
import 'package:flinnit/anonymous/widgets/mute_notification.dart';
import 'package:flinnit/anonymous/widgets/report_alert.dart';
import 'package:flinnit/toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TargetProfilePage extends StatefulWidget {
  const TargetProfilePage({
    super.key,
    required this.activeMode,
    required this.chatUser,
  });

  final Mode activeMode;
  final ChatUsers chatUser;

  @override
  State<TargetProfilePage> createState() => _TargetProfilePageState();
}

class _TargetProfilePageState extends State<TargetProfilePage> {
  var muteNotification = false;
  var disappearMessages = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: (widget.activeMode == Mode.flinnMate)
                ? [
                    Color.fromRGBO(152, 103, 197, 1),
                    Color.fromRGBO(255, 255, 255, 0),
                  ]
                : [
                    Color.fromRGBO(255, 53, 111, 1),
                    Color.fromRGBO(253, 252, 255, 0),
                  ],
            stops: [0.0, 0.2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 35,
              ),
              Avatar(
                mode: widget.activeMode,
                outerRadius: 40,
                gender: widget.chatUser.gender,
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                widget.chatUser.name,
                style: GoogleFonts.amaranth(fontSize: 26),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 23,
              ),
              Container(
                height: 125,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 164, 210, 0.1),
                  border: Border.all(
                    color: const Color.fromRGBO(152, 103, 197, 1),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: Text(
                          'Bio:',
                          style: GoogleFonts.amaranth(
                            fontSize: 19,
                            color: const Color.fromRGBO(97, 37, 112, 1),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                          style: GoogleFonts.amaranth(
                            fontSize: 16,
                          ),
                          maxLines: 3,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Container(
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(245, 241, 250, 1),
                  border: Border.all(
                    color: const Color.fromRGBO(39, 175, 201, 1),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                          top: 4,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Media, links and docs:',
                              style: GoogleFonts.amaranth(
                                fontSize: 19,
                                color: const Color.fromRGBO(0, 0, 0, .7),
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(0),
                                splashFactory: NoSplash.splashFactory,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    '400',
                                    style: GoogleFonts.amaranth(
                                      fontSize: 18,
                                      color: const Color.fromRGBO(0, 0, 0, .7),
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14,
                                    color: Color.fromRGBO(0, 0, 0, .7),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => MediaScreen(
                                        activeMode: widget.activeMode,
                                        chatUser: widget.chatUser),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 13,
                        itemBuilder: (ctx, index) => (index < 12)
                            ? Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 8,
                                ),
                                height: MediaQuery.of(context).size.width / 3 -
                                    14.67,
                                width: MediaQuery.of(context).size.width / 3 -
                                    14.67,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Text('Tumhari photu'),
                              )
                            : SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 5 - 60,
                                width:
                                    MediaQuery.of(context).size.height / 5 - 60,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) => MediaScreen(
                                            activeMode: widget.activeMode,
                                            chatUser: widget.chatUser),
                                      ),
                                    );
                                  },
                                  highlightColor: Colors.transparent,
                                  icon: const Icon(Icons.arrow_forward_ios),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 32),
              ToggleSwitch(
                toggle: (value) {
                  // if (!muteNotification) {
                  //   showDialog(
                  //     context: context,
                  //     builder: (ctx) => MuteNotificationAlert(
                  //       chatUser: widget.chatUser,
                  //       mute: () {
                  //         setState(() {
                  //           muteNotification = value;
                  //         });
                  //       },
                  //     ),
                  //   );
                  // showDialogGroupedCheckbox(
                  //   context: context,
                  //   initialSelectedValues: ["Always"],
                  //   cancelDialogText: "Cancel",
                  //   isMultiSelection: false,
                  //   itemsTitle: ["12 hours", '1 week', 'Always'],
                  //   submitDialogText: "OK",
                  //   dialogTitle: Text("Mute Notification"),
                  //   values: ["12 hours", '1 week', 'Always'],
                  // );
                  // } else {
                  //   setState(() {
                  //     muteNotification = value;
                  //   });
                  // }
                  setState(() {
                    muteNotification = value;
                  });
                  print('notification: $muteNotification');
                },
                switchValue: muteNotification,
                icon: Icons.notifications_none_outlined,
                label: 'Mute Notification',
              ),
              ToggleSwitch(
                toggle: (value) {
                  setState(() {
                    disappearMessages = value;
                  });
                  print('disappear: $disappearMessages');
                  // if (!disappearMessages) {
                  //   showDialog(
                  //     context: context,
                  //     builder: (ctx) => DisappearMessagesAlert(
                  //       chatUser: widget.chatUser,
                  //       disappear: () {
                  //         setState(() {
                  //           disappearMessages = value;
                  //         });
                  //       },
                  //     ),
                  //   );
                  // } else {
                  //   setState(() {
                  //     disappearMessages = value;
                  //   });
                  // }
                },
                switchValue: disappearMessages,
                icon: Icons.timer_outlined,
                label: 'Disappearing Messages',
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 45),
              const Divider(),
              SizedBox(height: MediaQuery.of(context).size.height / 80),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22),
                  child: TextButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => BlockAlert(chatUser: widget.chatUser),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromRGBO(183, 71, 41, 1),
                    ),
                    icon: const Icon(Icons.block),
                    label: Text(
                      'Block ${widget.chatUser.name}',
                      style: GoogleFonts.amaranth(fontSize: 18),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22),
                  child: TextButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => ReportAlert(
                          chatUser: widget.chatUser,
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromRGBO(183, 71, 41, 1),
                    ),
                    icon: const Icon(Icons.thumb_down_alt_outlined),
                    label: Text(
                      'Report ${widget.chatUser.name}',
                      style: GoogleFonts.amaranth(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
