import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_travel/core/platform/network_info.dart';
import 'package:flutter_travel/features/destination/domain/usecases/get_all_destination_usecase.dart';
import 'package:flutter_travel/features/destination/domain/usecases/get_top_destination_usecase.dart';
import 'package:flutter_travel/features/destination/domain/usecases/search_destination_usecase.dart';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'features/destination/data/datasource/destination_local_data_source.dart';
import 'features/destination/data/datasource/destination_remote_data_source.dart';
import 'features/destination/data/repositories/destination_repository_impl.dart';
import 'features/destination/domain/repositories/destination_repository.dart';

import 'features/destination/presentation/bloc/all_destination/all_destination_bloc.dart';

import 'features/destination/presentation/bloc/search_destination/search_destination_bloc.dart';
import 'features/destination/presentation/bloc/top_destination/top_destination_bloc.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  // Bloc
  locator.registerFactory(() => AllDestinationBloc(locator()));
  locator.registerFactory(() => SearchDestinationBloc(locator()));
  locator.registerFactory(() => TopDestinationBloc(locator()));

  // LAZY bakal di triggered iniLocation kalau di klik atau di panggil, non LAZY bakal lansung dipanggil saat app di jalankan

  // Usecase
  locator.registerLazySingleton(() => GetAllDestinationUseCase(locator()));
  locator.registerLazySingleton(() => SearchDestinationUseCase(locator()));
  locator.registerLazySingleton(() => GetTopDestinationUseCase(locator()));

  // Repository
  locator.registerLazySingleton<DestinationRepository>(
    () => DestinationRepositoryImpl(
      networkInfo: locator(),
      localDataSource: locator(),
      remoteDataSource: locator(),
    ),
  );

  // Datasource
  locator.registerLazySingleton<DestinationLocalDataSource>(
    () => DestinationLocalDataSourceImpl(locator()),
  );

  locator.registerLazySingleton<DestinationRemoteDataSource>(
    () => DestinationRemoteDataSourceImpl(locator()),
  );

  // Platform
  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(locator()),
  );

  // External
  final pref = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => pref);
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => Connectivity());
}
