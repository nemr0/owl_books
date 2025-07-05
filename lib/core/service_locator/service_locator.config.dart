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
import 'package:owl_books/domain/usecases/get_books_page_usecase.dart' as _i722;
import 'package:owl_books/domain/usecases/search_books_page_usecase.dart'
    as _i735;
import 'package:owl_books/presentation/managers/get_books_cubit/get_books_cubit.dart'
    as _i454;
import 'package:owl_books/presentation/managers/search_books_cubit/search_books_cubit.dart'
    as _i811;
import 'package:owl_books/presentation/shared_widgets/error_widgets/error_notifications.dart'
    as _i532;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i532.ErrorNotification>(() => _i532.ErrorNotification());
    gh.lazySingleton<_i503.NetworkService>(() => _i789.DioNetworkService());
    gh.lazySingleton<_i179.BooksPageRepository>(
        () => _i57.BooksPageRepoImpl(gh<_i503.NetworkService>()));
    gh.lazySingleton<_i735.SearchBooksPageUseCase>(
        () => _i735.SearchBooksPageUseCase(gh<_i179.BooksPageRepository>()));
    gh.lazySingleton<_i722.GetBooksPageUseCase>(
        () => _i722.GetBooksPageUseCase(gh<_i179.BooksPageRepository>()));
    gh.factory<_i811.SearchBooksCubit>(
        () => _i811.SearchBooksCubit(gh<_i735.SearchBooksPageUseCase>()));
    gh.factory<_i454.GetBooksCubit>(
        () => _i454.GetBooksCubit(gh<_i722.GetBooksPageUseCase>()));
    return this;
  }
}
