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
  TextEditingController taskController = TextEditingController();
  List<Map<String, dynamic>> todolist = [];
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

  String priority = "Normal";

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredList = todolist.where((task) => task["isCompleted"] == false).toList();
    List<Map<String, dynamic>> completedList = todolist.where((task) => task["isCompleted"] == true).toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  ),
                  SizedBox(height: 5,),
                  Text(
                    "${todolist.length} tugas tersisa",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff6a7282),
                    ),
                  )
                ],
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                int reversedIndex = filteredList.length - index - 1;

                return ListTile(
                  tileColor: Color(0xffe5e7eb),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  leading: GestureDetector(
                    onTap: () {
                      setState(() {
                        filteredList[reversedIndex]["isCompleted"] = !filteredList[reversedIndex]["isCompleted"];
                      });
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: filteredList[reversedIndex]["isCompleted"]
                              ? Color(0xff2b7fff)
                              : Color(0xff6a7282),
                          width: 2,
                        ),
                        color: filteredList[reversedIndex]["isCompleted"]
                            ? Color(0xff2b7fff)
                            : Colors.transparent,
                      ),
                      child: filteredList[reversedIndex]["isCompleted"]
                          ? Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.white,
                      ) : null,
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(filteredList[reversedIndex]["task"]),
                      Row(
                        children: [
                          filteredList[reversedIndex]["priority"] == "Penting" ?
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Color(0xfffecaca),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              filteredList[reversedIndex]["priority"] == "Penting" ? "Penting" : "",
                              style: TextStyle(
                                color: Color(0xffef4444),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ) : Container(
                            child: Text(""),
                          ),
                          SizedBox(width: 16,),
                          Icon(
                            Icons.delete,
                            color: Color(0xffef4444),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 16,),
            ),
            completedList.isNotEmpty ? Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Selesai",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff6a7282),
                ),
              ),
            ) : Text(""),
            completedList.isNotEmpty ? ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: completedList.length,
              itemBuilder: (context, index) {
                int reversedIndex = completedList.length - index - 1;

                return ListTile(
                  tileColor: Color(0xffe5e7eb),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  leading: GestureDetector(
                    onTap: () {
                      setState(() {
                        completedList[reversedIndex]["isCompleted"] = !completedList[reversedIndex]["isCompleted"];
                      });
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: completedList[reversedIndex]["isCompleted"]
                              ? Color(0xff2b7fff)
                              : Color(0xff6a7282),
                          width: 2,
                        ),
                        color: completedList[reversedIndex]["isCompleted"]
                          ? Color(0xff2b7fff)
                          : Colors.transparent,
                      ),
                      child: completedList[reversedIndex]["isCompleted"]
                        ? Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                        ) : null,
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        completedList[reversedIndex]["task"],
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Icon(
                        Icons.delete,
                        color: Color(0xffef4444),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 16,),
            ) : Text(""),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 16, right: 16),
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return StatefulBuilder(
                  builder: (context, setModalState) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 20,
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tugas Baru",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20,),
                          TextField(
                            controller: taskController,
                            autofocus: true,
                            decoration: InputDecoration(
                                hintText: "Apa yang ingin kamu kerjakan?",
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: Color(0xff6a7282),
                                      width: 2,
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: Color(0xff2b7fff),
                                      width: 2,
                                    )
                                )
                            ),
                          ),
                          SizedBox(height: 8,),
                          Row(
                            children: [
                              ChoiceChip(
                                label: Text(
                                  "Normal",
                                  style: TextStyle(
                                    color: priority == "Normal" ? Colors.white : null,
                                  ),
                                ),
                                selected: priority == "Normal",
                                onSelected: (selected) {
                                  setModalState(() {
                                    priority = "Normal";
                                  });
                                },
                                selectedColor: Color(0xff2b7fff),
                                showCheckmark: false,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              SizedBox(width: 8,),
                              ChoiceChip(
                                label: Text(
                                  "Penting",
                                  style: TextStyle(
                                    color: priority == "Penting" ? Colors.white : null,
                                  ),
                                ),
                                selected: priority == "Penting",
                                onSelected: (selected) {
                                  setModalState(() {
                                    priority = "Penting";
                                  });
                                },
                                selectedColor: Color(0xff2b7fff),
                                showCheckmark: false,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  todolist.add({
                                    "task": taskController.text,
                                    "priority": priority,
                                    "isCompleted": false,
                                  });
                                });

                                taskController.clear();
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff2b7fff),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: Text(
                                "Tambah Tugas",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              )
                            ),
                          ),
                          SizedBox(height: 20,),
                        ],
                      ),
                    );
                  }
                );
              }
            );
          },
          backgroundColor: Color(0xff2b7fff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      )
    );
  }
}

