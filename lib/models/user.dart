class User {
  int userId;
  String username;
  String password;
  String phone;
  String email;
  String avatar;
  String grade;
  String role;
  String direction;
  String major;
  int count;
  DateTime createTime;
  DateTime updateTime;

  User({
    required this.userId,
    required this.username,
    required this.password,
    required this.phone,
    required this.email,
    required this.avatar,
    required this.grade,
    required this.major,
    required this.count,
    required this.createTime,
    required this.updateTime,
    required this.role,
    required this.direction,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json['user_id'],
    username: json['username'],
    password: json['password'],
    phone: json['phone'],
    email: json['email'],
    avatar: json['avatar'],
    grade: json['grade'],
    major: json['major'],
    count: json['count'],
    role: json['role'],
    direction: json['direction'],
    createTime: DateTime.parse(json['created_at']),
    updateTime: DateTime.parse(json['updated_at']),
  );

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'username': username,
    'password': password,
    'phone': phone,
    'email': email,
    'avatar': avatar,
    'grade': grade,
    'role': role,
    'direction': direction,
    'major': major,
    'count': count,
    'created_at': createTime.toIso8601String(),
    'updated_at': updateTime.toIso8601String(),
  };
}

