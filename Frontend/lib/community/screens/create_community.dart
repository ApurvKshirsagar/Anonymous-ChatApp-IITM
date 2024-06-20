import 'package:flinnit/community/models/community.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateCommunityScreen extends StatefulWidget {
  const CreateCommunityScreen({super.key});

  @override
  State<CreateCommunityScreen> createState() => _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends State<CreateCommunityScreen> {
  final _formKey = GlobalKey<FormState>();
  var charCounter = 0;
  CommunityType? _communityType = CommunityType.public;
  DisappearingMessage? _disappearingMessage = DisappearingMessage.off;
  Visible? _visible = Visible.everyone;
  CanJoin? _canJoin = CanJoin.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromRGBO(70, 27, 106, 1),
          ),
        ),
        title: Text(
          'Flinnit',
          style: GoogleFonts.amaranth(
            color: const Color.fromRGBO(70, 27, 106, 1),
            fontSize: 30,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 152, 103, 197),
                Color.fromRGBO(225, 210, 239, 0.28),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(7),
          child: Divider(),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(225, 210, 239, 0.28),
              Color.fromRGBO(225, 210, 239, 0),
            ],
            stops: [0, 0.2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 15,
                ),
                height: 80,
                width: MediaQuery.of(context).size.width - 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(248, 240, 255, 1),
                  border: Border.all(
                    color: const Color.fromRGBO(152, 103, 197, 1),
                  ),
                ),
                child: Center(
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color.fromRGBO(69, 109, 209, 1),
                            width: 2,
                          ),
                        ),
                      ),
                      // SizedBox(width: 15),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),
                          child: TextFormField(
                            key: _formKey,
                            maxLength: 25,
                            style: GoogleFonts.amaranth(
                              color: const Color.fromRGBO(70, 27, 106, 1),
                              fontSize: 18,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Group name',
                              hintStyle: GoogleFonts.amaranth(),
                              counterText: '',
                              suffix: Text(
                                '${25 - charCounter}',
                                style: GoogleFonts.amaranth(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                charCounter = value.length;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  'Group Type:',
                  style: GoogleFonts.amaranth(
                    fontSize: 22,
                    color: const Color.fromRGBO(97, 37, 112, 1),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 63,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(35, 8, 20, 0),
                  child: GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: 3.3,
                    physics: const ScrollPhysics(
                      parent: NeverScrollableScrollPhysics(),
                    ),
                    children: [
                      Row(
                        children: [
                          Radio<CommunityType>(
                            // activeColor: const Color.fromRGBO(70, 27, 106, 1),
                            value: CommunityType.public,
                            groupValue: _communityType,
                            onChanged: (CommunityType? value) {
                              setState(() {
                                _communityType = value;
                              });
                            },
                          ),
                          // SizedBox(width: 5),
                          Text(
                            'Public',
                            style: GoogleFonts.amaranth(
                              fontSize: 18,
                              color: const Color.fromRGBO(97, 37, 112, 1),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<CommunityType>(
                            value: CommunityType.private,
                            groupValue: _communityType,
                            onChanged: (CommunityType? value) {
                              setState(() {
                                _communityType = value;
                              });
                            },
                          ),
                          // SizedBox(width: 5),
                          Text(
                            'Private',
                            style: GoogleFonts.amaranth(
                              fontSize: 18,
                              color: const Color.fromRGBO(97, 37, 112, 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  'Disappearing Messages:',
                  style: GoogleFonts.amaranth(
                    fontSize: 22,
                    color: const Color.fromRGBO(97, 37, 112, 1),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 104,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(35, 8, 20, 0),
                  child: GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: 3.3,
                    physics: const ScrollPhysics(
                      parent: NeverScrollableScrollPhysics(),
                    ),
                    children: [
                      Row(
                        children: [
                          Radio<DisappearingMessage>(
                            value: DisappearingMessage.oneDay,
                            groupValue: _disappearingMessage,
                            onChanged: (DisappearingMessage? value) {
                              setState(() {
                                _disappearingMessage = value;
                              });
                            },
                          ),
                          Text(
                            '24 hrs',
                            style: GoogleFonts.amaranth(
                              fontSize: 18,
                              color: const Color.fromRGBO(97, 37, 112, 1),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<DisappearingMessage>(
                            value: DisappearingMessage.oneWeek,
                            groupValue: _disappearingMessage,
                            onChanged: (DisappearingMessage? value) {
                              setState(() {
                                _disappearingMessage = value;
                              });
                            },
                          ),
                          Text(
                            '1 week',
                            style: GoogleFonts.amaranth(
                              fontSize: 18,
                              color: const Color.fromRGBO(97, 37, 112, 1),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<DisappearingMessage>(
                            value: DisappearingMessage.twoWeek,
                            groupValue: _disappearingMessage,
                            onChanged: (DisappearingMessage? value) {
                              setState(() {
                                _disappearingMessage = value;
                              });
                            },
                          ),
                          Text(
                            '2 weeks',
                            style: GoogleFonts.amaranth(
                              fontSize: 18,
                              color: const Color.fromRGBO(97, 37, 112, 1),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<DisappearingMessage>(
                            value: DisappearingMessage.off,
                            groupValue: _disappearingMessage,
                            onChanged: (DisappearingMessage? value) {
                              setState(() {
                                _disappearingMessage = value;
                              });
                            },
                          ),
                          Text(
                            'Off',
                            style: GoogleFonts.amaranth(
                              fontSize: 18,
                              color: const Color.fromRGBO(97, 37, 112, 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  'Community link visible to:',
                  style: GoogleFonts.amaranth(
                    fontSize: 22,
                    color: const Color.fromRGBO(97, 37, 112, 1),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 63,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(35, 8, 20, 0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 5,
                    physics: const ScrollPhysics(
                      parent: NeverScrollableScrollPhysics(),
                    ),
                    children: [
                      Row(
                        children: [
                          Radio<Visible>(
                            value: Visible.admin,
                            groupValue: _visible,
                            onChanged: (Visible? value) {
                              setState(() {
                                _visible = value;
                              });
                            },
                          ),
                          Text(
                            'Only admins',
                            style: GoogleFonts.amaranth(
                              fontSize: 18,
                              color: const Color.fromRGBO(97, 37, 112, 1),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<Visible>(
                            value: Visible.everyone,
                            groupValue: _visible,
                            onChanged: (Visible? value) {
                              setState(() {
                                _visible = value;
                              });
                            },
                          ),
                          Text(
                            'All participants',
                            style: GoogleFonts.amaranth(
                              fontSize: 18,
                              color: const Color.fromRGBO(97, 37, 112, 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  'Who can join the group:',
                  style: GoogleFonts.amaranth(
                    fontSize: 22,
                    color: const Color.fromRGBO(97, 37, 112, 1),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 63,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(35, 8, 20, 0),
                  child: GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: 3.3,
                    physics: const ScrollPhysics(
                      parent: NeverScrollableScrollPhysics(),
                    ),
                    children: [
                      Row(
                        children: [
                          Radio<CanJoin>(
                            value: CanJoin.male,
                            groupValue: _canJoin,
                            onChanged: (CanJoin? value) {
                              setState(() {
                                _canJoin = value;
                              });
                            },
                          ),
                          Text(
                            'Male',
                            style: GoogleFonts.amaranth(
                              fontSize: 18,
                              color: const Color.fromRGBO(97, 37, 112, 1),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<CanJoin>(
                            value: CanJoin.female,
                            groupValue: _canJoin,
                            onChanged: (CanJoin? value) {
                              setState(() {
                                _canJoin = value;
                              });
                            },
                          ),
                          Text(
                            'Female',
                            style: GoogleFonts.amaranth(
                              fontSize: 18,
                              color: const Color.fromRGBO(97, 37, 112, 1),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<CanJoin>(
                            value: CanJoin.all,
                            groupValue: _canJoin,
                            onChanged: (CanJoin? value) {
                              setState(() {
                                _canJoin = value;
                              });
                            },
                          ),
                          Text(
                            'All',
                            style: GoogleFonts.amaranth(
                              fontSize: 18,
                              color: const Color.fromRGBO(97, 37, 112, 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  'Tags:',
                  style: GoogleFonts.amaranth(
                    fontSize: 22,
                    color: const Color.fromRGBO(97, 37, 112, 1),
                  ),
                ),
              ),
              // Spacer(),
              OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    'Create',
                    style: GoogleFonts.amaranth(
                      fontSize: 22,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    fixedSize: Size(200, 40),
                    foregroundColor: Color.fromRGBO(152, 103, 197, 1),
                    side: BorderSide(
                      color: Color.fromRGBO(152, 103, 197, 1),
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
