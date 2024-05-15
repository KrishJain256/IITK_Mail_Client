import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";


class mailview extends StatefulWidget {
  const mailview({super.key, required this.title});
  final String title;

  @override
  State<mailview> createState() => _mailviewState();
}


class pfp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50, // Adjust the radius for the size you want
      backgroundImage: "https://i.redd.it/bcyq3rjk2w071.png".isNotEmpty ? NetworkImage("https://i.redd.it/bcyq3rjk2w071.png") : null,
      backgroundColor: Colors.grey.shade200, // A default color for the avatar
      child: "https://i.redd.it/bcyq3rjk2w071.png".isEmpty ? Text("K") : null,
    );
  }
}

class _mailviewState extends State<mailview> {

  // Variables
  Color _starcolor = Colors.black54;
  IconData _star = Icons.star_border as IconData;

  @override
  Widget build(BuildContext context) {
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
          onPressed: () {  },
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
                                    "Reconciliation of Purana by Krish Jain",
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
                      leading: pfp(),
                      title: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Krish Jain",
                                style: GoogleFonts.ubuntu(
                                  fontSize : 25,
                                  color : Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  "12:24 PM",
                                  style: GoogleFonts.ubuntu(
                                    color : Colors.black54,
                                    fontSize : 15,
                                  ),
                                ),
                              ),

                            ],
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "to Krish Jain",
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
                              """Dear colleagues,

*Onkar S. Mane* (22104067) from the Electrical Engineering department will defend his M.Tech. thesis on *17th May in ACES 213 at 3 pm*. The title and the abstract of the talk are given below. All interested are welcome to attend the same.

*Title*: An improved design of Waveguide-integrated Mach-Zehnder Interferometer mesh for programmable linear computation.

*Abstract*: The growth in computing demands driven by the advancements in artificial intelligence and data communication necessitate energy-efficient devices that can process information at high speeds and integrate seamlessly into compact platforms. Integrated photonic devices, networks of tuneable Mach-Zehnder Interferometers (MZI) in particular, have emerged as a promising platform for performing linear computational tasks. This study introduces a novel design of MZI, the basic building block of these networks, that is both significantly less complex and smaller than the conventional MZIs. Our redesigned MZI has a streamlined structure foregoing the curved bends in the conventional MZIs and occupies less than 1/10th of the area. This optimization also prevents bending losses, simplifies fabrication, and thus greatly enhances device scalability. This work is a significant step towards the realization of larger and denser MZI networks enabling applications in both classical and quantum information processing tasks.

Best regards,
Rituraj
(Thesis supervisor)""",
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
