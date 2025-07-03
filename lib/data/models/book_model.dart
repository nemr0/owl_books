import '../../domain/entities/book_entity.dart';
import 'contributor_model.dart';

extension BookModel on Book {
  static Book fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as int,
      title: json['title'] as String,
      authors: (json['authors'] as List<dynamic>)
          .map((e) => ContributorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      summaries: List<String>.from(json['summaries'] as List),
      translators: (json['translators'] as List<dynamic>)
          .map((e) => ContributorModel.fromJson(e as Map<String, dynamic>))
          .toList(),

      languages: List<String>.from(json['languages'] as List),
      copyright: json['copyright'] as bool,
      coverUrl:
          (json['formats'] as Map<String, dynamic>)['image/jpeg'] as String?,
      downloadCount: json['download_count'] as int,
    );
  }
}
