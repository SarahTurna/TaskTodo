import 'package:flutter/material.dart';
import 'package:power_state/power_state.dart';
import 'package:task_management/controllers/c_auth.dart';
import 'package:task_management/features/task_manager/controller/c_recent_task.dart';
import 'package:task_management/features/task_manager/view/create_task_view.dart';
import 'package:task_management/features/task_manager/view/tasks_view.dart';
import 'package:task_management/features/user_profile/controller/c_userprofile.dart';
import 'package:task_management/features/user_profile/view/user_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CAuth authController = PowerVault.find<CAuth>();
  final CRecentTask _cRecentTask = PowerVault.put(CRecentTask());
  final CUserProfile _cUserProfile = PowerVault.put(CUserProfile());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  void _fetchData() {
    _cRecentTask.fetchRecentTask();
    _cUserProfile.fetchUserProfile();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildHomePage() {
    final userProfile = _cUserProfile.userProfile;
    final profileLoading = _cUserProfile.loading;
    final firstName = userProfile?.data?.firstName ?? '';
    final lastName = userProfile?.data?.lastName ?? '';
    final email = userProfile?.data?.email ?? '';

    final recentTask = _cRecentTask.recentTask;
    final taskLoading = _cRecentTask.loading;

    final title = recentTask?.data?.title ?? 'No Task Available';
    final description = recentTask?.data?.description ?? '';
    final creatorEmail = recentTask?.data?.creatorEmail ?? '';
    final createdAt = recentTask?.data?.createdAt.toString() ?? '';

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
            const SizedBox(height: 20),

            // Profile Section
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blue.shade100,
                  child: const Icon(Icons.person,
                      color: Color.fromARGB(255, 39, 89, 176), size: 30),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profileLoading ? 'Loading...' : 'Hi $firstName $lastName',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      profileLoading ? '' : email,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // My Tasks Header
            const Text(
              'My Tasks',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Task Information
            if (taskLoading)
              const Center(child: CircularProgressIndicator())
            else
              Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: const Icon(Icons.task,
                        color: Color.fromARGB(255, 39, 114, 176)),
                    title: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(description),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Creator: $creatorEmail',
                            style: const TextStyle(fontSize: 12)),
                        const SizedBox(height: 4),
                        Text(
                            'Created: ${DateTime.tryParse(createdAt)?.toLocal()?.toString() ?? 'N/A'}',
                            style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // Additional Content (Task List)
            if (recentTask?.data == null)
              const Center(child: Text("No tasks available"))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: 1, // Ensure we show only 1 task if available
                  itemBuilder: (context, index) {
                    return _buildTaskListItem(
                      recentTask!.data!.title,
                      'Created: ${recentTask.data!.createdAt.toLocal()}',
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskListItem(String title, String createdAt) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading:
            const Icon(Icons.task, color: Color.fromARGB(255, 39, 114, 176)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(createdAt),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      _buildHomePage(),
      const AllTaskPage(),
      const NewTaskPage(),
      const UserPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
}
