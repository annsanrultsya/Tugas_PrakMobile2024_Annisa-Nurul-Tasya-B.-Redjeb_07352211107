import 'package:flutter/material.dart';
import 'book_model.dart';
import 'book_service.dart';

class AddBookPage extends StatefulWidget {
  final Book? book;
  final bool isEditing;

  const AddBookPage({Key? key, this.book, this.isEditing = false})
      : super(key: key);

  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book?.title ?? '');
    _authorController = TextEditingController(text: widget.book?.author ?? '');
    _descriptionController =
        TextEditingController(text: widget.book?.description ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveBook() async {
    if (_formKey.currentState!.validate()) {
      Book newBook = Book(
        title: _titleController.text,
        author: _authorController.text,
        description: _descriptionController.text,
      );

      if (widget.isEditing) {
        Book? updatedBook =
            await BookService.updateBook(widget.book!.id!, newBook);
        if (updatedBook != null) {
          Navigator.of(context).pop(updatedBook);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal memperbarui buku')),
          );
        }
      } else {
        Book? addedBook = await BookService.addBook(newBook);
        if (addedBook != null) {
          Navigator.of(context).pop(true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal menambahkan buku')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Buku' : 'Tambah Buku'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Judul Buku'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul buku harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _authorController,
                decoration: InputDecoration(labelText: 'Penulis'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Penulis harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Deskripsi'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveBook,
                child: Text(widget.isEditing ? 'Perbarui Buku' : 'Tambah Buku'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
