import 'package:flinnit/anonymous/models/chat_users.dart';
import 'package:flinnit/anonymous/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MediaScreen extends StatefulWidget {
  const MediaScreen({
    super.key,
    required this.activeMode,
    required this.chatUser,
  });

  final Mode activeMode;
  final ChatUsers chatUser;

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.chatUser.name,
          style: GoogleFonts.amaranth(
            fontSize: 22,
            color: Colors.black,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: (widget.activeMode == Mode.flinnMate)
                  ? [
                      const Color.fromARGB(255, 152, 103, 197),
                      const Color.fromRGBO(253, 252, 255, 0),
                    ]
                  : [
                      const Color.fromARGB(255, 255, 53, 111),
                      const Color.fromRGBO(253, 252, 255, 0),
                    ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        bottom: TabBar(
          controller: _controller,
          tabs: [
            Tab(
              child: Text(
                'Media',
                style: GoogleFonts.amaranth(
                  fontSize: 17,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Docs',
                style: GoogleFonts.amaranth(
                  fontSize: 17,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Links',
                style: GoogleFonts.amaranth(
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          Text('Media'),
          Text('Docs'),
          Text('Links'),
        ],
      ),
    );
  }
}
