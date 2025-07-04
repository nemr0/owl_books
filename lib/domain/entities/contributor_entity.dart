import 'package:equatable/equatable.dart';

/// Represents a contributor to a book, such as an author or translator.
class Contributor extends Equatable{
  /// The name of the contributor.
  final String name;

  /// The birth year of the contributor, if known.
  final int? birthYear;

  /// The death year of the contributor, if known.
  final int? deathYear;

  /// Creates a [Contributor] instance with the given properties.
  const Contributor({
    required this.name,
    this.birthYear,
    this.deathYear,
  });

  @override
  List<Object?> get props => [
    name,
    birthYear,
    deathYear,
  ];

}