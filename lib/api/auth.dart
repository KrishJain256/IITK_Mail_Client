/// Imports
import 'dart:io';
import 'package:enough_mail/enough_mail.dart';

/// Authorization at login
/// Returns 1 if credentials are correct
/// Returns 0 otherwise
Future<int> auth(String username,String password) async{
  final client = ImapClient(isLogEnabled: false);
  try {
    await client.connectToServer("qasid.iitk.ac.in",993,
        isSecure:true);
    await client.login(username, password);
    await client.logout();
    return 1;
  } on ImapException catch (e) {
    print('IMAP failed with $e');
    return 0;
  }
}