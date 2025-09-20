//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<Map<String, String>> taskList = [];
  String disp = "", desc = "";

  TextEditingController textController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
        centerTitle: false,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: 'Task Title',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  disp = textController.text.trim();
                  desc = descriptionController.text.trim();

                  if (disp.isNotEmpty) {
                    setState(() {
                      taskList.add({
                        "title": disp,
                        "desc": desc, // ✅ optional (can be empty)
                      });
                      textController.clear();
                      descriptionController.clear();
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          title: const Text("Alert"),
                          content:
                              const Text("Title field cannot be empty."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "OK",
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text(
                  "Add",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: 'Description (Optional)',
                    ),
                  ),
                ),
              ),
            ],
          ),

          //  Task List
          Flexible(
            child: ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey[200],
                  shadowColor: const Color.fromARGB(255, 255, 2, 2),
                  surfaceTintColor: const Color.fromARGB(255, 255, 255, 255),               margin:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(
                      taskList[index]["title"] ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      ),
                    subtitle: (taskList[index]["desc"] ?? "").isNotEmpty
                        ? Text(taskList[index]["desc"] ?? "")
                        : null, // show only if desc is not empty
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          taskList.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
