import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  addtasktodatabase() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    final uid = user!.uid;
    final time = DateTime.now();

    await FirebaseFirestore.instance
        .collection('todos')
        .doc(uid)
        .collection('userTasks')
        .add({
          'title': titleController.text.trim(),
          'description': descriptionController.text.trim(),
          'createdAt': Timestamp.now(),
        });

    Fluttertoast.showToast(msg: 'Todo Added Successfully');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Todo'), centerTitle: true),
      body: Container(
        padding: EdgeInsets.all(16),

        child: Column(
          children: [
            Text('Add the task you want to do', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                addtasktodatabase();
                Navigator.pop(context);
                // Add your save logic here
              },
              child: Text('Save Todo'),
            ),
          ],
        ),
      ),
    );
  }
}
