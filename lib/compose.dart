import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io';
import 'package:enough_mail/enough_mail.dart';

class compose extends StatefulWidget {
  const compose({super.key});

  @override
  State<compose> createState() => _composeMail();
}

class _composeMail extends State<compose> with SingleTickerProviderStateMixin{
  List<MailAddress> to = [];
  
  setToList(List emails) {
    to = List.generate(emails.length, (index) => MailAddress(emails[index].toString().split("@")[0] as String?,emails[index]));
  }
   
  
  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          color: Colors.black54,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 7,top: 25),
              child: Column(
                children: [
                  AppBar(
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
                          onPressed: () {},
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
                    leading: Text(
                      "From",
                      style: GoogleFonts.ubuntu(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                    title: Text(
                      dotenv.env["EMAIL"]!,
                      style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  AppBar(
                    leading: Text(
                      "To",
                      style: GoogleFonts.ubuntu(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                    title: EmailInput(key: Key("TO_LIST_INPUT"), setList: setToList, hint: "example@domain"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
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
                  child: Column(
                    children: <Widget>[
                      ...emails
                          .map(
                            (email) => Chip(
                          avatar: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Text(
                              email.substring(0, 1),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          labelPadding: EdgeInsets.all(4),
                          backgroundColor: Color.fromARGB(255, 39, 182, 192),
                          label: Text(
                            email,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
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
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration.collapsed(hintText: widget.hint),
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
