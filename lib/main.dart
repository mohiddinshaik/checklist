import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';

void main() {
  runApp(const ChecklistApp());
}

class ChecklistApp extends StatelessWidget {
  const ChecklistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CHECK LIST',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
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
    {
      'title': 'Fire Extnguisher',
      'isCompleted': false,
      'images': <String>[],
     'comments': '',
      'icon': Icons.fire_extinguisher,
    },
    {
      'title': 'emergency exits',
      'isCompleted': false,
      'images': <String>[],
     'comments': '',
      'icon': Icons.door_sliding,
    },
    {
      'title': 'Water supply',
      'isCompleted': false,
      'images': <String>[],
     'comments': '',
      'icon': Icons.water_drop,
    },
    {
      'title': 'Restroom facilities',
      'isCompleted': false,
      'images': <String>[],
     'comments': '',
      'icon': Icons.wc,
    },
    {
      'title': 'Merchandise displays',
      'isCompleted': false,
      'images': <String>[],
     'comments': '',
      'icon': Icons.storefront,
    },
    {
      'title': 'Shelves',
      'isCompleted': false,
      'images': <String>[],
     'comments': '',
      'icon': Icons.shelves,
    },
    {
      'title': 'Trash bins',
      'isCompleted': false,
      'images': <String>[],
     'comments': '',
      'icon': Icons.delete,
    },
    {
      'title': 'Air conditioning',
      'isCompleted': false,
      'images': <String>[],
     'comments': '',
      'icon': Icons.ac_unit,
    },
    {
      'title': 'CCTV',
      'isCompleted': false,
      'images': <String>[],
     'comments': '',
      'icon': Icons.videocam,
    },
    {
      'title': 'Music and ambiance',
      'isCompleted': false,
      'images': <String>[],
     'comments': '',
      'icon': Icons.music_note,
    },
  ];
  DateTime selectedDate = DateTime.now();
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(int index) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        checklistItems[index]['images'].add(image.path);
      });
    }
  }

  void _showCommentDialog(int index) {
  TextEditingController controller = TextEditingController(
    text: checklistItems[index]['comments'] ?? '',
  );
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Add Comment'),
        content: TextField(
          controller: controller,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Enter your comment...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Discard
            },
            child: const Text('Discard'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                checklistItems[index]['comments'] = controller.text;
              });
              Navigator.of(context).pop(); // Save
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}

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
                color: Color.fromARGB(255, 46, 4, 171),
              ),
              child: Column(
                children: [
                  const Text(
                    'Check list',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(221, 249, 248, 248),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  // Date picker row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Previous day button
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_left,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedDate = selectedDate.subtract(
                              const Duration(days: 1),
                            );
                          });
                        },
                      ),
                      GestureDetector(
                        onTap: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              selectedDate = pickedDate;
                            });
                          }
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              DateFormat(
                                'EEE, MMM d, yyyy',
                              ).format(selectedDate),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Next day button
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_right,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedDate = selectedDate.add(
                              const Duration(days: 1),
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ],
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 8.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Main row: number, checkbox, icon-title, camera
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left: number and checkbox
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${index + 1}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Transform.scale(
                                    scale: 1.2,
                                    child: Checkbox(
                                      value:
                                          checklistItems[index]['isCompleted'],
                                      onChanged: (bool? value) {
                                        setState(() {
                                          checklistItems[index]['isCompleted'] =
                                              value ?? false;
                                        });
                                      },
                                      activeColor: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          4.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 12),
                              // Right: icon-title group and camera icon
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey.shade300,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          color: Colors.grey.shade50,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              checklistItems[index]['icon'],
                                              color: const Color.fromARGB(
                                                255,
                                                168,
                                                56,
                                                56,
                                              ),
                                              size: 28,
                                            ),
                                            const SizedBox(width: 8),
                                            Flexible(
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  checklistItems[index]['title'],
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        checklistItems[index]['isCompleted']
                                                        ? Colors.grey[600]
                                                        : Colors.black87,
                                                    decoration:
                                                        checklistItems[index]['isCompleted']
                                                        ? TextDecoration
                                                              .lineThrough
                                                        : TextDecoration.none,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                 IgnorePointer(
  ignoring: checklistItems[index]['isCompleted'],
  child: IconButton(
    icon: Icon(
      Icons.camera_alt,
      color: checklistItems[index]['isCompleted'] ? Colors.grey : Colors.blue,
    ),
    onPressed: checklistItems[index]['isCompleted']
        ? null
        : () => _pickImage(index),
  ),
),
const SizedBox(width: 4),
IconButton(
  icon: Icon(
    Icons.chat,
    color: checklistItems[index]['isCompleted'] ? Colors.grey : Colors.deepPurple,
  ),
  onPressed: checklistItems[index]['isCompleted']
      ? null
      : () {
          _showCommentDialog(index);
        },
),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // Images row: spans the full width
                          if ((checklistItems[index]['images'] ?? [])
                              .isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0, left: 0),
                              child: Row(
                                children: [
                                  ...((checklistItems[index]['images'] ?? []) as List).map<
                                    Widget
                                  >(
                                    (imgPath) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 2.0,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          final images =
                                              (checklistItems[index]['images'] ??
                                                      [])
                                                  as List;
                                          int currentImg = images.indexOf(
                                            imgPath,
                                          );
                                          showDialog(
                                            context: context,
                                            builder: (_) => StatefulBuilder(
                                              builder: (context, setStateDialog) => Dialog(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        IconButton(
                                                          icon: const Icon(
                                                            Icons.arrow_back,
                                                            color: Colors.black,
                                                          ),
                                                          onPressed: () {
                                                            Navigator.of(
                                                              context,
                                                            ).pop();
                                                          },
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            checklistItems[index]['title'],
                                                            style:
                                                                const TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        Image.file(
                                                          File(
                                                            images[currentImg],
                                                          ),
                                                          fit: BoxFit.contain,
                                                        ),
                                                        // Left arrow
                                                        if (images.length > 1 &&
                                                            currentImg > 0)
                                                          Positioned(
                                                            left: 8,
                                                            child: Opacity(
                                                              opacity: 0.5,
                                                              child: IconButton(
                                                                icon: const Icon(
                                                                  Icons
                                                                      .arrow_back,
                                                                  size: 40,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                onPressed: () {
                                                                  setStateDialog(
                                                                    () {
                                                                      currentImg--;
                                                                    },
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        // Right arrow
                                                        if (images.length > 1 &&
                                                            currentImg <
                                                                images.length -
                                                                    1)
                                                          Positioned(
                                                            right: 8,
                                                            child: Opacity(
                                                              opacity: 0.5,
                                                              child: IconButton(
                                                                icon: const Icon(
                                                                  Icons
                                                                      .arrow_forward,
                                                                  size: 40,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                onPressed: () {
                                                                  setStateDialog(
                                                                    () {
                                                                      currentImg++;
                                                                    },
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 8),
                                                    TextButton.icon(
                                                      icon: const Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                      label: const Text(
                                                        'Delete',
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          checklistItems[index]['images']
                                                              .remove(
                                                                images[currentImg],
                                                              );
                                                        });
                                                        Navigator.of(
                                                          context,
                                                        ).pop();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                          child: Image.file(
                                            File(imgPath),
                                            width: 32,
                                            height: 32,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          // Comments section
                          if ((checklistItems[index]['comments'] ?? '').isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0, left: 0),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  checklistItems[index]['comments'],
                                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                                ),
                              ),
                            ),
                        ],
                      ),
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
                    color: Color.fromARGB(31, 168, 37, 37),
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBottomNavItem(Icons.home, 'Home', true),
                  _buildBottomNavItem(Icons.settings, 'Settings', false),
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
        Icon(icon, size: 24, color: isActive ? Colors.blue : Colors.grey[600]),
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
