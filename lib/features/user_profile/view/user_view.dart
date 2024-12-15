import 'package:flutter/material.dart';
import 'package:power_state/power_state.dart';
import 'package:task_management/features/user_profile/controller/c_updateprofile.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  late CUpdateProfile _controller;

  int _selectedIndex = 3; // Index for Profile Page

  @override
  void initState() {
    super.initState();
    _controller = PowerVault.put(CUpdateProfile());
    _controller.patchProfile();
  }

  Future<void> _loadProfile() async {
    await _controller.patchProfile(); // Fetch profile data using CUpdateProfile
    if (_controller.viewProfile != null) {
      final profile = _controller.viewProfile!.data;
      setState(() {
        _firstNameController.text = profile?.firstName ?? '';
        _lastNameController.text = profile?.lastName ?? '';
        _emailController.text = profile?.email ?? '';
        _addressController.text = profile?.address ?? '';
      });
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to respective pages based on index
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/tasks');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/add_task');
        break;
      case 3:
        // Current page, no action required
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        backgroundColor: const Color.fromARGB(255, 39, 117, 176),
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: PowerBuilder<CUpdateProfile>(
        builder: (controller) {
          if (controller.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          final profile = controller.viewProfile?.data;
          if (profile == null) {
            return const Center(child: Text('Failed to load profile'));
          }

          return SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Display Profile Image
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(profile.image),
                  backgroundColor: Colors.blue.withOpacity(0.2),
                ),
                const SizedBox(height: 16.0),

                // First Name Field
                _buildTextField(
                  controller: _firstNameController,
                  label: 'First Name',
                  hint: 'Enter first name...',
                ),

                // Last Name Field
                _buildTextField(
                  controller: _lastNameController,
                  label: 'Last Name',
                  hint: 'Enter last name...',
                ),

                // Email Field (Read-only)
                _buildTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'Enter email...',
                  readOnly: true,
                ),

                // Address Field
                _buildTextField(
                  controller: _addressController,
                  label: 'Address',
                  hint: 'Enter address...',
                ),

                const SizedBox(height: 32.0),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final updatedProfile = {
                        'firstName': _firstNameController.text,
                        'lastName': _lastNameController.text,
                        'address': _addressController.text,
                      };

                      try {
                        await _controller.patchProfile(); // Correct method call
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Profile updated successfully!')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Failed to update profile')),
                        );
                      }
                    },
                    child: const Text('Save'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 76, 101, 175),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
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

  // Helper Method to Build Text Fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            readOnly: readOnly,
          ),
        ],
      ),
    );
  }
}
