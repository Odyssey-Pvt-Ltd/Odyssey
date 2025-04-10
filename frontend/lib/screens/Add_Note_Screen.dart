import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final ApiService _api = Get.find<ApiService>();
  bool _isLoading = false;

  void _submitNote() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      Get.snackbar("Error", "Both fields are required");
      return;
    }

    setState(() => _isLoading = true);
    try {
      await _api.createNote(title, content);
      Get.snackbar("Success", "Note created!");
      Navigator.pop(context);
    } catch (e) {
      Get.snackbar("Error", "Failed to create note");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Note")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: "Content"),
              maxLines: 6,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _submitNote,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Save Note"),
            ),
          ],
        ),
      ),
    );
  }
}
