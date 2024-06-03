import 'dart:io';
import 'package:enough_mail/enough_mail.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mime/mime.dart';


    /// Low level IMAP API usage example
    Future<void> imapExample() async {
      // String userName = dotenv.env["USERNAME"]!;
      // String password = dotenv.env["PASSWORD"]!;
      // String imapServerHost = dotenv.env["SENDER"]!;
      // int imapServerPort = dotenv.env["SENDER_PORT"]! as int;
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
        for (final message in fetchResult.messages) {
          printMessage(message);
        }
        await client.logout();
      } on ImapException catch (e) {
        print('IMAP failed with $e');
      }
    }


void main() async{
      await imapExample();
}

void printMessage(MimeMessage message) {
  print('from: ${message.from} with subject "${message.decodeSubject()}"');
  if (!message.isTextPlainMessage()) {
    print(' content-type: ${message.mediaType}');
  } else {
    final plainText = message.decodeTextPlainPart();
    if (plainText != null) {
      final lines = plainText.split('\r\n');
      for (final line in lines) {
        if (line.startsWith('>')) {
          // break when quoted text starts
          break;
        }
        print(line);
      }
    }
  }
}