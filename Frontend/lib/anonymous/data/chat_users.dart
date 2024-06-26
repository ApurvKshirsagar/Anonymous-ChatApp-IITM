import 'package:flinnit/anonymous/models/chat_users.dart';
import 'package:flinnit/anonymous/models/message_model.dart';

List<ChatUsers> chatUsers = [
  ChatUsers(
    name: "Jujhar Singh",
    messages: [
      MessageModel(
        message: "Goo kha lo",
        sender: Sender.target,
        time: DateTime.now(),
      ),
    ],
    image: "images/userImage1.jpeg",
    time: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second,
    ),
    gender: Gender.male,
    unreadMessages: 4,
    id: 1,
    isSelected: false,
    flinnID: "FLINN000007",
    dateID: "M000007",
    activeDateChats: [],
    activeMateChats: ["FLINN000007"],
  ),
  ChatUsers(
    name: "Parth Bajpai",
    messages: [
      MessageModel(
        message: "Time is Money",
        sender: Sender.target,
        time: DateTime.now(),
      ),
    ],
    image: "images/userImage2.jpeg",
    time: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      1,
      32,
    ),
    gender: Gender.male,
    unreadMessages: 2,
    id: 2,
    isSelected: false,
    flinnID: "FLINN000006",
    dateID: "M000006",
    activeDateChats: [],
    activeMateChats: ["FLINN000006"],
  ),
  ChatUsers(
    name: "Dikshant Aggarwal",
    messages: [
      MessageModel(
        message: "Bas 1.5 km",
        sender: Sender.target,
        time: DateTime.now(),
      ),
    ],
    image: "images/userImage3.jpeg",
    time: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day - 1,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second,
    ),
    gender: Gender.male,
    unreadMessages: 0,
    id: 3,
    isSelected: false,
    flinnID: "FLINN000004",
    dateID: "M000004",
    activeDateChats: [],
    activeMateChats: ["FLINN000004"],
  ),
  ChatUsers(
    name: "Anantu S Pai",
    messages: [
      MessageModel(
        message: "Maar maarke kutta bana dunga",
        sender: Sender.target,
        time: DateTime.now(),
      ),
    ],
    image: "images/userImage4.jpeg",
    time: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second,
    ),
    gender: Gender.male,
    unreadMessages: 0,
    id: 4,
    isSelected: false,
    flinnID: "FLINN000001",
    dateID: "M000001",
    activeDateChats: ["F000003", "F000004", "F000002", "F000001"],
    activeMateChats: ["FLINN000001"],
  ),
  ChatUsers(
    name: "Rutuja Kastewad",
    messages: [
      MessageModel(
        message: "Aee bhagwaannnn",
        sender: Sender.target,
        time: DateTime.now(),
      ),
    ],
    image: "images/userImage5.jpeg",
    time: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second,
    ),
    gender: Gender.female,
    unreadMessages: 1,
    id: 5,
    isSelected: false,
    flinnID: "FLINN000011",
    dateID: "F000003",
    activeDateChats: ["M000001"],
    activeMateChats: ["FLINN000011"],
  ),
  ChatUsers(
    name: "Yashika Sahu",
    messages: [
      MessageModel(
        message: "Main mar jaungi",
        sender: Sender.target,
        time: DateTime.now(),
      ),
    ],
    image: "images/userImage6.jpeg",
    time: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second,
    ),
    gender: Gender.female,
    unreadMessages: 23,
    id: 6,
    isSelected: false,
    flinnID: "FLINN000012",
    dateID: "F000004",
    activeDateChats: ["M000001"],
    activeMateChats: ["FLINN000012"],
  ),
  ChatUsers(
    name: "Anshu Patel",
    messages: [
      MessageModel(
        message: "Ae behen ke *****",
        sender: Sender.target,
        time: DateTime.now(),
      ),
    ],
    image: "images/userImage7.jpeg",
    time: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second,
    ),
    gender: Gender.male,
    unreadMessages: 0,
    id: 7,
    isSelected: false,
    flinnID: "FLINN000002",
    dateID: "M000002",
    activeDateChats: [],
    activeMateChats: ["FLINN000002"],
  ),
  ChatUsers(
    name: "Akshita Ananda",
    messages: [
      MessageModel(
        message: "Main maar dungiiii",
        sender: Sender.target,
        time: DateTime.now(),
      ),
    ],
    image: "images/userImage8.jpeg",
    time: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second,
    ),
    gender: Gender.female,
    unreadMessages: 0,
    id: 8,
    isSelected: false,
    flinnID: "FLINN000010",
    dateID: "F000002",
    activeDateChats: ["M000001"],
    activeMateChats: ["FLINN000010"],
  ),
  ChatUsers(
    name: "Aayush Chodhary",
    messages: [
      MessageModel(
        message: "Lite lo yaar",
        sender: Sender.target,
        time: DateTime.now(),
      ),
    ],
    image: "images/userImage8.jpeg",
    time: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second,
    ),
    gender: Gender.male,
    unreadMessages: 0,
    id: 9,
    isSelected: false,
    flinnID: "FLINN000003",
    dateID: "M000003",
    activeDateChats: [],
    activeMateChats: ["FLINN000003"],
  ),
  ChatUsers(
    name: "Piyush Dalmia",
    messages: [
      MessageModel(
        message: "Suad ka bacha",
        sender: Sender.target,
        time: DateTime.now(),
      ),
    ],
    image: "images/userImage8.jpeg",
    time: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second,
    ),
    gender: Gender.male,
    unreadMessages: 0,
    id: 10,
    isSelected: false,
    flinnID: "FLINN000005",
    dateID: "M000005",
    activeDateChats: [],
    activeMateChats: ["FLINN000005"],
  ),
  ChatUsers(
    name: "Apurv Kshirsagar",
    messages: [
      MessageModel(
        message: "Hamara desh kesa ho, france russia jesa ho",
        sender: Sender.target,
        time: DateTime.now(),
      ),
    ],
    image: "images/userImage8.jpeg",
    time: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second,
    ),
    gender: Gender.male,
    unreadMessages: 0,
    id: 11,
    isSelected: false,
    flinnID: "FLINN000008",
    dateID: "M000008",
    activeDateChats: [],
    activeMateChats: ["FLINN000008"],
  ),
  ChatUsers(
    name: "Radha Agrawal",
    messages: [
      MessageModel(
        message: "🤪🤪🤪",
        sender: Sender.target,
        time: DateTime.now(),
      ),
    ],
    image: "images/userImage8.jpeg",
    time: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second,
    ),
    gender: Gender.female,
    unreadMessages: 0,
    id: 12,
    isSelected: false,
    flinnID: "FLINN000009",
    dateID: "F000001",
    activeDateChats: ["M000001"],
    activeMateChats: ["FLINN000009"],
  ),
  ChatUsers(
    name: "Jagroop Singh",
    messages: [
      MessageModel(
        message: "Suhi kutti vangu pae jaa",
        sender: Sender.target,
        time: DateTime.now(),
      ),
    ],
    image: "images/userImage8.jpeg",
    time: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second,
    ),
    gender: Gender.male,
    unreadMessages: 0,
    id: 18,
    isSelected: false,
    flinnID: "FLINN000013",
    dateID: "M000010",
    activeDateChats: [],
    activeMateChats: [],
  ),
  ChatUsers(
    name: "Japsehaj Kaur",
    messages: [
      MessageModel(
        message: "xyz",
        sender: Sender.target,
        time: DateTime.now(),
      ),
    ],
    image: "images/userImage8.jpeg",
    time: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second,
    ),
    gender: Gender.female,
    unreadMessages: 0,
    id: 13,
    isSelected: false,
    flinnID: "FLINN000014",
    dateID: "F000005",
    activeDateChats: [],
    activeMateChats: [],
  ),
  ChatUsers(
    name: "Ishita Jariwala",
    messages: [
      MessageModel(
        message: "🤌",
        sender: Sender.target,
        time: DateTime.now(),
      ),
    ],
    image: "images/userImage8.jpeg",
    time: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second,
    ),
    gender: Gender.female,
    unreadMessages: 0,
    id: 14,
    isSelected: false,
    flinnID: "FLINN000015",
    dateID: "F000006",
    activeDateChats: [],
    activeMateChats: [],
  ),
  ChatUsers(
    name: "Hargun Kaur",
    messages: [
      MessageModel(
        message: "xyz",
        sender: Sender.target,
        time: DateTime.now(),
      ),
    ],
    image: "images/userImage8.jpeg",
    time: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second,
    ),
    gender: Gender.female,
    unreadMessages: 0,
    id: 15,
    isSelected: false,
    flinnID: "FLINN000016",
    dateID: "F000007",
    activeDateChats: [],
    activeMateChats: [],
  ),
  ChatUsers(
    name: "Rujuta Jariwala",
    messages: [
      MessageModel(
        message: "xyz",
        sender: Sender.target,
        time: DateTime.now(),
      ),
    ],
    image: "images/userImage8.jpeg",
    time: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second,
    ),
    gender: Gender.female,
    unreadMessages: 0,
    id: 16,
    isSelected: false,
    flinnID: "FLINN000017",
    dateID: "F000008",
    activeDateChats: [],
    activeMateChats: [],
  ),
  ChatUsers(
    name: "Hrishikesh Gudekar",
    messages: [
      MessageModel(
        message: "xyz",
        sender: Sender.target,
        time: DateTime.now(),
      ),
    ],
    image: "images/userImage8.jpeg",
    time: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second,
    ),
    gender: Gender.male,
    unreadMessages: 0,
    id: 17,
    isSelected: false,
    flinnID: "FLINN000018",
    dateID: "M000011",
    activeDateChats: [],
    activeMateChats: [],
  ),
];
