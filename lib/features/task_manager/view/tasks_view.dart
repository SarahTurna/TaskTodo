import 'package:flutter/material.dart';
import 'package:power_state/power_state.dart';
import 'package:task_management/features/task_manager/controller/c_tasks.dart';

class AllTaskPage extends StatefulWidget {
  const AllTaskPage({Key? key}) : super(key: key);

  @override
  State<AllTaskPage> createState() => _AllTaskPageState();
}

class _AllTaskPageState extends State<AllTaskPage> {
  late final CAllTask _taskController;

  @override
  void initState() {
    super.initState();
    _taskController = PowerVault.put(CAllTask());
    _taskController.fetchAllTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Tasks'),
        backgroundColor: Colors.blue,
      ),
      body: PowerBuilder<CAllTask>(
        builder: (context) {
          if (_taskController.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Updated to match the model structure
          final tasks = _taskController.allTask?.data.myTasks;
          if (tasks == null || tasks.isEmpty) {
            return const Center(
              child: Text(
                'No tasks available.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  trailing: Icon(
                    task.v == 1
                        ? Icons.check_circle
                        : Icons.pending, // Adjust logic if needed
                    color: task.v == 1 ? Colors.green : Colors.red,
                  ),
                  onTap: () {
                    // Handle task tap
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
