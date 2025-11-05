// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/posts/data/repositories_impl/post_repositories_impl.dart'
    as _i590;
import '../../features/posts/domain/posts_repositories.dart' as _i1029;
import '../../features/posts/presentation/bloc/posts_bloc.dart' as _i19;
import 'injection_module.dart' as _i212;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectionModule = _$InjectionModule();
    gh.lazySingleton<_i361.Dio>(() => injectionModule.dio);
    gh.lazySingleton<_i1029.PostsRepositories>(
      () => _i590.PostRepositoriesImpl(gh<_i361.Dio>()),
    );
    gh.factory<_i19.PostsBloc>(
      () => _i19.PostsBloc(gh<_i1029.PostsRepositories>()),
    );
    return this;
  }
}

class _$InjectionModule extends _i212.InjectionModule {}
