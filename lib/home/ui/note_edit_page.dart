import 'package:flutter/material.dart';
import 'package:note_application/api_call/api_call.dart';

class NoteEditPage extends StatefulWidget {
  final int id;
  final String title;
  final String content;
  final String priority;

  NoteEditPage({
    required this.id,
    required this.title,
    required this.content,
    required this.priority,
  });

  @override
  _NoteEditPageState createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late String selectedPriority;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    descriptionController = TextEditingController(text: widget.content);
    selectedPriority = widget.priority;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 130, 2, 234),
        title: const Center(
          child: Text(
            'Edit Details',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.purple,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedPriority,
                  isExpanded: true,
                  iconEnabledColor: Colors.purple,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedPriority = newValue!;
                    });
                  },
                  items: <String>['Low', 'Medium', 'High']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  dropdownColor: Colors.white,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  focusColor: Colors.green,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: TextField(
                controller: titleController,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: TextField(
                controller: descriptionController,
                style: const TextStyle(),
                decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (titleController.text.isNotEmpty &&
                            descriptionController.text.isNotEmpty) {
                          await editNote(
                            id: widget.id,
                            title: titleController.text,
                            content: descriptionController.text,
                            priority: selectedPriority,
                          );
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                      ),
                      child: const Text('Save'),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        await deleteNote(widget.id);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                      ),
                      child: const Text('Delete'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
