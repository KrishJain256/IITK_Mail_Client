import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iitk_mail_client/components/email_banner.dart';
import 'package:iitk_mail_client/components/pfp.dart';
import 'package:iitk_mail_client/compose.dart';
import 'package:iitk_mail_client/models/email_banner.dart';
import 'dart:io';
import 'package:enough_mail/enough_mail.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mime/mime.dart';

import 'models/tabs.dart';

class homepage extends StatefulWidget {
  const homepage({super.key, required this.title});
  final String title;

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> with SingleTickerProviderStateMixin{

  late TabController tabController;
  List<EmailTab> tabs = [
    EmailTab("Inbox",Icons.inbox_rounded),
    EmailTab("Sent",Icons.send_sharp),
    EmailTab("Starred",Icons.star_border),
  ];

  List<MimeMessage> emails = [];

  void fetchMails() async{
    final client = ImapClient(isLogEnabled: false);
    try {
      await client.connectToServer("qasid.iitk.ac.in",993,
          isSecure:true);
      await client.login("krishjain23", "D1y_8U-leK");
      final mailboxes = await client.listMailboxes();
      print('mailboxes: $mailboxes');
      await client.selectInbox();
      // fetch 10 most recent messages:
      final fetchResult = await client.fetchRecentMessages(
          messageCount: 10, criteria: 'BODY.PEEK[]');
      setState(() {
        emails = fetchResult.messages;
      });
      await client.logout();
    } on ImapException catch (e) {
      print('IMAP failed with $e');
    }
  }


  @override
  void initState(){
    tabController = TabController(length: 3, vsync: this);
    // setState(() {
    //   this.emails = fetchMails() as List<Email>;
    // });
    // this.emails = fetchMails() as List<Email>;
    fetchMails();
    super.initState();
  }

  // Variables
  Color _starcolor = Colors.black54;
  IconData _star = Icons.star_border as IconData;


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) => compose()));
      },child: Icon(Icons.edit),),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.center ,
            colors: [Color(0xff1653ef), Colors.white],
          )
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 25,left: 7),
                    child: Column(
                      children: [
                        AppBar(
                          leading: pfp(),
                          title: SearchBar(
                            hintText: "Search mails",
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        TabBar(
                          controller: tabController,
                          tabs: List.generate(3, (index) => Tab(
                            height: 50,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                  Icon(tabs[index].iconData),
                                Text(tabs[index].text),
                              ],
                            ),
                          )),
                          automaticIndicatorColorAdjustment: true,
                          indicatorWeight: 2,
                          indicatorSize: TabBarIndicatorSize.tab,
                        ),
                        // CarouselSlider(
                        //     items: [
                        //       CircleAvatar(
                        //         radius: 50,
                        //         backgroundColor: Colors.white,
                        //         backgroundImage: "https://static.vecteezy.com/system/resources/previews/029/284/964/original/google-logo-on-transparent-background-popular-search-engine-google-logotype-symbol-icon-google-sign-stock-free-vector.jpg".isNotEmpty ? NetworkImage("https://static.vecteezy.com/system/resources/previews/029/284/964/original/google-logo-on-transparent-background-popular-search-engine-google-logotype-symbol-icon-google-sign-stock-free-vector.jpg") : null,
                        //       ),
                        //       CircleAvatar(
                        //         radius: 50,
                        //         backgroundColor: Colors.white,
                        //         backgroundImage: "https://1000logos.net/wp-content/uploads/2016/10/Apple-Logo.png".isNotEmpty ? NetworkImage("https://1000logos.net/wp-content/uploads/2016/10/Apple-Logo.png"): null,
                        //       ),
                        //
                        //     ],
                        //     options: CarouselOptions(
                        //         height: 60,
                        //       enlargeCenterPage: false,
                        //
                        //     )),


                      ],
                    ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 198),
                    child: Column(
                      children: [
                        Container(
                          width: size.width,
                          height: size.height - 250,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: ListView.builder(itemBuilder: (context,index) =>
                            email_banner(message: emails[index]),
                            itemCount: emails.length,
                          ),
                          // child: SingleChildScrollView(
                          //   child: Column(
                          //     children: [
                          //         Padding(
                          //           padding: EdgeInsets.only(left: 10,right: 10),
                          //           child: Column(
                          //             children: [
                          //               SizedBox(
                          //                 height: 10,
                          //               ),
                          //               AppBar(
                          //                 toolbarHeight: 70,
                          //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                          //                 leading: pfp(),
                          //                 title:
                          //                 Align(
                          //                   alignment: Alignment.topLeft,
                          //                   child: Column(
                          //                     children: [
                          //                       Align(
                          //                         alignment: Alignment.topLeft,
                          //                         child:  Text(
                          //                             "Krish Jain",
                          //                             textAlign: TextAlign.left,
                          //                             style: GoogleFonts.ubuntu(
                          //                               color: Colors.black,
                          //                               fontWeight: FontWeight.bold,
                          //                               fontSize: 17,
                          //                             )
                          //                         ),
                          //                       ),
                          //                       Align(
                          //                         alignment: Alignment.topLeft,
                          //                         child: Text(
                          //                             "Reconciliation of Purana",
                          //                             textAlign: TextAlign.left,
                          //                             style: GoogleFonts.ubuntu(
                          //                               color: Colors.black,
                          //                               fontSize: 23,
                          //                             )
                          //                         ),
                          //                       ),
                          //
                          //                     ],
                          //                   ),
                          //                 ),
                          //                 actions: [
                          //                   Column(
                          //                     children: [
                          //                       Align(
                          //                         alignment: Alignment.topCenter,
                          //                         child: Text("12:24 PM",style: GoogleFonts.ubuntu(color:Colors.black,fontSize:12)),
                          //                       ),
                          //                       // SizedBox(
                          //                       //   height: 5,
                          //                       // ),
                          //                       Row(
                          //                         children: [
                          //                           IconButton(
                          //                             icon: Icon(
                          //                               Icons.reply,
                          //                               semanticLabel: "Reply",
                          //                               color: Colors.black54,
                          //                             ),
                          //                             iconSize: 24,
                          //                             onPressed: () {  },
                          //                           ),
                          //                           IconButton(
                          //                             icon: Icon(
                          //                               _star,
                          //                               color: _starcolor,
                          //                               semanticLabel: "Mark as Important",
                          //                             ),
                          //                             iconSize: 24,
                          //                             onPressed: () {
                          //                               setState(() {
                          //                                 _star = Icons.star;
                          //                                 _starcolor = Colors.deepOrangeAccent;
                          //                               });
                          //                             },
                          //                           ),
                          //                         ],
                          //                       )
                          //                     ],
                          //                   )
                          //                 ],
                          //               ),
                          //               Divider(
                          //                 thickness: 1,
                          //               )
                          //             ],
                          //           ),
                          //         ),
                          //         email_banner(),
                          //         email_banner(),
                          //         email_banner(),
                          //       email_banner(),
                          //       email_banner(),
                          //       email_banner(),
                          //       email_banner(),
                          //       email_banner(),
                          //       email_banner(),
                          //
                          //       ],
                          //   ),
                          // )

                        )
                      ]
                    ),
                )

              ],
            )
          ],
        ),
      ),
    );
  }
}

// class _homepageState extends State<homepage> {
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 ClipPath(
//                   clipper: DrawClip2(),
//                   child: Container(
//                     width: size.width,
//                     height: size.height * 0.8,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                           colors: [Color(0xffa58fd2), Color(0xffddc3fc)],
//                           begin: Alignment.bottomCenter,
//                           end: Alignment.bottomRight),
//                     ),
//                   ),
//                 ),
//                 ClipPath(
//                   clipper: DrawClip(),
//                   child: Container(
//                     width: size.width,
//                     height: size.height * 0.8,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                           colors: [Color(0xffddc3fc), Color(0xff91c5fc)],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 50.0),
//                   child: Column(
//                     children: [
//                       Text(
//                         "Login",
//                         style: GoogleFonts.ubuntu(
//                             color: Colors.white,
//                             fontSize: 35,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(
//                         height: 40,
//                       ),
//                       input("Username", false),
//                       input("Password", true),
//                       SizedBox(
//                         height: 20,
//                       ),
//
//                       TextButton(
//                         // null for now , since its just UI
//                         onPressed: null,
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               vertical: 10, horizontal: 40),
//                           child: Container(
//                               decoration: BoxDecoration(
//                                   color: Color(0xff6a74ce),
//                                   borderRadius: BorderRadius.circular(30)),
//                               height: 50,
//                               child: Center(
//                                   child: Text(
//                                     "Login",
//                                     style: GoogleFonts.ubuntu(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold),
//                                   ))),
//                         ),
//                       ),
//                       Text(
//                         "Forgot your password?",
//                         style: GoogleFonts.ubuntu(
//                             color: Colors.white, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             Text(
//               "Connect with us",
//               style: GoogleFonts.ubuntu(
//                   color: Colors.blueGrey, fontWeight: FontWeight.bold),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                             color: Color(0xff38a4ef),
//                             offset: Offset(3.0, 3.0),
//                             blurRadius: 15,
//                             spreadRadius: 1.0),
//                         BoxShadow(
//                             color: Colors.white,
//                             offset: Offset(-3.0, -3.0),
//                             blurRadius: 15,
//                             spreadRadius: 1.0),
//                       ],
//                       borderRadius: BorderRadius.circular(30),
//                       color: Color(0xff38a4ef),
//                     ),
//                     height: 40,
//                     width: 160,
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20),
//                       child: Row(
//                         children: [
//                           Image.asset("assets/facebook.png"),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Text(
//                             "Facebook",
//                             style: GoogleFonts.ubuntu(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                             color: Color(0xff38a4ef),
//                             offset: Offset(3.0, 3.0),
//                             blurRadius: 15,
//                             spreadRadius: 1.0),
//                         BoxShadow(
//                             color: Colors.white,
//                             offset: Offset(-3.0, -3.0),
//                             blurRadius: 15,
//                             spreadRadius: 1.0),
//                       ],
//                       borderRadius: BorderRadius.circular(30),
//                       color: Color(0xff5172b4),
//                     ),
//                     height: 40,
//                     width: 160,
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20),
//                       child: Row(
//                         children: [
//                           Image.asset("assets/twitter.png",
//                               color: Colors.white),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Text(
//                             "Twitter",
//                             style: GoogleFonts.ubuntu(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Don't have an account? ",
//                   style: GoogleFonts.ubuntu(
//                       color: Colors.black, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Text(
//                   "Sign Up",
//                   style: GoogleFonts.ubuntu(
//                       color: Colors.black, fontWeight: FontWeight.bold),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// Widget input(String hint, bool pass) {
//   return Padding(
//     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
//     child: Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(30), color: Colors.white),
//       child: TextFormField(
//         decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: GoogleFonts.ubuntu(color: Colors.grey),
//             contentPadding: EdgeInsets.only(top: 15, bottom: 15),
//             prefix: pass
//                 ? Icon(Icons.lock_outline, color: Colors.grey)
//                 : Icon(Icons.person_outline, color: Colors.grey),
//             suffixIcon: pass
//                 ? null
//                 : Icon(Icons.assignment_turned_in_rounded,
//                 color: Colors.greenAccent),
//             border: UnderlineInputBorder(borderSide: BorderSide.none)),
//       ),
//     ),
//   );
// }
//
// class DrawClip extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(0, size.height * 0.80);
//     path.cubicTo(size.width / 4, size.height, 3 * size.width / 4,
//         size.height / 2, size.width, size.height * 0.8);
//     path.lineTo(size.width, 0);
//     return path;
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }
//
// class DrawClip2 extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(0, size.height * 0.08);
//     path.cubicTo(size.width / 4, size.height, 3 * size.width / 4,
//         size.height / 2, size.width, size.height * 0.9);
//     path.lineTo(size.width, 0);
//     return path;
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }