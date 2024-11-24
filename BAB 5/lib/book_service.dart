import 'dart:convert';
import 'package:http/http.dart' as http;
import 'book_model.dart';

class BookService {
  static const baseUrl = 'https://events.hmti.unkhair.ac.id/api';

  // Fetch list of books
  static Future<List<Book>> fetchBooks() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/books'));
      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        return body.map((item) => Book.fromJson(item)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching books: $e');
      return [];
    }
  }

  // Fetch details of a specific book
  static Future<Book?> fetchBookById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/books/$id'));
      if (response.statusCode == 200) {
        return Book.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching book details: $e');
      return null;
    }
  }

  // Add a new book
  static Future<Book?> addBook(Book book) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/books'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(book.toJson()),
      );
      if (response.statusCode == 201) {
        return Book.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to add book');
      }
    } catch (e) {
      print('Error adding book: $e');
      return null;
    }
  }

  // Update an existing book
  static Future<Book?> updateBook(int id, Book book) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/books/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(book.toJson()),
      );
      if (response.statusCode == 200) {
        return Book.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update book');
      }
    } catch (e) {
      print('Error updating book: $e');
      return null;
    }
  }

  // Delete a book
  static Future<bool> deleteBook(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/books/$id'));
      return response.statusCode == 200;
    } catch (e) {
      print('Error deleting book: $e');
      return false;
    }
  }
}
