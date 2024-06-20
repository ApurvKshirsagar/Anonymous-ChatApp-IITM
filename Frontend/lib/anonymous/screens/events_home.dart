import 'package:flutter/material.dart';

class EventsHome extends StatefulWidget {
  const EventsHome({super.key});

  @override
  State<EventsHome> createState() {
    return _EventsHomeState();
  }
}

class _EventsHomeState extends State<EventsHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: const Center(
        child: Text('Events'),
      ),
    );
  }
}
