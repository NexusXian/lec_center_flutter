class Attendance {
  int id;
  String username;
  String email;
  DateTime createdAt;
  String img;
  String checkInfo;

  Attendance({
    required this.id,
    required this.username,
    required this.email,
    required this.createdAt,
    required this.img,
    required this.checkInfo,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        id: json['ID'],
        username: json['username'],
        email: json['email'],
        createdAt: DateTime.parse(json['created_at']),
        img: json['img'],
        checkInfo: json['check_info'],
      );

  Map<String, dynamic> toJson() => {
        'ID': id,
        'username': username,
        'email': email,
        'created_at': createdAt.toIso8601String(),
        'img': img,
        'check_info': checkInfo,
      };
}

