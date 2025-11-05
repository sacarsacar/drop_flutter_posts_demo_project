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
import 'package:posts_demo_project/core/injection/injection_module.dart'
    as _i515;
import 'package:posts_demo_project/features/posts/data/repositories_impl/post_repositories_impl.dart'
    as _i275;
import 'package:posts_demo_project/features/posts/domain/posts_repositories.dart'
    as _i395;
import 'package:posts_demo_project/features/posts/presentation/bloc/posts_bloc.dart'
    as _i1022;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i395.PostsRepositories>(
      () => _i275.PostRepositoriesImpl(gh<_i361.Dio>()),
    );
    gh.factory<_i1022.PostsBloc>(
      () => _i1022.PostsBloc(gh<_i395.PostsRepositories>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i515.RegisterModule {}
