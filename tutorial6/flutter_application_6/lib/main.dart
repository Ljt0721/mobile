import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var firebaseReady = false;
  String? firebaseError;

  try {
    await Firebase.initializeApp();
    firebaseReady = true;
  } on Object catch (error) {
    firebaseError = error.toString();
  }

  runApp(MainApp(firebaseReady: firebaseReady, firebaseError: firebaseError));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.firebaseReady, this.firebaseError});

  final bool firebaseReady;
  final String? firebaseError;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firestore Notes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(
        firebaseReady: firebaseReady,
        firebaseError: firebaseError,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.firebaseReady, this.firebaseError});

  final bool firebaseReady;
  final String? firebaseError;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  CollectionReference<Map<String, dynamic>> get _notesCollection =>
      FirebaseFirestore.instance.collection('notes');

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _addNote() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (!widget.firebaseReady) {
      _showMessage('Firebase is not configured yet.');
      return;
    }

    if (title.isEmpty || content.isEmpty) {
      _showMessage('Please enter both title and content.');
      return;
    }

    await _notesCollection.add({
      'title': title,
      'content': content,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    _titleController.clear();
    _contentController.clear();
    _showMessage('Note added.');
  }

  Future<void> _deleteNote(String documentId) async {
    await _notesCollection.doc(documentId).delete();
    _showMessage('Note deleted.');
  }

  Future<void> _showEditDialog(
    String documentId,
    String currentTitle,
    String currentContent,
  ) async {
    final editTitleController = TextEditingController(text: currentTitle);
    final editContentController = TextEditingController(text: currentContent);

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: editTitleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: editContentController,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                final nextTitle = editTitleController.text.trim();
                final nextContent = editContentController.text.trim();

                if (nextTitle.isEmpty || nextContent.isEmpty) {
                  _showMessage('Please enter both title and content.');
                  return;
                }

                await _notesCollection.doc(documentId).update({
                  'title': nextTitle,
                  'content': nextContent,
                  'updatedAt': FieldValue.serverTimestamp(),
                });

                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop();
                }
                _showMessage('Note updated.');
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    editTitleController.dispose();
    editContentController.dispose();
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text('Firestore Notes App'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (!widget.firebaseReady) _FirebaseSetupCard(widget.firebaseError),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: widget.firebaseReady ? _addNote : null,
                icon: const Icon(Icons.add),
                label: const Text('Add Note'),
              ),
            ),
            const Divider(height: 32),
            Text('Notes', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            if (widget.firebaseReady)
              _buildNotesList()
            else
              const Text(
                'Add your Firebase Android config to load cloud notes.',
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesList() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _notesCollection
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data?.docs ?? [];
        if (docs.isEmpty) {
          return const Text('No notes yet.');
        }

        return Column(
          children: docs.map((document) {
            final data = document.data();
            final title = (data['title'] as String?) ?? 'Untitled';
            final content = (data['content'] as String?) ?? '';

            return Card(
              child: ListTile(
                title: Text(title),
                subtitle: Text(content),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      tooltip: 'Edit',
                      icon: const Icon(Icons.edit),
                      onPressed: () =>
                          _showEditDialog(document.id, title, content),
                    ),
                    IconButton(
                      tooltip: 'Delete',
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteNote(document.id),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _FirebaseSetupCard extends StatelessWidget {
  const _FirebaseSetupCard(this.error);

  final String? error;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber.shade50,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Firebase setup needed',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            const Text(
              'Register Android package com.example.flutter_application_6 '
              'in Firebase Console, download google-services.json, then place '
              'it in android/app.',
            ),
            if (error != null) ...[
              const SizedBox(height: 8),
              Text(error!, style: Theme.of(context).textTheme.bodySmall),
            ],
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
