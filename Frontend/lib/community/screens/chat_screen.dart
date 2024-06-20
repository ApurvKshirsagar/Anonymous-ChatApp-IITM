// ignore_for_file: avoid_print

import 'package:flinnit/anonymous/data/chat_users.dart';
import 'package:flinnit/community/models/community.dart';
import 'package:flinnit/community/models/community_message.dart';
import 'package:flinnit/community/screens/community_info.dart';
import 'package:flinnit/community/widgets/chat_popup.dart';
import 'package:flinnit/community/widgets/own_message_card.dart';
import 'package:flinnit/community/widgets/reply_card.dart';
import 'package:flinnit/constant_variables.dart';
import 'package:flinnit/anonymous/models/chat_users.dart';
import 'package:flinnit/anonymous/models/message_model.dart';
import 'package:flinnit/anonymous/screens/camera_screen.dart';
import 'package:flinnit/anonymous/widgets/attachments.dart';
import 'package:flinnit/anonymous/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:image_picker/image_picker.dart';

class CommunityChatScreen extends StatefulWidget {
  const CommunityChatScreen({
    super.key,
    required this.community,
    required this.source,
  });

  final Community community;
  final ChatUsers source;

  @override
  State<CommunityChatScreen> createState() {
    return _CommunityChatScreenState();
  }
}

class _CommunityChatScreenState extends State<CommunityChatScreen> {
  final _controller = TextEditingController();
  var emojiShowing = false;
  final focusNode = FocusNode();
  final _listController = ScrollController();
  late io.Socket socket;
  var showSendButton = false;
  var _needsScroll = false;
  late List<CommunityMessageModel> messages;

  @override
  void dispose() {
    _controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _needsScroll = true;
    print('member 1: ${widget.community.members[0].id}');
    print('source: ${widget.source.id}');
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          emojiShowing = false;
        });
      }
    });
    messages = [
      CommunityMessageModel(
        comments: 5,
        likes: 39,
        message: 'Jaane woh kese log the jinke pyaar ko pyaar mila',
        // sender: Sender.target,
        time: DateTime.now(),
        views: 169,
        senderDetails: widget.community.members[0],
      ),
      CommunityMessageModel(
        comments: 5,
        likes: 39,
        message: 'Lo aa gayi unki yaad woh nahi aaye',
        // sender: Sender.source,
        time: DateTime.now(),
        views: 169,
        senderDetails: widget.community.members[0],
      ),
      CommunityMessageModel(
        comments: 5,
        likes: 39,
        message: 'Aye neele gagan ke tale',
        // sender: Sender.target,
        time: DateTime.now(),
        views: 169,
        senderDetails: widget.community.members[1],
      ),
      CommunityMessageModel(
        comments: 5,
        likes: 39,
        message: 'Subah ke paanch baje',
        // sender: Sender.source,
        time: DateTime.now(),
        views: 169,
        senderDetails: widget.community.members[8],
      ),
      CommunityMessageModel(
        comments: 5,
        likes: 39,
        message: 'Haathon mein lota',
        // sender: Sender.target,
        time: DateTime.now(),
        views: 169,
        senderDetails: widget.community.members[7],
      ),
      CommunityMessageModel(
        comments: 5,
        likes: 39,
        message: 'Lote mein paani',
        // sender: Sender.source,
        time: DateTime.now(),
        views: 169,
        senderDetails: widget.community.members[9],
      ),
      CommunityMessageModel(
        comments: 999,
        likes: 999,
        message: 'Khoole mein shauch kare',
        // sender: Sender.target,
        time: DateTime.now(),
        views: 999,
        senderDetails: widget.community.members[5],
      ),
      CommunityMessageModel(
        comments: 999,
        likes: 999,
        message: 'Khoole mein shauch kare',
        // sender: Sender.target,
        time: DateTime.now(),
        views: 999,
        senderDetails: widget.community.members[5],
      ),
      CommunityMessageModel(
        comments: 999,
        likes: 999,
        message: 'Khoole mein shauch kare',
        // sender: Sender.target,
        time: DateTime.now(),
        views: 999,
        senderDetails: widget.community.members[5],
      ),
    ];
  }

  void _onBackspacePressed() {
    _controller
      ..text = _controller.text.characters.toString()
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
  }

  void connect() {
    print('connect function called');
    socket = io.io(backendUri, <String, dynamic>{
      "transports": ["websocket"],
      "autoconnect": false,
    });
    socket.connect();
    socket.emit("signin", widget.source.id);
    socket.onConnect((data) {
      print('connected');
      socket.on("message", (msg) {
        newMessage(msg["message"]);
      });
      // print(msg["message"]);
    });
  }

  void scrollToEnd() async {
    _listController.animateTo(
      _listController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void sendMessage(String message, int sourceId, int targetId) {
    newMessage(message);
    socket.emit("message", {
      "message": message,
      "sourceId": sourceId,
      "targetId": targetId,
    });
    print(message);
    setState(() {
      showSendButton = false;
    });
    _needsScroll = true;
  }

  void newMessage(String message) {
    CommunityMessageModel newMsg = CommunityMessageModel(
      comments: 12,
      likes: 100,
      message: message,
      time: DateTime.now(),
      views: 200,
      senderDetails: widget.community.members[0],
    );
    setState(() {
      messages.add(newMsg);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_needsScroll) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => scrollToEnd(),
      );
      _needsScroll = false;
    }
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (socket.connected) {
          socket.disconnect();
          print('disconnected');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 110,
          scrolledUnderElevation: 0,
          leading: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
              ),
              Avatar(
                mode: Mode.flinnMate,
                outerRadius: 18,
                gender: widget.source.gender,
              ),
            ],
          ),
          title: TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) =>
                      CommunityInfoScreen(community: widget.community),
                ),
              );
            },
            child: Text(
              widget.community.name,
              style: GoogleFonts.amaranth(
                fontSize: 22,
                color: Colors.black,
              ),
            ),
          ),
          actions: [
            CommunityChatPopup(
              clearChat: () {
                setState(() {
                  messages = [];
                });
              },
              community: widget.community,
            ),
          ],
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
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(225, 210, 239, 0.28),
                Color.fromRGBO(253, 252, 255, 0),
              ],
              stops: [0.0, 0.2],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: PopScope(
            canPop: !emojiShowing,
            onPopInvoked: (onPop) {
              if (emojiShowing) {
                setState(() {
                  emojiShowing = false;
                });
              }
            },
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _listController,
                    itemCount: messages.length,
                    itemBuilder: (ctx, index) {
                      if (messages[index].senderDetails.id ==
                          widget.source.id) {
                        return CommunityOwnMessageCard(
                          message: messages[index],
                          time: messages[index].time,
                          source: widget.source,
                        );
                      } else {
                        return CommunityReplyCard(
                          message: messages[index],
                          time: messages[index].time,
                        );
                      }
                    },
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 5),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 66,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            color: const Color.fromRGBO(245, 233, 255, 1),
                            elevation: 0,
                            child: TextFormField(
                              controller: _controller,
                              focusNode: focusNode,
                              textAlignVertical:
                                  const TextAlignVertical(y: -0.3),
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
                              textCapitalization: TextCapitalization.sentences,
                              onChanged: (value) {
                                if (value.trim().isNotEmpty) {
                                  setState(() {
                                    showSendButton = true;
                                  });
                                } else {
                                  setState(() {
                                    showSendButton = false;
                                  });
                                }
                              },
                              style: GoogleFonts.amaranth(fontSize: 18),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(5),
                                prefixIcon: IconButton(
                                  onPressed: () {
                                    if (emojiShowing) {
                                      focusNode.requestFocus();
                                    } else {
                                      focusNode.unfocus();
                                      focusNode.canRequestFocus = false;
                                    }
                                    setState(() {
                                      emojiShowing = !emojiShowing;
                                    });
                                  },
                                  icon: Icon(
                                    (!emojiShowing)
                                        ? Icons.emoji_emotions_outlined
                                        : Icons.keyboard,
                                    color:
                                        const Color.fromRGBO(152, 103, 197, 1),
                                    size: 28,
                                  ),
                                ),
                                hintText: "Type a message",
                                hintStyle: GoogleFonts.amaranth(fontSize: 18),
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (ctx) => const Attachments(),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.attach_file_outlined,
                                        size: 28,
                                        color: Color.fromRGBO(152, 103, 197, 1),
                                      ),
                                    ),
                                    (!showSendButton)
                                        ? IconButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      const CameraScreen(),
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.camera_alt_outlined,
                                              size: 28,
                                              color: Color.fromRGBO(
                                                  152, 103, 197, 1),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor:
                              const Color.fromRGBO(152, 103, 197, 1),
                          child: IconButton(
                            onPressed: () {
                              if (showSendButton) {
                                sendMessage(
                                  _controller.text.trim(),
                                  widget.source.id,
                                  widget.community.id,
                                );
                                _controller.clear();
                                print(widget.source.id);
                                print(widget.community.id);
                              }
                            },
                            icon: Icon(
                              (!showSendButton) ? Icons.mic_none : Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Offstage(
                  offstage: !emojiShowing,
                  child: SizedBox(
                    height: 250,
                    child: EmojiPicker(
                      onEmojiSelected: (category, emoji) {
                        if (emoji.emoji.trim().isNotEmpty) {
                          setState(() {
                            showSendButton = true;
                          });
                        } else {
                          setState(() {
                            showSendButton = false;
                          });
                        }
                      },
                      textEditingController: _controller,
                      onBackspacePressed: () {
                        _onBackspacePressed();
                        if (_controller.text.trim().isNotEmpty) {
                          setState(() {
                            showSendButton = true;
                          });
                        } else {
                          setState(() {
                            showSendButton = false;
                          });
                        }
                      },
                      config: const Config(
                        emojiSizeMax: 30,
                        indicatorColor: Color.fromRGBO(152, 103, 197, 1),
                        iconColorSelected: Color.fromRGBO(152, 103, 197, 1),
                        backspaceColor: Color.fromRGBO(152, 103, 197, 1),
                      ),
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
