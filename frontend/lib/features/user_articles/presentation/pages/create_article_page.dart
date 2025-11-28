import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class CreateArticlePage extends StatefulWidget {
  const CreateArticlePage({super.key});

  @override
  State<CreateArticlePage> createState() => _CreateArticlePageState();
}

class _CreateArticlePageState extends State<CreateArticlePage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _authorController = TextEditingController(text: "Sergio");
  final _tagsController = TextEditingController();

  File? _imageFile;
  bool _isSubmitting = false;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() => _imageFile = File(file.path));
    }
  }

  Future<String> uploadImage(File file) async {
    String id = const Uuid().v4();
    Reference ref =
        FirebaseStorage.instance.ref().child("media/articles/$id.jpg");
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  Future<void> submitArticle() async {
    if (!_formKey.currentState!.validate()) return;

    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecciona una imagen")),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final imageUrl = await uploadImage(_imageFile!);

      await FirebaseFirestore.instance.collection("articles").add({
        "title": _titleController.text.trim(),
        "content": _contentController.text.trim(),
        "author": _authorController.text.trim(),
        "tags": _tagsController.text.split(",").map((t) => t.trim()).toList(),
        "thumbnailURL": imageUrl,
        "date": Timestamp.now(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Article published")),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error publishing: $e")),
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Article"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // TITLE
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: "Title",
                    ),
                    validator: (v) =>
                        v!.isEmpty ? "Introduce a title" : null,
                  ),
                  const SizedBox(height: 16),

                  // CONTENT
                  TextFormField(
                    controller: _contentController,
                    decoration: const InputDecoration(
                      labelText: "Content",
                    ),
                    maxLines: 10,
                    validator: (v) =>
                        v!.isEmpty ? "Write the content" : null,
                  ),
                  const SizedBox(height: 16),

                  // TAGS
                  TextFormField(
                    controller: _tagsController,
                    decoration: const InputDecoration(
                      labelText: "Tags (separated by commas)",
                    ),
                  ),
                  const SizedBox(height: 16),

                  // IMAGE PICKER 
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isDark
                              ? Colors.grey.shade700
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: _imageFile == null
                          ? Center(
                              child: Text(
                                "Press to select an image",
                                style: TextStyle(
                                  color:
                                      isDark ? Colors.white70 : Colors.black87,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                _imageFile!,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // BUTTON
                  ElevatedButton(
                    onPressed: _isSubmitting ? null : submitArticle,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                    ),
                    child: const Text(
                      "PUBLISH",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),

          if (_isSubmitting)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
        ],
      ),
    );
  }
}
