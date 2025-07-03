// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:owl_books/core/network/dio_network_service.dart' as _i789;
import 'package:owl_books/core/network/network_service.dart' as _i503;
import 'package:owl_books/data/repos_impl/books_page_repo_impl.dart' as _i57;
import 'package:owl_books/domain/repos/books_page_repo.dart' as _i179;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i503.NetworkService>(() => _i789.DioNetworkService());
    gh.lazySingleton<_i179.BooksPageRepository>(
      () => _i57.BooksPageRepoImpl(gh<_i503.NetworkService>()),
    );
    return this;
  }
}
