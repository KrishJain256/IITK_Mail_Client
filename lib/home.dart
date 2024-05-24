import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iitk_mail_client/components/email_banner.dart';
import 'package:iitk_mail_client/components/pfp.dart';
import 'package:iitk_mail_client/compose.dart';
import 'package:iitk_mail_client/models/email_banner.dart';

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

  List<Email> emails = [
    Email(
      profileImage: "https://i.redd.it/bcyq3rjk2w071.png",
      userName: "Krish Jain",
      subject: "Reconciliation of the Purana",
      body: """Dear colleagues,

*Onkar S. Mane* (22104067) from the Electrical Engineering department will defend his M.Tech. thesis on *17th May in ACES 213 at 3 pm*. The title and the abstract of the talk are given below. All interested are welcome to attend the same.

*Title*: An improved design of Waveguide-integrated Mach-Zehnder Interferometer mesh for programmable linear computation.

*Abstract*: The growth in computing demands driven by the advancements in artificial intelligence and data communication necessitate energy-efficient devices that can process information at high speeds and integrate seamlessly into compact platforms. Integrated photonic devices, networks of tuneable Mach-Zehnder Interferometers (MZI) in particular, have emerged as a promising platform for performing linear computational tasks. This study introduces a novel design of MZI, the basic building block of these networks, that is both significantly less complex and smaller than the conventional MZIs. Our redesigned MZI has a streamlined structure foregoing the curved bends in the conventional MZIs and occupies less than 1/10th of the area. This optimization also prevents bending losses, simplifies fabrication, and thus greatly enhances device scalability. This work is a significant step towards the realization of larger and denser MZI networks enabling applications in both classical and quantum information processing tasks.

Best regards,
Rituraj
(Thesis supervisor)""",
      dateTime: DateTime.now().subtract(const Duration(hours: 3)),
        receivers: ["Students","230572","230573","230574"]
    ),
    Email(
        profileImage: "https://i.redd.it/bcyq3rjk2w071.png",
        userName: "Krish Jain",
        subject: "Reconciliation of the Purana",
        body: """Dear colleagues,

*Onkar S. Mane* (22104067) from the Electrical Engineering department will defend his M.Tech. thesis on *17th May in ACES 213 at 3 pm*. The title and the abstract of the talk are given below. All interested are welcome to attend the same.

*Title*: An improved design of Waveguide-integrated Mach-Zehnder Interferometer mesh for programmable linear computation.

*Abstract*: The growth in computing demands driven by the advancements in artificial intelligence and data communication necessitate energy-efficient devices that can process information at high speeds and integrate seamlessly into compact platforms. Integrated photonic devices, networks of tuneable Mach-Zehnder Interferometers (MZI) in particular, have emerged as a promising platform for performing linear computational tasks. This study introduces a novel design of MZI, the basic building block of these networks, that is both significantly less complex and smaller than the conventional MZIs. Our redesigned MZI has a streamlined structure foregoing the curved bends in the conventional MZIs and occupies less than 1/10th of the area. This optimization also prevents bending losses, simplifies fabrication, and thus greatly enhances device scalability. This work is a significant step towards the realization of larger and denser MZI networks enabling applications in both classical and quantum information processing tasks.

Best regards,
Rituraj
(Thesis supervisor)""",
        dateTime: DateTime.now().subtract(const Duration(hours: 3)),
        receivers: ["Students","230572","230573","230574"]
    ),
    Email(
        profileImage: "https://i.redd.it/bcyq3rjk2w071.png",
        userName: "Krish Jain",
        subject: "Reconciliation of the Purana",
        body: """Dear colleagues,

*Onkar S. Mane* (22104067) from the Electrical Engineering department will defend his M.Tech. thesis on *17th May in ACES 213 at 3 pm*. The title and the abstract of the talk are given below. All interested are welcome to attend the same.

*Title*: An improved design of Waveguide-integrated Mach-Zehnder Interferometer mesh for programmable linear computation.

*Abstract*: The growth in computing demands driven by the advancements in artificial intelligence and data communication necessitate energy-efficient devices that can process information at high speeds and integrate seamlessly into compact platforms. Integrated photonic devices, networks of tuneable Mach-Zehnder Interferometers (MZI) in particular, have emerged as a promising platform for performing linear computational tasks. This study introduces a novel design of MZI, the basic building block of these networks, that is both significantly less complex and smaller than the conventional MZIs. Our redesigned MZI has a streamlined structure foregoing the curved bends in the conventional MZIs and occupies less than 1/10th of the area. This optimization also prevents bending losses, simplifies fabrication, and thus greatly enhances device scalability. This work is a significant step towards the realization of larger and denser MZI networks enabling applications in both classical and quantum information processing tasks.

Best regards,
Rituraj
(Thesis supervisor)""",
        dateTime: DateTime.now().subtract(const Duration(hours: 3)),
      receivers: ["Students","230572","230573","230574"]
    )
  ];

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
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
                    padding: EdgeInsets.only(top: 170),
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
                            email_banner(email: emails[index]),
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