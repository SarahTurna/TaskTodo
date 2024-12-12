import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Track the selected index for BottomNavigationBar

  // Method to handle BottomNavigationBar item tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            const SizedBox(height: 20),
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blue.shade100,
                  child: const Icon(Icons.person,
                      color: Color.fromARGB(255, 39, 89, 176), size: 30),
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, Jasmine',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Welcome back',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // My Tasks Header
            const Text(
              'My tasks',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Tabs
            DefaultTabController(
              length: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TabBar(
                    labelColor: Color.fromARGB(255, 39, 112, 176),
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Color.fromARGB(255, 39, 119, 176),
                    isScrollable: true,
                    tabs: [
                      Tab(text: 'Recently'),
                      Tab(text: 'Today'),
                      Tab(text: 'Upcoming'),
                      Tab(text: 'Later'),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Task Cards
                  Container(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildTaskCard('User interface design', 50,
                            Colors.purple.shade100, Colors.purple),
                        _buildTaskCard('Wireframe elements', 35,
                            Colors.indigo.shade100, Colors.indigo),
                        _buildTaskCard('Landing page', 75, Colors.teal.shade100,
                            Colors.teal),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Task List
            Expanded(
              child: ListView(
                children: [
                  _buildTaskListItem('Lorem Ipsum dolor', '17 August 2020'),
                  _buildTaskListItem('Lorem Ipsum dolor', '26 July 2020'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Use the selected index here
        onTap: _onItemTapped, // Handle BottomNavigationBar item tap
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Task'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: const Color.fromARGB(255, 39, 117, 176),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _buildTaskCard(
      String title, int progress, Color bgColor, Color progressColor) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Text(
            'Progress',
            style: TextStyle(color: Colors.white54),
          ),
          const SizedBox(height: 5),
          LinearProgressIndicator(
            value: progress / 100,
            color: progressColor,
            backgroundColor: Colors.white24,
          ),
          const SizedBox(height: 5),
          Text(
            '$progress%',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskListItem(String title, String date) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.calendar_today,
            color: Color.fromARGB(255, 39, 114, 176)),
        title: Text(title),
        subtitle: Text(date),
        trailing: const Icon(Icons.more_vert),
      ),
    );
  }
}

// void main() => runApp(MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: const HomePage(), // Use HomePage as the home widget
//     ));
