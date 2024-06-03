class Email {
  final String? profileImage;
  final String? userName;
  final String? subject;
  final String? body;
  final DateTime? dateTime;
  final List? receivers;

  Email({this.profileImage = "https://img.freepik.com/free-photo/gray-smooth-textured-paper-background_53876-101833.jpg",this.userName,this.subject,this.body="<no-body>",this.dateTime,this.receivers = const ["<no-receivers>"]});
}