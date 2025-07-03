import 'package:equatable/equatable.dart';

import 'contributor_entity.dart';

/// Represents a book entity with its metadata and contributors.
class Book extends Equatable{
  /// Unique identifier for the book.
  final int id;

  /// Title of the book.
  final String title;

  /// List of authors who contributed to the book.
  final List<Contributor> authors;

  /// List of summaries or descriptions of the book.
  final List<String> summaries;

  /// List of translators who worked on the book.
  final List<Contributor> translators;

  /// List of languages in which the book is available.
  final List<String> languages;

  /// Indicates if the book is under copyright.
  final bool copyright;

  /// URL to the cover image of the book.
  final String? coverUrl;

  /// Number of times the book has been downloaded.
  final int downloadCount;

  /// Creates a [Book] instance with the given properties.
  const Book({
    required this.coverUrl,
    required this.id,
    required this.title,
    required this.authors,
    required this.summaries,
    required this.translators,
    required this.languages,
    required this.copyright,
    required this.downloadCount,
  });

  @override
  List<Object?> get props =>[
    coverUrl,
    id,
    title,
    authors,
    summaries,
    translators,
    languages,
    copyright,
    downloadCount,
  ];

}