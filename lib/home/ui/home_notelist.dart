import 'package:flutter/material.dart';
import 'package:note_application/api_call/api_call.dart';
import 'package:note_application/home/ui/note_edit_page.dart';
import 'note_add_page.dart';

class HomeNotelist extends StatelessWidget {
  const HomeNotelist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 130, 2, 234),
        title: const Center(
          child: Text(
            'Notes',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: notelist.length,
          itemBuilder: (context, index) {
            Map note = notelist[index];
            return Card(
              child: ListTile(
                onTap: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteEditPage(
                        id: note["id"],
                        title: note["title"],
                        content: note["content"],
                        priority: note["priority"],
                      ),
                    ),
                  );
                },
                leading: const CircleAvatar(child: Icon(Icons.abc)),
                title: Text(note["title"]),
                subtitle: const Text('Subtitle'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await deleteNote(note["id"]);
                    print("delted");
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return NoteAddPage();
              },
            ),
          );
        },
        backgroundColor: Colors.purple,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
