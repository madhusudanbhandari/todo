import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/AddTodo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child: Container()),
            Text('Todo List'),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/authscreen');
              },
              child: Container(child: Icon(Icons.exit_to_app)),
            ),
          ],
        ),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTodo()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
