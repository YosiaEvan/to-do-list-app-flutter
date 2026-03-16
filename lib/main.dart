import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List App',
      debugShowCheckedModeBanner: false,
      home: TodoPage(),
    );
  }
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  DateTime now = DateTime.now();

  String getToday() {
    String monthDay = "";

    switch (now.month) {
      case 1:
        monthDay = "Januari";
      case 2:
        monthDay = "Februari";
      case 3:
        monthDay = "Maret";
      case 4:
        monthDay = "April";
      case 5:
        monthDay = "Mei";
      case 6:
        monthDay = "Juni";
      case 7:
        monthDay = "Juli";
      case 8:
        monthDay = "Agustus";
      case 9:
        monthDay = "September";
      case 10:
        monthDay = "Oktober";
      case 11:
        monthDay = "November";
      case 12:
        monthDay = "Desember";
      default:
        monthDay = "";
    }

    switch (now.weekday) {
      case 1:
        return "Senin, ${now.day} ${monthDay} ${now.year}";
      case 2:
        return "Selasa, ${now.day} ${monthDay} ${now.year}";
      case 3:
        return "Rabu, ${now.day} ${monthDay} ${now.year}";
      case 4:
        return "Kamis, ${now.day} ${monthDay} ${now.year}";
      case 5:
        return "Jumat, ${now.day} ${monthDay} ${now.year}";
      case 6:
        return "Sabtu, ${now.day} ${monthDay} ${now.year}";
      case 7:
        return "Minggu, ${now.day} ${monthDay} ${now.year}";
      default:
        return "";
    }
  }

  String getTimeOfDay() {
    int hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return "Pagi";
    } else if (hour >= 12 && hour < 18) {
      return "Siang";
    } else {
      return "Malam";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getToday(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff6a7282),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    "Selamat ${getTimeOfDay()} 👋",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 16, right: 16),
        child: FloatingActionButton(
          onPressed: () {
            print("Tambah task");
          },
          child: Icon(Icons.add),
        ),
      )
    );
  }
}

