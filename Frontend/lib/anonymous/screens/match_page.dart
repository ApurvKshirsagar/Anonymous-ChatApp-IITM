import 'dart:convert';

import 'package:flinnit/anonymous/models/chat_users.dart';
import 'package:flinnit/anonymous/widgets/avatar.dart';
import 'package:flinnit/anonymous/widgets/match_cancel_alert.dart';
import 'package:flinnit/constant_variables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class MatchPage extends StatefulWidget {
  const MatchPage({
    super.key,
    required this.activeMode,
    required this.source,
  });

  final Mode activeMode;
  final ChatUsers source;

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  var canGoBack = false;

  @override
  void initState() {
    super.initState();
    matchUser();
  }

  void matchUser() {
    final url = Uri.parse('https://409c-202-148-59-99.ngrok-free.app');

    print(widget.source.dateID);
    print(widget.source.flinnID);

    http
        .post(
      url,
      headers: {'Content-type': 'application/json'},
      body: json.encode({
        'userFLINNid': widget.source.flinnID,
        'userDATEid': widget.source.dateID,
        'userGender': (widget.source.gender == Gender.male) ? "M" : "F",
        'mode': (widget.activeMode == Mode.flinnDate) ? "Date" : "Mate",
        'activeMateChats': widget.source.activeMateChats,
        'activeDateChats': widget.source.activeDateChats,
      }),
    )
        .then((value) {
      print(value.body);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('You have been matched with jujhar'),
        ),
      );
      Future.delayed(Duration(milliseconds: 1500), () {
        Navigator.of(context).pop();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canGoBack,
      onPopInvoked: (didPop) async {
        final resp = await showDialog(
          context: context,
          builder: (ctx) => const MatchCancelAlert(),
        );
        canGoBack = resp;
        if (canGoBack) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Flinnit',
            style: GoogleFonts.amaranth(
              fontSize: 28,
            ),
          ),
          actions: [
            Avatar(
              mode: widget.activeMode,
              outerRadius: 20,
              gender: widget.source.gender,
            ),
            const SizedBox(width: 15),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: (widget.activeMode == Mode.flinnMate)
                    ? [
                        const Color.fromRGBO(152, 103, 197, 0.1494),
                        const Color.fromRGBO(152, 103, 197, 0.2446),
                      ]
                    : [
                        const Color.fromRGBO(255, 103, 111, 0.1494),
                        const Color.fromRGBO(255, 103, 111, 0.2446),
                      ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              // color: const Color.fromRGBO(152, 103, 197, 0.35),
            ),
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: (widget.activeMode == Mode.flinnMate)
                  ? [
                      const Color.fromRGBO(152, 103, 197, 0.2446),
                      const Color.fromRGBO(152, 103, 197, 0.8966),
                    ]
                  : [
                      const Color.fromRGBO(255, 103, 111, 0.2446),
                      const Color.fromRGBO(255, 103, 111, 0.8966),
                    ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            // color: const Color.fromRGBO(152, 103, 197, 0.35),
            // color: Colors.white,
          ),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 15),
              const Icon(
                Icons.monitor_heart_outlined,
                size: 100,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'We are looking through the entire universe to find the person just right for you!!!',
                  style: GoogleFonts.amaranth(
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              Text(
                'Finding your',
                style: GoogleFonts.amaranth(
                  fontSize: 28,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                (widget.activeMode == Mode.flinnMate)
                    ? 'Flinn-Mate'
                    : 'Flinn-Date',
                style: GoogleFonts.amaranth(
                  fontSize: 50,
                  color: const Color.fromRGBO(70, 0, 88, 1),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.privacy_tip_outlined),
                  const SizedBox(width: 5),
                  Text(
                    'Tips: Do not share your personal info.',
                    style: GoogleFonts.amaranth(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 17),
            ],
          ),
        ),
      ),
    );
  }
}
