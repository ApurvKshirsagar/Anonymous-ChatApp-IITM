import 'dart:io';

import 'package:flinnit/anonymous/widgets/typing.dart';
import 'package:flinnit/constant_variables.dart';
import 'package:flinnit/anonymous/models/chat_users.dart';
import 'package:flinnit/anonymous/models/message_model.dart';
import 'package:flinnit/anonymous/screens/camera_screen.dart';
import 'package:flinnit/anonymous/screens/target_profile.dart';
import 'package:flinnit/anonymous/widgets/attachments.dart';
import 'package:flinnit/anonymous/widgets/avatar.dart';
import 'package:flinnit/anonymous/widgets/chat_popup.dart';
import 'package:flinnit/anonymous/widgets/own_message_card.dart';
import 'package:flinnit/anonymous/widgets/reply_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.chatUser,
    required this.activeMode,
    required this.source,
    required this.socket,
  });

  final ChatUsers chatUser;
  final Mode activeMode;
  final ChatUsers source;
  final io.Socket socket;

  @override
  State<ChatScreen> createState() {
    return _ChatScreenState();
  }
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  var emojiShowing = false;
  final focusNode = FocusNode();
  final _listController = ScrollController();
  var showSendButton = false;
  var _needsScroll = false;
  // List<MessageModel> messages = widget.chatUser.messages;
  // late String room;
  var isTyping = false;

  @override
  void dispose() { 
    // widget.socket.emit('leaveRoom', {
    //   "target_id": widget.chatUser.id,
    //   "user_id": widget.source.id,
    //   "room": room,
    // });
    _controller.dispose();
    _listController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // room = (widget.chatUser.id < widget.source.id)
    //     ? '${widget.chatUser.id}_${widget.source.id}'
    //     : '${widget.source.id}_${widget.chatUser.id}';
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          emojiShowing = false;
        });
      }
    });
    _needsScroll = true;
  }

  void search() {}

  void _onBackspacePressed() {
    _controller
      ..text = _controller.text.characters.toString()
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
  }

  void connect() {
    // widget.socket.emit("joinRoom", {
    //   "target_id": widget.chatUser.id,
    //   "user_id": widget.source.id,
    //   "room": room,
    // });
    widget.socket.on("receiveMessage", (msg) {
      print('message received');
      newMessage(Sender.target, msg);
      if (mounted) {
        setState(() {
          isTyping = false;
        });
      }
    });
    widget.socket.on("isSeeing", (_) {
      if (mounted) {
        setState(() {
          isTyping = true;
        });
      }
      if (isTyping) {
        Future.delayed(
          Duration(milliseconds: 5000),
          () {
            if (mounted) {
              setState(() {
                isTyping = false;
              });
            }
          },
        );
      }
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
    newMessage(Sender.source, message);
    widget.socket.emit("privateMessage", {
      "target_id": widget.chatUser.id,
      "message": message,
    });
    setState(() {
      showSendButton = false;
    });
    _needsScroll = true;
  }

  void newMessage(Sender sender, String message) {
    MessageModel messageModel = MessageModel(
      message: message,
      sender: sender,
      time: DateTime.now(),
    );
    if (mounted) {
      setState(() {
        widget.chatUser.messages.add(messageModel);
      });
    }
    // if (_listController.position.pixels ==
    //     _listController.position.maxScrollExtent) {
    //   _needsScroll = true;
    // }
  }

  @override
  Widget build(BuildContext context) {
    if (_needsScroll) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => scrollToEnd(),
      );
      _needsScroll = false;
    }
    return Scaffold(
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
              mode: widget.activeMode,
              outerRadius: 18,
              gender: widget.chatUser.gender,
            ),
          ],
        ),
        title: TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => TargetProfilePage(
                  activeMode: widget.activeMode,
                  chatUser: widget.chatUser,
                ),
              ),
            );
          },
          child: Text(
            widget.chatUser.name,
            style: GoogleFonts.amaranth(
              fontSize: 22,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          ChatPopup(
            clearChat: () {
              setState(() {
                widget.chatUser.messages = [];
              });
            },
            chatUser: widget.chatUser,
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: (widget.activeMode == Mode.flinnMate)
                  ? [
                      const Color.fromARGB(255, 152, 103, 197),
                      const Color.fromRGBO(225, 210, 239, 0.28),
                    ]
                  : [
                      const Color.fromARGB(255, 255, 53, 111),
                      const Color.fromRGBO(254, 160, 189, 0.4615),
                    ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: (widget.activeMode == Mode.flinnMate)
                ? [
                    const Color.fromRGBO(225, 210, 239, 0.28),
                    const Color.fromRGBO(253, 252, 255, 0),
                  ]
                : [
                    const Color.fromRGBO(254, 160, 189, 0.4615),
                    const Color.fromRGBO(253, 252, 255, 0),
                  ],
            stops: const [0.0, 0.2],
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
                child: (isTyping)
                    ? ListView.builder(
                        controller: _listController,
                        itemCount: widget.chatUser.messages.length + 1,
                        itemBuilder: (ctx, index) {
                          if (index == widget.chatUser.messages.length) {
                            return TypingBubble(
                              activeMode: widget.activeMode,
                              chatUser: widget.chatUser,
                            );
                          } else if (widget.chatUser.messages[index].sender == Sender.source) {
                            return OwnMessageCard(
                              message: widget.chatUser.messages[index].message,
                              time: widget.chatUser.messages[index].time,
                              source: widget.source,
                              activeMode: widget.activeMode,
                            );
                          } else if (widget.chatUser.messages[index].sender == Sender.target) {
                            return ReplyCard(
                              message: widget.chatUser.messages[index].message,
                              time: widget.chatUser.messages[index].time,
                              activeMode: widget.activeMode,
                              chatUser: widget.chatUser,
                            );
                          }
                        },
                      )
                    : ListView.builder(
                        controller: _listController,
                        itemCount: widget.chatUser.messages.length,
                        itemBuilder: (ctx, index) {
                          if (widget.chatUser.messages[index].sender == Sender.source) {
                            return OwnMessageCard(
                              message: widget.chatUser.messages[index].message,
                              time: widget.chatUser.messages[index].time,
                              source: widget.source,
                              activeMode: widget.activeMode,
                            );
                          } else if (widget.chatUser.messages[index].sender == Sender.target) {
                            return ReplyCard(
                              message: widget.chatUser.messages[index].message,
                              time: widget.chatUser.messages[index].time,
                              activeMode: widget.activeMode,
                              chatUser: widget.chatUser,
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
                          color: (widget.activeMode == Mode.flinnMate)
                              ? const Color.fromRGBO(245, 233, 255, 1)
                              : const Color.fromRGBO(255, 76, 128, 0.15),
                          elevation: 0,
                          child: TextFormField(
                            controller: _controller,
                            focusNode: focusNode,
                            textAlignVertical: const TextAlignVertical(y: -0.3),
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
                              widget.socket
                                  .emit("isTyping", widget.chatUser.id);
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
                                  color: (widget.activeMode == Mode.flinnMate)
                                      ? const Color.fromRGBO(152, 103, 197, 1)
                                      : const Color.fromRGBO(255, 82, 132, 1),
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
                                    icon: Icon(Icons.attach_file_outlined,
                                        size: 28,
                                        color: (widget.activeMode ==
                                                Mode.flinnMate)
                                            ? const Color.fromRGBO(
                                                152, 103, 197, 1)
                                            : const Color.fromRGBO(
                                                255, 82, 132, 1)),
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
                                          icon: Icon(
                                            Icons.camera_alt_outlined,
                                            size: 28,
                                            color: (widget.activeMode ==
                                                    Mode.flinnMate)
                                                ? const Color.fromRGBO(
                                                    152, 103, 197, 1)
                                                : const Color.fromRGBO(
                                                    255, 82, 132, 1),
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
                        backgroundColor: (widget.activeMode == Mode.flinnMate)
                            ? const Color.fromRGBO(152, 103, 197, 1)
                            : const Color.fromRGBO(255, 82, 132, 1),
                        child: IconButton(
                          onPressed: () {
                            if (showSendButton) {
                              sendMessage(
                                _controller.text.trim(),
                                widget.source.id,
                                widget.chatUser.id,
                              );
                              _controller.clear();
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
                      widget.socket.emit("isTyping", widget.chatUser.id);
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
                      widget.socket.emit("isTyping", widget.chatUser.id);
                    },
                    config: Config(
                      emojiSizeMax: 30,
                      indicatorColor: (widget.activeMode == Mode.flinnMate)
                          ? const Color.fromRGBO(152, 103, 197, 1)
                          : const Color.fromRGBO(255, 82, 132, 1),
                      iconColorSelected: (widget.activeMode == Mode.flinnMate)
                          ? const Color.fromRGBO(152, 103, 197, 1)
                          : const Color.fromRGBO(255, 82, 132, 1),
                      backspaceColor: (widget.activeMode == Mode.flinnMate)
                          ? const Color.fromRGBO(152, 103, 197, 1)
                          : const Color.fromRGBO(255, 82, 132, 1),
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
