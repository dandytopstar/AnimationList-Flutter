// ignore_for_file: library_private_types_in_public_api

import 'package:animation_list/loader/animated_loader.dart';
import 'package:animation_list/model/todo_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Task> tasks = [];
  bool isLoading = false;

  final GlobalKey<AnimatedListState> _animatedListKey = GlobalKey();

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ToDo List')),
        body: Stack(
          children: [
            AnimatedList(
              key: _animatedListKey,
              initialItemCount: tasks.length,
              itemBuilder: (context, index, animation) {
                return _buildTaskItem(tasks[index], animation, index);
              },
            ),
            if (isLoading)
              const Opacity(
                opacity: 0,
                child: ModalBarrier(dismissible: false, color: Colors.black),
              ),
            if (isLoading)
              const Center(
                child: Center(child: AnimatedLoader()),
              ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addTask,
          child: const Icon(Icons.add),
        ),
        backgroundColor: Colors.white60,
      ),
    );
  }

  Widget _buildTaskItem(Task task, Animation<double> animation, int index) {
    return SizeTransition(
        sizeFactor: animation,
        child: Card(
          color: Colors.white,
          child: ListTile(
            title: Text(task.title),
            onLongPress: () => _removeTask(index),
          ),
        ));
  }

  void _addTask() async {
    Task newTask = Task('New Task ${tasks.length + 1}', false);
    await loadData();
    tasks.add(newTask);
    _animatedListKey.currentState!.insertItem(tasks.length - 1);
  }

  void _removeTask(int index) async {
    await loadData();
    _animatedListKey.currentState!.removeItem(index,
        (context, animation) => _buildTaskItem(tasks[index], animation, index));
    tasks.removeAt(index);
  }
}
