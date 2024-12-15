import 'package:flutter/material.dart';
import 'package:power_state/power_state.dart';
import 'package:task_management/features/task_manager/api/add_task_api.dart';
import 'package:task_management/features/task_manager/controller/c_add_task.dart';
import 'package:task_management/features/task_manager/view/home_view.dart';
import 'package:task_management/features/task_manager/view/tasks_view.dart';
import 'package:task_management/features/user_profile/view/user_view.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({super.key});

  @override
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  final CAddTask _addTaskController = PowerVault.put(CAddTask());

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (index == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } else if (index == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AllTaskPage()),
        );
      } else if (index == 2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NewTaskPage()),
        );
      } else if (index == 3) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UserPage()),
        );
      }
    });
  }

  void _createTask() async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final date = _dateController.text;
    final time = _timeController.text;

    if (title.isEmpty || description.isEmpty || date.isEmpty || time.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    try {
      final createdAt = DateTime.parse("$date $time");

      // Prepare task data
      final taskData = {
        "title": title,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
      };

      _addTaskController.setLoading(true);
      await _addTaskController.fetchAddTask(taskData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(_addTaskController.addTask?.message ??
                "Task created successfully")),
      );

      // Clear the form
      _titleController.clear();
      _descriptionController.clear();
      _dateController.clear();
      _timeController.clear();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to create task")),
      );
    } finally {
      _addTaskController.setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task ToDo'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 60, 109, 222),
        elevation: 1,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInputLabel('Title Task'),
            _buildTextField(_titleController, 'Add Task Name...'),
            _buildInputLabel('Description'),
            _buildTextField(_descriptionController, 'Add Descriptions...',
                maxLines: 3),
            _buildInputLabel('Date'),
            _buildTextField(_dateController, 'yyyy-mm-dd',
                prefixIcon: const Icon(Icons.calendar_today)),
            _buildInputLabel('Time'),
            _buildTextField(_timeController, 'hh:mm',
                prefixIcon: const Icon(Icons.access_time)),
            SizedBox(height: screenHeight * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _createTask,
                    child: const Text('Create'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      {int maxLines = 1, Widget? prefixIcon}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
