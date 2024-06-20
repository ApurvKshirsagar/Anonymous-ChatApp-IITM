import 'package:flinnit/anonymous/models/chat_users.dart';
import 'package:flinnit/anonymous/widgets/chat_list.dart';
import 'package:flinnit/community/screens/create_community.dart';
import 'package:flinnit/presentation/flinnit_icon_icons.dart';
import 'package:flinnit/anonymous/screens/anonymous_home.dart';
import 'package:flinnit/community/screens/community_home.dart';
import 'package:flinnit/anonymous/screens/events_home.dart';
import 'package:flinnit/anonymous/screens/match_page.dart';
import 'package:flinnit/anonymous/widgets/anonymous_drawer.dart';
import 'package:flinnit/anonymous/widgets/avatar.dart';
import 'package:flinnit/anonymous/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flinnit/anonymous/data/chat_users.dart';
import 'package:flinnit/expandable_fab.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class TabsScreen extends StatefulWidget {
  const TabsScreen({
    required this.source,
    super.key,
  });

  final ChatUsers source;

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> with WidgetsBindingObserver {
  var _selectedPageIndex = 0;
  Mode activeMode = Mode.flinnMate;
  var isSearching = false;
  String searchText = '';
  var chatSelected = 0;
  late PreferredSizeWidget notSelectedAppbar;
  late PreferredSizeWidget selectedAppbar;
  final _controller = ChatListController();
  late io.Socket socket;
  var canGoBack = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    connect();
    // socket.on("disconnectionAllowed", (_) {
    //   socket.disconnect();
    // });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // socket.emit("closedFlinnit", widget.source.id);
      socket.disconnect();
    } else if (state == AppLifecycleState.resumed) {
      connect();
    }
  }

  void selectTab(index) {
    setState(() {
      _selectedPageIndex = index;
      chatSelected = 0;
      isSearching = false;
      searchText = '';
    });
  }

  void connect() {
    print('connect function called');
    socket =
        io.io("https://osprey-stirring-maggot.ngrok-free.app", <String, dynamic>{
      "transports": ["websocket"],
      "autoconnect": false,
    });
    socket.connect();
    socket.emit("openedFlinnit", widget.source.id);
  }

  int get numberOfUnopenedChats {
    int counter = 0;

    for (int i = 0; i < chatUsers.length; i++) {
      if (chatUsers[i].unreadMessages != 0) {
        counter++;
      }
    }

    return counter;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      AnonymousHome(
        activeMode: activeMode,
        source: widget.source,
        socket: socket,
        isSearching: isSearching,
        searchText: searchText,
        onSelectAnonymous: (value) {
          setState(() {
            chatSelected = value;
          });
        },
        onOpenChat: () {
          setState(() {
            isSearching = false;
            searchText = '';
          });
        },
        controller: _controller,
      ),
      CommunityHome(
        isSearching: isSearching,
        searchText: searchText,
        source: widget.source,
        onOpenChat: () {
          setState(() {
            isSearching = false;
            searchText = '';
          });
        },
      ),
      const EventsHome(),
    ];

    return PopScope(
      canPop: !isSearching,
      onPopInvoked: (didPop) {
        setState(() {
          isSearching = false;
          searchText = '';
        });
      },
      child: Scaffold(
        drawerEdgeDragWidth: double.infinity,
        appBar: (chatSelected > 0)
            ? AppBar(
                // scrolledUnderElevation: 0,
                leading: IconButton(
                  onPressed: () {
                    setState(() {
                      chatSelected = 0;
                    });
                    _controller.deselectAllChats();
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.push_pin),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.mic),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.merge),
                  ),
                  PopupMenuButton(
                    itemBuilder: (ctx) => [
                      PopupMenuItem(
                        child: const Text('Select all'),
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
                // flexibleSpace: Container(
                //   decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //       colors: (activeMode == Mode.flinnMate)
                //           ? [
                //               const Color.fromARGB(255, 152, 103, 197),
                //               const Color.fromRGBO(225, 210, 239, 0.28),
                //             ]
                //           : [
                //               const Color.fromARGB(255, 255, 53, 111),
                //               const Color.fromRGBO(254, 160, 189, 0.4615),
                //             ],
                //       begin: Alignment.topCenter,
                //       end: Alignment.bottomCenter,
                //     ),
                //   ),
                // ),
              )
            : AppBar(
                // scrolledUnderElevation: 0,
                leading: (isSearching)
                    ? null
                    : Builder(
                        builder: (context) {
                          return IconButton(
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                            icon: const Icon(
                              Icons.menu,
                              color: Color.fromRGBO(70, 27, 106, 1),
                            ),
                          );
                        },
                      ),
                title: (!isSearching)
                    ? Text(
                        'Flinnit',
                        style: GoogleFonts.amaranth(
                          color: const Color.fromRGBO(70, 27, 106, 1),
                          fontSize: 30,
                        ),
                      )
                    : SearchTextField(
                        search: (value) {
                          setState(() {
                            searchText = value;
                          });
                        },
                        onBack: () {
                          setState(() {
                            isSearching = false;
                            searchText = '';
                          });
                        },
                      ),
                actions: (!isSearching)
                    ? [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isSearching = true;
                            });
                          },
                          icon: const Icon(
                            Icons.search,
                            size: 28,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (widget.source.gender == Gender.female)
                                ? const Color.fromRGBO(255, 141, 199, 1)
                                : const Color.fromRGBO(69, 109, 209, 1),
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: (_selectedPageIndex == 0)
                                ? PopupMenuButton(
                                    elevation: 2.5,
                                    // shadowColor: Colors.purple,
                                    surfaceTintColor: Colors.white,
                                    offset: Offset(
                                      -5,
                                      AppBar().preferredSize.height,
                                    ),
                                    itemBuilder: (ctx) => [
                                      PopupMenuItem(
                                        onTap: () {
                                          setState(() {
                                            activeMode = Mode.flinnDate;
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Avatar(
                                              mode: Mode.flinnDate,
                                              outerRadius: 16,
                                              gender: widget.source.gender,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Flinn-Date',
                                              style: GoogleFonts.amaranth(
                                                fontSize: 20,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        onTap: () {
                                          setState(() {
                                            activeMode = Mode.flinnMate;
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Avatar(
                                              gender: widget.source.gender,
                                              outerRadius: 16,
                                              mode: Mode.flinnMate,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Flinn-Mate',
                                              style: GoogleFonts.amaranth(
                                                fontSize: 20,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                    icon: Icon(
                                      (activeMode == Mode.flinnMate)
                                          ? Icons.emoji_emotions
                                          : Icons.heart_broken,
                                      // size: 28,
                                    ),
                                  )
                                : Icon(
                                    (activeMode == Mode.flinnMate)
                                        ? Icons.emoji_emotions
                                        : Icons.heart_broken,
                                    // size: 28,
                                  ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        )
                      ]
                    : [],
                bottom: (isSearching)
                    ? const PreferredSize(
                        preferredSize: Size.fromHeight(7),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Divider(),
                        ),
                      )
                    : null,
                // flexibleSpace: Container(
                //   decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //       colors: (_selectedPageIndex == 0)
                //           ? (activeMode == Mode.flinnMate)
                //               ? [
                //                   const Color.fromARGB(255, 152, 103, 197),
                //                   const Color.fromRGBO(225, 210, 239, 0.28),
                //                 ]
                //               : [
                //                   const Color.fromARGB(255, 255, 53, 111),
                //                   const Color.fromRGBO(254, 160, 189, 0.4615),
                //                 ]
                //           : [
                //               const Color.fromARGB(255, 152, 103, 197),
                //               const Color.fromRGBO(225, 210, 239, 0.28),
                //             ],
                //       begin: Alignment.topCenter,
                //       end: Alignment.bottomCenter,
                //     ),
                //   ),
                // ),
              ),
        drawer: (!isSearching)
            ? AnonymousDrawer(
                activeMode: activeMode,
                myGender: widget.source.gender,
                myName: widget.source.name,
                pageIndex: _selectedPageIndex,
              )
            : null,
        body: pages[_selectedPageIndex],
        floatingActionButton: (_selectedPageIndex == 0)
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => MatchPage(
                        activeMode: activeMode,
                        source: widget.source,
                      ),
                    ),
                  );
                },
                shape: const CircleBorder(eccentricity: 0),
                child: const Icon(
                  Icons.add,
                  size: 35,
                ),
              )
            : (_selectedPageIndex == 1)
                ? ExpandableFab(
                    distance: 112,
                    children: [
                      ActionButton(
                        onPressed: () {},
                        icon: const Icon(Icons.group_add_outlined),
                      ),
                      ActionButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => CreateCommunityScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  )
                : null,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 7,
            horizontal: 25,
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromRGBO(152, 103, 197, 1),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              unselectedItemColor: const Color.fromRGBO(152, 103, 197, 1),
              selectedFontSize: 0,
              unselectedFontSize: 0,
              onTap: selectTab,
              currentIndex: _selectedPageIndex,
              items: [
                BottomNavigationBarItem(
                  icon: CircleAvatar(
                    radius: 23,
                    backgroundColor: (_selectedPageIndex == 0)
                        ? const Color.fromRGBO(152, 103, 197, 1)
                        : Colors.transparent,
                    child: Stack(
                      children: [
                        Icon(
                          FlinnitIcon.teenyicons_chat_outline,
                          color: (_selectedPageIndex != 0)
                              ? const Color.fromRGBO(152, 103, 197, 1)
                              : Colors.white,
                        ),
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 12,
                              minHeight: 12,
                            ),
                            child: Text(
                              numberOfUnopenedChats.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: CircleAvatar(
                    radius: 23,
                    backgroundColor: (_selectedPageIndex == 1)
                        ? const Color.fromRGBO(152, 103, 197, 1)
                        : Colors.transparent,
                    child: Icon(
                      FlinnitIcon.vector,
                      color: (_selectedPageIndex != 1)
                          ? const Color.fromRGBO(152, 103, 197, 1)
                          : Colors.white,
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: CircleAvatar(
                    radius: 23,
                    backgroundColor: (_selectedPageIndex == 2)
                        ? const Color.fromRGBO(152, 103, 197, 1)
                        : Colors.transparent,
                    child: Icon(
                      FlinnitIcon.vector__1_,
                      color: (_selectedPageIndex != 2)
                          ? const Color.fromRGBO(152, 103, 197, 1)
                          : Colors.white,
                    ),
                  ),
                  label: '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
