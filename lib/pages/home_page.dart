import 'package:flutter/material.dart';
import '../pages/login_page.dart';
import '../pages/welcome_page.dart';
import '../pages/clock_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  static const List<Widget> _pages = [
    WelcomePage(),
    ClockPage(),
    Text('排行页面'),
    Text('通告页面'),
    LoginPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('乐程团队中心站')),
      body: Center(child: _pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '主页'),
          BottomNavigationBarItem(icon: Icon(Icons.check_circle), label: '签到'),
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label: '排行'),
          BottomNavigationBarItem(icon: Icon(Icons.announcement), label: '通告'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '个人信息'),
        ],
      ),
    );
  }
}
