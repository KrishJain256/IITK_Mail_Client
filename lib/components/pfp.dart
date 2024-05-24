import "package:flutter/material.dart";

class pfp extends StatelessWidget {
  final String profileImage;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50, // Adjust the radius for the size you want
      backgroundImage: profileImage.isNotEmpty ? NetworkImage(profileImage) : null,
      backgroundColor: Colors.grey.shade200, // A default color for the avatar
      child: profileImage.isEmpty ? Text(userName[0]) : null,
    );
  }

  pfp({this.profileImage = "https://img.freepik.com/free-photo/gray-smooth-textured-paper-background_53876-101833.jpg",this.userName = "NULL"});
}