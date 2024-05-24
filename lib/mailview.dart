import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iitk_mail_client/components/pfp.dart";
import "package:iitk_mail_client/home.dart";
import "package:iitk_mail_client/models/email_banner.dart";


class mailview extends StatefulWidget {
  mailview({super.key, required this.email});
  final Email email;

  @override
  State<mailview> createState() => _mailviewState();
}


class _mailviewState extends State<mailview> {

  // Variables
  Color _starcolor = Colors.black54;
  IconData _star = Icons.star_border as IconData;

  @override
  Widget build(BuildContext context) {
    final dateTime = widget.email.dateTime!;
    var month = dateTime.month;
    var mapping = {1:"Jan",2:"Feb",3:"Mar",4:"Apr",5:"May",6:"June",7:"July",8:"Aug",9:"Sept",10:"Oct",11:"Nov",12:"Dec"};
    var monthname = mapping[month];
    var hour = dateTime.hour;
    var min = dateTime.minute;
    var day = dateTime.day;
    var month_str = "${monthname!} $day";
    var time_str = "$hour:$min";

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_sharp,
            size: 30,
            color: Colors.black54,
            semanticLabel: "Back",
          ),
          onPressed: () { 
            Navigator.push(context,MaterialPageRoute(builder: (context) => homepage(title: "Home Page")));
          },
        ),
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed : () { },
                  icon: Icon(
                    Icons.delete,
                    size: 30,
                    color: Colors.black54,
                  )
              ),
              IconButton(
                  onPressed : () { },
                  icon: Icon(
                    Icons.mark_email_unread_outlined,
                    size: 30,
                    color: Colors.black54,
                  )
              ),
              IconButton(
                  onPressed : () { },
                  icon: Icon(
                    Icons.more_vert,
                    size: 30,
                    color: Colors.black54,
                  )
              ),
            ],
          )
        ],
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                      AppBar(
                        toolbarHeight: 80,
                          title: Column(
                                children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(

                                  child: Text(
                                    widget.email.subject!,
                                    style: GoogleFonts.ubuntu(
                                      color : Colors.black,
                                      fontSize : 30,
                                    ),
                                    maxLines: 5,
                                    softWrap: true,
                                  ),
                                )

                              ),
                            ],
                          ),
                          actions: [
                            IconButton(
                              icon: Icon(
                                _star,
                                color: _starcolor,
                                semanticLabel: "Mark as Important",
                              ),
                              iconSize: 24,
                              onPressed: () {
                                setState(() {
                                  _star = Icons.star;
                                  _starcolor = Colors.deepOrangeAccent;
                                });
                              },
                            ),
                          ]

                  ),

                  Padding(
                      padding: EdgeInsets.only(top: 100, left: 15,right: 10),
                    child: AppBar(
                      foregroundColor: Colors.white,
                      leading: pfp(profileImage: widget.email.profileImage!,userName: widget.email.userName!),
                      title: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.email.userName!,
                                style: GoogleFonts.ubuntu(
                                  fontSize : 25,
                                  color : Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                width: 32,
                              ),
                              Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      month_str,
                                      style: GoogleFonts.ubuntu(
                                        color : Colors.black54,
                                        fontSize : 15,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      time_str,
                                      style: GoogleFonts.ubuntu(
                                        color : Colors.black54,
                                        fontSize : 15,
                                      ),
                                    ),
                                  ),

                                ],
                              )

                            ],
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "to ${widget.email.receivers?[0]}",
                              style: GoogleFonts.ubuntu(
                                color : Colors.black54,
                                fontSize : 20,
                              ),
                            ),
                          )
                        ],
                      ),
                      actions: [
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
                                onPressed : () { },
                                icon: Icon(
                                  Icons.more_vert,
                                  size: 24,
                                  color: Colors.black54,
                                )
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 180,left: 15,right: 10),
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              widget.email.body!,
                              maxLines: 100000000,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.ubuntu(
                                fontSize : 17,
                                color : Colors.black,

                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: AppBar(
                                backgroundColor: Colors.white,
                                actions: [
                                  OutlinedButton(
                                      onPressed: () {  },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.reply,
                                            size: 20,
                                            color: Colors.black54,
                                          ),
                                          Text(
                                            " Reply",
                                            style: GoogleFonts.ubuntu(
                                                color : Colors.black,
                                                fontSize : 15
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  OutlinedButton(
                                      onPressed: () {  },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.reply_all,
                                            size: 20,
                                            color: Colors.black54,
                                          ),
                                          Text(
                                            " Reply All",
                                            style: GoogleFonts.ubuntu(
                                                color : Colors.black,
                                                fontSize : 15
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  OutlinedButton(
                                      onPressed: () {  },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.send,
                                            size: 20,
                                            color: Colors.black54,
                                          ),
                                          Text(
                                            " Forward",
                                            style: GoogleFonts.ubuntu(
                                                color : Colors.black,
                                                fontSize : 15
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                ],
                              ),
                            )

                          ],
                        )

                      ),
                    ),
                  ),


                ],
              )
            ],
          ),
        )

      ),
    );
  }
}
