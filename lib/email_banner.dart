import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class pfp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50, // Adjust the radius for the size you want
      backgroundImage: "https://hypixel.net/attachments/face-png.2475043/".isNotEmpty ? NetworkImage("https://hypixel.net/attachments/face-png.2475043/") : null,
      backgroundColor: Colors.grey.shade200, // A default color for the avatar
      child: "https://hypixel.net/attachments/face-png.2475043/".isEmpty ? Text("K") : null,
    );
  }
}

class email_banner extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: pfp(),
        title: Text(
          "Krish Jain",
          textAlign: TextAlign.left,
          style: GoogleFonts.ubuntu(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          )
        ),
        actions: [
          Text("12:24 PM",style: GoogleFonts.ubuntu(color:Colors.black,fontSize:12),)
        ],
      ),
    );
  }

}