import 'package:enough_mail/enough_mail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iitk_mail_client/api/auth.dart';

import 'home.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<loginpage> createState() => _loginpageState();
}

// class _loginpageState extends State<loginpage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(
//                 labelText: 'Email',
//                 prefixIcon: Icon(Icons.email),
//               ),
//             ),
//             SizedBox(height: 20.0),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 prefixIcon: Icon(Icons.lock),
//               ),
//               obscureText: true,
//             ),
//             SizedBox(height: 20.0),
//             FloatingActionButton.large(
//                 onPressed: () {
//
//                 },
//               child: Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


class _loginpageState extends State<loginpage> {
  String userName = "";
  String password = "";

  setUserName(String username) {
  this.userName = username;
  }

  setPassword(String password) {
    this.password = password;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: DrawClip2(),
                  child: Container(
                    width: size.width,
                    height: size.height * 0.8,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xffa58fd2), Color(0xffddc3fc)],
                          begin: Alignment.bottomCenter,
                          end: Alignment.bottomRight),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: DrawClip(),
                  child: Container(
                    width: size.width,
                    height: size.height * 0.8,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xffddc3fc), Color(0xff91c5fc)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Column(
                    children: [
                      Text(
                        "Login",
                        style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      UsernameInput(key: Key("USERNAME_INPUT"), setUsername: setUserName, hint: "Username",),
                      PasswordInput(key: Key("PASSWORD_INPUT"), setPassword: setPassword, hint: "Password",),
                      SizedBox(
                        height: 20,
                      ),

                      TextButton(
                        // null for now , since its just UI
                        onPressed: () async {
                          int verify = await auth(userName,password);
                          if (verify == 1){
                            Navigator.push(context,MaterialPageRoute(builder: (context) => homepage(key: Key("HOME_PAGE"), title: "Home Page",userName: userName,password: password)));
                          }
                          else{

                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 40),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xff6a74ce),
                                  borderRadius: BorderRadius.circular(30)),
                              height: 50,
                              child: Center(
                                  child: Text(
                                    "Login",
                                    style: GoogleFonts.ubuntu(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ))),
                        ),
                      ),
                      Text(
                        "Forgot your password?",
                        style: GoogleFonts.ubuntu(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}

class UsernameInput extends StatefulWidget {
  final Function setUsername;
  final String hint;
  const UsernameInput({required Key key, required this.setUsername, required this.hint}) : super(key: key);

  @override
  _UsernameInputState createState() => _UsernameInputState();
}

class _UsernameInputState extends State<UsernameInput> {
  late TextEditingController _usernameController;
  FocusNode focus = FocusNode();
  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();

    focus.addListener(() {
      if (!focus.hasFocus) {
        updateUsername();
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.white),
        child: TextFormField(
          decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: GoogleFonts.ubuntu(color: Colors.grey),
              contentPadding: EdgeInsets.only(top: 15, bottom: 15),
              prefix: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Icon(Icons.person_outline, color: Colors.grey),
              ),
              suffixIcon: Icon(Icons.assignment_turned_in_rounded,
                  color: Colors.greenAccent),
              border: UnderlineInputBorder(borderSide: BorderSide.none)),
          controller: _usernameController,
          focusNode: focus,
          onEditingComplete: () {
            updateUsername();
          },
        ),

      ),
    );
      //
      // Container(
      //   child: Center(
      //     child: Column(
      //       children: <Widget>[
      //         Container(
      //             constraints: BoxConstraints(
      //               minWidth: 0,
      //             ),
      //             child: SingleChildScrollView(
      //               scrollDirection: Axis.vertical,
      //               child: TextField(
      //                 maxLength: 255,
      //                 maxLines: null,
      //                 style: TextStyle(
      //                   fontSize: 18,
      //                   color: Colors.white,
      //                 ),
      //                 keyboardType: TextInputType.text,
      //                 decoration: InputDecoration.collapsed(
      //                     hintText: widget.hint,
      //                     hintStyle: TextStyle(
      //                       fontSize: 22,
      //                       color: Colors.white70,
      //                     )
      //                 ),
      //                 controller: _usernameController,
      //                 focusNode: focus,
      //                 onEditingComplete: () {
      //                   updateUsername();
      //                 },
      //               ),
      //             )
      //         )
      //       ],
      //     ),
      //   ));
  }


  updateUsername() {
    setState(() {
      widget.setUsername(_usernameController.text.toString().trim());
    });
  }

}


class PasswordInput extends StatefulWidget {
  final Function setPassword;
  final String hint;
  const PasswordInput({required Key key, required this.setPassword, required this.hint}) : super(key: key);

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  late TextEditingController _passwordController;
  FocusNode focus = FocusNode();
  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();

    focus.addListener(() {
      if (!focus.hasFocus) {
        updatePassword();
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.white),
        child: TextFormField(
          decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: GoogleFonts.ubuntu(color: Colors.grey),
              contentPadding: EdgeInsets.only(top: 15, bottom: 15),
              prefix: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Icon(Icons.lock_outline, color: Colors.grey),
              ),
              border: UnderlineInputBorder(borderSide: BorderSide.none)),
          controller: _passwordController,
          focusNode: focus,
          onEditingComplete: () {
            updatePassword();
          },
        ),

      ),
    );
  }


  updatePassword() {
    setState(() {
      widget.setPassword(_passwordController.text.toString().trim());
    });
  }

}


Widget input(String hint, bool pass) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.white),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.ubuntu(color: Colors.grey),
            contentPadding: EdgeInsets.only(top: 15, bottom: 15),
            prefix: pass
                ? Icon(Icons.lock_outline, color: Colors.grey)
                : Icon(Icons.person_outline, color: Colors.grey),
            suffixIcon: pass
                ? null
                : Icon(Icons.assignment_turned_in_rounded,
                color: Colors.greenAccent),
            border: UnderlineInputBorder(borderSide: BorderSide.none)),
      ),
    ),
  );
}

class DrawClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.80);
    path.cubicTo(size.width / 4, size.height, 3 * size.width / 4,
        size.height / 2, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class DrawClip2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.08);
    path.cubicTo(size.width / 4, size.height, 3 * size.width / 4,
        size.height / 2, size.width, size.height * 0.9);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}