import 'dart:io';
import 'package:enough_mail/enough_mail.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mime/mime.dart';


/// Low level SMTP API example
Future<Object> sendEmail(List<MailAddress> to,List<MailAddress> bcc,String subject, String body,File? file) async {
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
      await client.authenticate("krishjain23", "D1y_8U-leK", AuthMechanism.plain);
    } else if (client.serverInfo.supportsAuth(AuthMechanism.login)) {
      await client.authenticate("krishjain23", "D1y_8U-leK", AuthMechanism.login);
    } else {
      return [-1,""];
    }
    final MimeMessage mimeMessage;
    if(file != null){
      mimeMessage = buildMessageWithAttachment("Krish Jain", "krishjain23@iitk.ac.in", to, bcc, subject, body, file) as MimeMessage;
    }else{
      mimeMessage = buildMessage("Krish Jain","krishjain23@iitk.ac.in",to,bcc,subject,body);
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

/// Builds a simple example message
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

/// Builds an example message with attachment
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
