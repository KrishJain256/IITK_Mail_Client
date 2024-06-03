import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io';
import 'package:enough_mail/enough_mail.dart';
import "package:iitk_mail_client/api/email_sender.dart";

class compose extends StatefulWidget{
  const compose({super.key});

  @override
  State<compose> createState() => _composeMail();
}

class _composeMail extends State<compose> with SingleTickerProviderStateMixin{
  List<MailAddress> to = [];
  String subject = "";
  String own_email = "krishjain23@iitk.ac.in";
  String body = "";


  setToList(List emails) {
    to = List.generate(emails.length, (index) => MailAddress(emails[index].toString().split("@")[0] as String?,emails[index]));
  }

  setSubjectString(String subject) {
    this.subject = subject;
  }

  setBodyText(String body) {
    this.body = body;
  }
   
  
  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(),
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.black54,
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back_sharp,
                        color: Colors.white,
                        semanticLabel: "Back",
                      ),
                      onPressed: (){},
                    ),
                    actions: [
                      IconButton(
                          onPressed: (){},
                          icon: Icon(
                            Icons.attachment,
                            color: Colors.white,
                            semanticLabel: "Attachments",
                          )
                      ),
                      IconButton(
                          onPressed: () {
                            sendEmail(to, [], subject, body, null);
                          },
                          icon: Icon(
                            Icons.send_sharp,
                            color: Colors.white,
                          )
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          )
                      )
                    ],
                  ),
                  AppBar(
                    toolbarHeight: 25,
                    backgroundColor: Colors.black54,
                    leading:
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "  From",
                            style: GoogleFonts.ubuntu(
                              color: Colors.white70,
                              fontSize: 18,
                            ),
                          ),
                        ),

                    title: Text(
                      own_email,
                      style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),


                  AppBar(
                    toolbarHeight: 77,
                    backgroundColor: Colors.black54,
                    leading:
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "  To",
                            style: GoogleFonts.ubuntu(
                              color: Colors.white70,
                              fontSize: 18,
                            ),
                          ),
                        ),

                    title: Align(child: EmailInput(key: Key("TO_LIST_INPUT"), setList: setToList, hint: "example@domain"),alignment: Alignment.topLeft,),
                  ),
                  Divider(color: Colors.white30,),
                  SizedBox(height: 14,),
                  Padding(padding: EdgeInsets.only(left: 8),
                  child: Align(child: SubjectInput(key: Key("SUBJECT_INPUT"), setSubject: setSubjectString, hint: "Subject",),alignment: Alignment.topCenter,),),
                  Divider(color: Colors.white30,thickness: 0.1,),
                  Padding(padding: EdgeInsets.only(left: 8),
                    child: Align(child: BodyInput(key: Key("BODY_INPUT"), setBody: setBodyText, hint: "Body",),alignment: Alignment.topCenter,),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class BodyInput extends StatefulWidget {
  final Function setBody;
  final String hint;
  const BodyInput({required Key key, required this.setBody, required this.hint}) : super(key: key);

  @override
  _BodyInputState createState() => _BodyInputState();
}

class _BodyInputState extends State<BodyInput> {
  late TextEditingController _bodyController;
  FocusNode focus = FocusNode();
  @override
  void initState() {
    super.initState();
    _bodyController = TextEditingController();

    focus.addListener(() {
      if (!focus.hasFocus) {
        updateBody();
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                  constraints: BoxConstraints(
                    minWidth: 0,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: TextField(
                      maxLength: 255,
                      maxLines: null,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration.collapsed(
                          hintText: widget.hint,
                          hintStyle: TextStyle(
                            fontSize: 22,
                            color: Colors.white70,
                          )
                      ),
                      controller: _bodyController,
                      focusNode: focus,
                      onEditingComplete: () {
                        updateBody();
                      },
                    ),
                  )
              )
            ],
          ),
        ));
  }


  updateBody() {
    setState(() {
      widget.setBody(_bodyController.text.toString().trim());
    });
  }

}

class SubjectInput extends StatefulWidget {
  final Function setSubject;
  final String hint;
  const SubjectInput({required Key key, required this.setSubject, required this.hint}) : super(key: key);

  @override
  _SubjectInputState createState() => _SubjectInputState();
}

class _SubjectInputState extends State<SubjectInput> {
  late TextEditingController _subjectController;
  FocusNode focus = FocusNode();
  @override
  void initState() {
    super.initState();
    _subjectController = TextEditingController();

    focus.addListener(() {
      if (!focus.hasFocus) {
        updateSubject();
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                constraints: BoxConstraints(
                  minWidth: 0,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: TextField(
                    maxLength: 255,
                    maxLines: null,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration.collapsed(
                        hintText: widget.hint,
                        hintStyle: TextStyle(
                          fontSize: 22,
                          color: Colors.white70,
                        )
                    ),
                    controller: _subjectController,
                    focusNode: focus,
                    onEditingComplete: () {
                      updateSubject();
                    },
                  ),
                )
              )
            ],
          ),
        ));
  }


  updateSubject() {
    setState(() {
      widget.setSubject(_subjectController.text.toString().trim());
    });
  }

}


class EmailInput extends StatefulWidget {
  final Function setList;
  final String hint;

  const EmailInput({required Key key, required this.setList, required this.hint}) : super(key: key);

  @override
  _EmailInputState createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {
  late TextEditingController _emailController;
  String lastValue = '';
  List<String> emails = [];
  FocusNode focus = FocusNode();
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();

    focus.addListener(() {
      if (!focus.hasFocus) {
        updateEmails();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                constraints: BoxConstraints(
                  minWidth: 0,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      ...emails
                          .map(
                            (email) => Chip(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.white38,
                                ),
                                borderRadius: BorderRadius.circular(25)
                              ),
                          avatar: CircleAvatar(
                            backgroundColor: Colors.white30,
                            child: Text(
                              email.substring(0, 1),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          labelPadding: EdgeInsets.all(4),
                          backgroundColor: Colors.black,
                          label: Text(
                            email,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          deleteIconColor: Colors.white70,
                          onDeleted: () => {
                            setState(() {
                              emails.removeWhere((element) => email == element);
                            })
                          },
                        ),
                      )
                          .toList(),
                    ],
                  ),
                ),
              ),
              TextField(
                style: TextStyle(
                  color: Colors.white,
                ),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration.collapsed(
                    hintText: widget.hint,
                  hintStyle: TextStyle(
                    color: Colors.white30,
                  )
                ),
                controller: _emailController,
                focusNode: focus,
                onChanged: (String val) {
                  setState(() {
                    if (val != lastValue) {
                      lastValue = val;
                      if (val.endsWith(' ') && validateEmail(val.trim())) {
                        if (!emails.contains(val.trim())) {
                          emails.add(val.trim());
                          widget.setList(emails);
                        }
                        _emailController.clear();
                      } else if (val.endsWith(' ') && !validateEmail(val.trim())) {
                        _emailController.clear();
                      }
                    }
                  });
                },
                onEditingComplete: () {
                  updateEmails();
                },
              )
            ],
          ),
        ));
  }

  updateEmails() {
    setState(() {
      if (validateEmail(_emailController.text)) {
        if (!emails.contains(_emailController.text)) {
          emails.add(_emailController.text.trim());
          widget.setList(emails);
        }
        _emailController.clear();
      } else if (!validateEmail(_emailController.text)) {
        _emailController.clear();
      }
    });
  }

  setEmails(List<String> emails) {
    this.emails = emails;
  }
}

bool validateEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return regex.hasMatch(value);
}
