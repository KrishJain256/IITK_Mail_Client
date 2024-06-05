import 'dart:io';
import 'package:enough_mail/enough_mail.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mime/mime.dart';


/// For sending emails using Low Level API Usage
/// Accepts username, password, List of Mail Addresses to be mailed,
/// List of Mail Addresses for bcc, Subject, Body, File Attachment in form of PDF
Future<Object> sendEmail(String username,String password,List<MailAddress> to,List<MailAddress> bcc,String subject, String body,File? file) async {
  // String senderName = dotenv.env["NAME"]!;
  // String email = dotenv.env["EMAIL"]!;
  // String userName = dotenv.env["USERNAME"]!;
  // String password = dotenv.env["PASSWORD"]!;
  // String smtpServerHost = dotenv.env["SENDER"]!;
  // int smtpServerPort = dotenv.env["SENDER_PORT"]! as int;
  bool isSmtpServerSecure = true;
  final client = SmtpClient('enough.de', isLogEnabled: true);
  try {
    await client.connectToServer("mmtp.iitk.ac.in", 465,
        isSecure: isSmtpServerSecure);
    await client.ehlo();
    if (client.serverInfo.supportsAuth(AuthMechanism.plain)) {
      await client.authenticate(username, password, AuthMechanism.plain);
    } else if (client.serverInfo.supportsAuth(AuthMechanism.login)) {
      await client.authenticate(username, password, AuthMechanism.login);
    } else {
      return [-1,""];
    }
    final MimeMessage mimeMessage;
    if(file != null){
      mimeMessage = buildMessageWithAttachment(username, username+"@iitk.ac.in", to, bcc, subject, body, file) as MimeMessage;
    }else{
      mimeMessage = buildMessage(username,username+"@iitk.ac.in",to,bcc,subject,body);
    }
    final sendResponse = await client.sendMessage(mimeMessage);
    if(sendResponse.isOkStatus){
      return [1,""];
    }
    else{
      return [1,""];
    }
  } on SmtpException catch (e) {
    return [-2,e];
  }
}

/// Building Email without attachment
/// Accepts the name of the sender, email of the sender, List of Mail Addresses to be mailed,
/// List of Mail Addresses for bcc, Subject and Body
MimeMessage buildMessage(String name,String email,List<MailAddress> to,List<MailAddress> bcc,String subject,String body) {
  final builder = MessageBuilder.prepareMultipartAlternativeMessage(
    plainText: body,
    htmlText: body,
  )
    ..from = [MailAddress(name, email)]
    ..to = to
  ..subject = subject
  ..bcc = bcc;
  return builder.buildMimeMessage();
}

/// Building Email with attachment
/// Accepts the name of the sender, email of the sender, List of Mail Addresses to be mailed,
/// List of Mail Addresses for bcc, Subject, Body and Attachment file of type PDF
Future<MimeMessage> buildMessageWithAttachment(String name,String email,List<MailAddress> to,List<MailAddress> bcc,String subject,String body,File attachment) async {
  final builder = MessageBuilder()
    ..from = [MailAddress(name, email)]
    ..to = to
    ..subject = subject
    ..bcc = bcc
    ..addMultipartAlternative(
      plainText: body,
      htmlText: body,
    );
  final file = attachment;
  await builder.addFile(file, MediaSubtype.applicationPdf.mediaType);
  return builder.buildMimeMessage();
}
