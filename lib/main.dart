import 'package:flutter/material.dart';

void main() {
  runApp(const ChecklistApp());
}

class ChecklistApp extends StatelessWidget {
  const ChecklistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Checklist',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ChecklistScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  // List of checklist items with their completion status
  List<Map<String, dynamic>> checklistItems = [
    {'title': 'Grocery Shopping', 'isCompleted': false},
    {'title': 'Pay Bills', 'isCompleted': false},
    {'title': 'Book Appointment', 'isCompleted': false},
    {'title': 'Call Family', 'isCompleted': false},
    {'title': 'Exercise', 'isCompleted': false},
    {'title': 'Read a Book', 'isCompleted': false},
    {'title': 'Plan Vacation', 'isCompleted': false},
    {'title': 'Learn New Skill', 'isCompleted': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: const BoxDecoration(
                color: Color(0xFFE8E8E8),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: const Text(
                'Checklist',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // Checklist Items
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: checklistItems.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 8.0,
                      ),
                      leading: Transform.scale(
                        scale: 1.2,
                        child: Checkbox(
                          value: checklistItems[index]['isCompleted'],
                          onChanged: (bool? value) {
                            setState(() {
                              checklistItems[index]['isCompleted'] = value ?? false;
                            });
                          },
                          activeColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                      title: Text(
                        checklistItems[index]['title'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: checklistItems[index]['isCompleted']
                              ? Colors.grey[600]
                              : Colors.black87,
                          decoration: checklistItems[index]['isCompleted']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          checklistItems[index]['isCompleted'] = 
                              !checklistItems[index]['isCompleted'];
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            // Bottom Navigation Bar
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBottomNavItem(Icons.home, 'Home', true),
                  _buildBottomNavItem(Icons.info_outline, 'About', false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 24,
          color: isActive ? Colors.blue : Colors.grey[600],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.blue : Colors.grey[600],
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}