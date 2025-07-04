

import 'package:dartz/dartz.dart';

import '../../core/failures/failure.dart';
import '../entities/books_page_entity.dart';

abstract class BooksPageRepository{
  Future<Either<Failure,BooksPage>> getBooksPage({
    required int? page,
    String? searchQuery,
  });
}