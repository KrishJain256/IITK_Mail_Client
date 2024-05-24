class Email {
  final String? profileImage;
  final String? userName;
  final String? subject;
  final String? body;
  final DateTime? dateTime;
  final List? receivers;

  Email({this.profileImage,this.userName,this.subject,this.body,this.dateTime,this.receivers = const ["<no-receivers>"]});
}