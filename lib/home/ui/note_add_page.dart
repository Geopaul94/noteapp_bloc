import 'package:flutter/material.dart';
import 'package:note_application/api_call/api_call.dart';

class NoteAddPage extends StatefulWidget {
  NoteAddPage({
    super.key,
  });

  @override
  State<NoteAddPage> createState() => _NoteAddPageState();
}

class _NoteAddPageState extends State<NoteAddPage> {
  String _selectedValue = 'Low';
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 130, 2, 234),
        title: const Center(
          child: Text(
            'Note Details',
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
                  value: _selectedValue,
                  isExpanded: true, 
                  iconEnabledColor: Colors.purple, 
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedValue = newValue!;
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
                controller: titlecontroller,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                onChanged: (value) {
                  debugPrint('titletext filed');
                },
                decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: TextField(
                controller: descriptioncontroller,
                style: const TextStyle(),
                onChanged: (value) {
                  debugPrint('titletext filed');
                },
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
                        if (titlecontroller.text.isNotEmpty &&
                            descriptioncontroller.text.isNotEmpty) {
                          await addNote(
                              title: titlecontroller.text,
                              content: descriptioncontroller.text,
                              priority: _selectedValue);
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
