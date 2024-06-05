import "package:enough_mail/enough_mail.dart";
import "package:flutter/material.dart";
import "package:get_time_ago/get_time_ago.dart";
import "package:iitk_mail_client/components/pfp.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iitk_mail_client/mailview.dart";
import "package:iitk_mail_client/models/email_banner.dart";

/// Home Page Email Banner
class email_banner extends StatelessWidget {
  final MimeMessage message;
  final String username;
  final String password;
  email_banner({super.key, required this.message, required this.username, required this.password});

  // Variables
  Color _starcolor = Colors.black54;
  IconData _star = Icons.star_border as IconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10,right: 10),
      child: Column(
        children: [
          TextButton(
              onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => mailview(email: this.message,username: username,password: password,)));
              },
              child: AppBar(
                toolbarHeight: 90,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                leading: pfp(userName: message.from.toString().split('"')[0]),
                title:
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      // SizedBox(
                      //   height: 10,
                      // ),
                      Align(
                        alignment: Alignment.topLeft,
                        child:  Text(
                            message.from.toString().split('"')[1],
                            textAlign: TextAlign.left,
                            style: GoogleFonts.ubuntu(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            message.decodeSubject()!,
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            style: GoogleFonts.ubuntu(
                              color: Colors.black,
                              fontSize: 18,
                            )
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            message.decodeTextPlainPart().toString(),
                            textAlign: TextAlign.left,
                            style: GoogleFonts.ubuntu(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          maxLines: 1,
                        ),
                      ),

                    ],
                  ),
                ),
                actions: [
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(GetTimeAgo.parse(message.decodeDate()!),style: GoogleFonts.ubuntu(color:Colors.black,fontSize:12)),
                      ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.reply,
                              semanticLabel: "Reply",
                              color: Colors.black54,
                            ),
                            iconSize: 24,
                            onPressed: () {  },
                          ),
                          IconButton(
                            icon: Icon(
                              _star,
                              color: _starcolor,
                              semanticLabel: "Mark as Important",
                            ),
                            iconSize: 24,
                            onPressed: () {
                              _star = Icons.star;
                              _starcolor = Colors.deepOrangeAccent;
                            },
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),

          ),
          Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }

}