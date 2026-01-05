import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fap/core/utils/auth_session.dart';
import 'package:fap/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:fap/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:fap/features/auth/domain/repositories/auth_repository.dart';
import 'package:fap/features/auth/domain/usecases/login_with_mobile.dart';
import 'package:fap/features/auth/domain/usecases/verify_otp.dart';
import 'package:fap/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fap/features/price_list/data/datasources/price_list_remote_data_source.dart';
import 'package:fap/features/price_list/data/repositories/category_repository_impl.dart';
import 'package:fap/features/price_list/domain/repositories/category_repository.dart';
import 'package:fap/features/price_list/domain/usecases/get_categories.dart';
import 'package:fap/features/price_list/domain/usecases/get_price_list_details.dart';
import 'package:fap/features/price_list/domain/usecases/create_order.dart';
import 'package:fap/features/price_list/presentation/cubit/price_list_cubit.dart';
import 'package:fap/features/price_list/presentation/cubit/price_list_details_cubit.dart';

final sl = GetIt.instance;

/// Initialize all dependencies for the app
Future<void> init() async {
  // ============== External ==============
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());

  // ============== Core ==============
  sl.registerLazySingleton(() => AuthSession(sl()));

  // ============== Features - Auth ==============

  // Cubit
  sl.registerFactory(
    () => AuthCubit(
      loginWithMobile: sl(),
      verifyOtpUseCase: sl(),
      sharedPreferences: sl(),
      authSession: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginWithMobile(sl()));
  sl.registerLazySingleton(() => VerifyOtp(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: sl()),
  );

  // ============== Features - Price List ==============

  // Cubit
  sl.registerFactory(() => PriceListCubit(getCategories: sl()));
  sl.registerFactory(
    () => PriceListDetailsCubit(
      getPriceListDetails: sl(),
      createOrderUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCategories(sl()));
  sl.registerLazySingleton(() => GetPriceListDetails(sl()));
  sl.registerLazySingleton(() => CreateOrder(sl()));

  // Repository
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<PriceListRemoteDataSource>(
    () => PriceListRemoteDataSourceImpl(dio: sl(), sharedPreferences: sl()),
  );
}
