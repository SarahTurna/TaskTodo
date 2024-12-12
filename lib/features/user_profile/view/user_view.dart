import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  _CreateTeamPageState createState() => _CreateTeamPageState();
}

class _CreateTeamPageState extends State<UserPage> {
  final TextEditingController _teamNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Team'),
        backgroundColor: Colors.purple,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Upload Logo Section
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.purple.withOpacity(0.2),
                  child: IconButton(
                    icon: const Icon(Icons.upload,
                        size: 30, color: Colors.purple),
                    onPressed: () {
                      // Add logic to upload a logo
                    },
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Upload logo file',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Your logo will public always',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 32.0),

                // Team Name Input
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Team Name',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _teamNameController,
                  decoration: InputDecoration(
                    hintText: 'Enter team name...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),

                const SizedBox(height: 32.0),

                // Create Team Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add create team logic
                      final teamName = _teamNameController.text;
                      if (teamName.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Update "$teamName" saved!')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Please enter correct information.')),
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
    );
  }
}


// void main() => runApp(MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home:  CreateTeamPage(), // Use HomePage as the home widget
//     ));
