import 'package:flutter/material.dart';
import 'book_model.dart';
import 'book_service.dart';
import 'book_detail_page.dart';
import 'add_book_page.dart';

class BookListPage extends StatefulWidget {
  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    books = await BookService.fetchBooks();
    if (books.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tidak ada buku tersedia')),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Buku'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddBookPage()),
              );
              if (result == true) {
                _fetchBooks();
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          Book book = books[index];
          return ListTile(
            title: Text(book.title),
            subtitle: Text(book.author),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailPage(book: book),
                ),
              );
              if (result == true) {
                _fetchBooks();
              }
            },
          );
        },
      ),
    );
  }
}
