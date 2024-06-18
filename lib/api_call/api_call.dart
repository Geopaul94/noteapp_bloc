import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:note_application/base_url.dart';

List notelist = [];

getall() async {
  try {
    final response = await http.get(Uri.parse('${baseUrl}getAllNotes'));
    final list = jsonDecode(response.body);
    notelist = list;
  } catch (e) {
    print(e);
  }
}

addNote(
    {required String title,
    required String content,
    required String priority}) async {
  Map<String, dynamic> data = {
    "id": DateTime.now().millisecond,
    "title": title,
    "content": content,
    "date": DateTime.now().toString(),
    "priority": priority,
  };
  final respose = await http.post(
      Uri.parse(
        '${baseUrl}addNode',
      ),
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"});
  print(respose.body);
}

deleteNote(int id) async {
  print(id);
  final response = await http.post(Uri.parse("${baseUrl}deleteNote/$id"),
      headers: {"Content-Type": "application/json"});
  print(response.body);
}

editNote({
  required int id,
  required String title,
  required String content,
  required String priority,
}) async {
  Map<String, dynamic> data = {
    "title": title,
    "content": content,
    "date": DateTime.now().toString(),
    "priority": priority,
  };
  try {
    final response = await http.put(
      Uri.parse('${baseUrl}editNote/$id'),
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      print('Note edited successfully');
    } else {
      print('Failed to edit note: ${response.body}');
    }
  } catch (e) {
    print(e);
  }
}
