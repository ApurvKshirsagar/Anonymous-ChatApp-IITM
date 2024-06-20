import 'package:flinnit/anonymous/widgets/attachment_button.dart';
import 'package:flutter/material.dart';

class Attachments extends StatelessWidget {
  const Attachments({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: const Card(
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 65),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AttachmentButton(
              text: 'File',
              icon: Icons.insert_drive_file_outlined,
            ),
            AttachmentButton(
              text: 'Gallery',
              icon: Icons.photo,
            ),
            AttachmentButton(
              text: 'Audio',
              icon: Icons.audiotrack_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
