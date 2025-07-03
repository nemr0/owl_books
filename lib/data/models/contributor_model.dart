import '../../domain/entities/contributor_entity.dart';

extension ContributorModel on Contributor {
 static Contributor fromJson(Map<String, dynamic> json) {
    return Contributor(
      name: json['name'] as String,
      birthYear: int.tryParse(json['birth_year']?.toString() ??''),
      deathYear: int.tryParse(json['death_year']?.toString() ??''),
    );
  }
}