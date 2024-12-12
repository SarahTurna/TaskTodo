import 'package:flutter/material.dart';

class AllTasksPage extends StatefulWidget {
  const AllTasksPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AllTasksPageState createState() => _AllTasksPageState();
}

class _AllTasksPageState extends State<AllTasksPage> {
  final List<Map<String, String>> tasks = [
    {
      "title": "Complete UI Design",
      "date": "17 Aug 2020",
      "description": "Finish the UI layout for the homepage"
    },
    {
      "title": "Fix Login Bugs",
      "date": "19 Aug 2020",
      "description": "Resolve login validation issues"
    },
    {
      "title": "Prepare Presentation",
      "date": "20 Aug 2020",
      "description": "Create slides for the team meeting"
    },
    {
      "title": "Update Wireframes",
      "date": "21 Aug 2020",
      "description": "Revise the wireframes based on feedback"
    },
  ];

  int _selectedIndex = 0; // BottomNavigationBar index

  // Bottom Navigation Bar items
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Add navigation logic if needed for other items
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Navigate back
        ),
        title: const Text('All Tasks'),
        backgroundColor: Color.fromARGB(255, 39, 101, 176),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: ListView.separated(
          itemCount: tasks.length,
          separatorBuilder: (context, index) =>
              Divider(color: Colors.grey[300]),
          itemBuilder: (context, index) {
            final task = tasks[index];
            return ListTile(
              contentPadding: EdgeInsets.symmetric(
                vertical: isMobile ? 8 : 16,
                horizontal: isMobile ? 10 : 20,
              ),
              leading: CircleAvatar(
                radius: isMobile ? 20 : 30,
                backgroundColor: const Color.fromARGB(255, 190, 200, 231),
                child: Icon(Icons.task,
                    color: const Color.fromARGB(255, 39, 101, 176),
                    size: isMobile ? 20 : 30),
              ),
              title: Text(
                task["title"]!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 14 : 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task["description"]!,
                      style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  Text(task["date"]!,
                      style: TextStyle(color: Colors.grey[600])),
                ],
              ),
              trailing: const Icon(Icons.more_vert),
              onTap: () {
                // Add navigation or task details functionality here
              },
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Color.fromARGB(255, 39, 105, 176),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Task'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// void main() => runApp(MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: AllTasksPage(),
//     ));
