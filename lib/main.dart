import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/master_data/vehicle_all_features_bloc/vehicle_all_features_bloc.dart';
import 'blocs/master_data/vehicle_all_makes_bloc/vehicle_all_makes_bloc.dart';
import 'blocs/master_data/vehicle_all_types_bloc/vehicle_all_types_bloc.dart';
import 'blocs/master_data/vehicle_models_bloc/vehicle_models_bloc.dart';
import 'blocs/vehicle/available_vehicles_bloc/available_vehicles_bloc.dart';
import 'configurations/backend_configs.dart';
import 'configurations/error_messages.dart';
import 'constants/app_colors.dart';
import 'constants/extensions.dart';
import 'constants/theme.dart';
import 'domain/implementations/auth/auth_repository.dart';
import 'domain/implementations/master_data/master_data_repository.dart';
import 'domain/implementations/vehicle/vehicle_repository.dart';
import 'domain/services/image_services.dart';
import 'navigation/navigation_helper.dart';
import 'network/network_repository.dart';
import 'presentation/views/onboarding/splash_view/splash_view.dart';
import 'utils/utils.dart';

void main() {
  getIt.registerSingleton(NavigationHelper());
  getIt.registerSingleton(AppColors());
  getIt.registerSingleton(AppThemes(appColors: getIt<AppColors>()));
  getIt.registerSingleton(ErrorMessages());
  getIt.registerSingleton(BackendConfigs());
  getIt.registerSingleton(Utils());
  getIt.registerSingleton(NetworkRepository(
    errorMessages: getIt<ErrorMessages>(),
  ));
  getIt.registerSingleton(
      ImageServices(getIt<NetworkRepository>(), getIt<BackendConfigs>()));
  getIt.registerSingleton(AuthRepository(
    backendConfigs: getIt<BackendConfigs>(),
    imageServices: getIt<ImageServices>(),
    networkRepository: getIt<NetworkRepository>(),
  ));
  getIt.registerSingleton(MasterDataRepository(
    backendConfigs: getIt<BackendConfigs>(),
    networkRepository: getIt<NetworkRepository>(),
  ));
  getIt.registerSingleton(VehicleRepository(
      backendConfigs: getIt<BackendConfigs>(),
      networkRepository: getIt<NetworkRepository>(),
      imageServices: getIt<ImageServices>()));
  runApp(const RentACar());
}

class RentACar extends StatelessWidget {
  const RentACar({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VehicleAllFeaturesBloc>(
          lazy: false,
          create: (context) =>
              VehicleAllFeaturesBloc(getIt<MasterDataRepository>())
                ..add(LoadVehicleAllFeaturesEvent()),
        ),
        BlocProvider<VehicleAllTypesBloc>(
          lazy: false,
          create: (context) =>
              VehicleAllTypesBloc(getIt<MasterDataRepository>())
                ..add(LoadVehicleAllTypesEvent()),
        ),
        BlocProvider<VehicleAllMakesBloc>(
          lazy: false,
          create: (context) =>
              VehicleAllMakesBloc(getIt<MasterDataRepository>())
                ..add(LoadVehicleAllMakesEvent()),
        ),
        BlocProvider<VehicleModelsBloc>(
          lazy: false,
          create: (context) => VehicleModelsBloc(getIt<MasterDataRepository>())
            ..add(LoadVehicleModelsEvent()),
        ),
        BlocProvider<AvailableVehiclesBloc>(
          create: (context) => AvailableVehiclesBloc(getIt<VehicleRepository>())
            ..add(LoadAvailableVehiclesEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Rent A Car User',
        debugShowCheckedModeBanner: false,
        darkTheme: getIt<AppThemes>().darkTheme,
        theme: getIt<AppThemes>().darkTheme,
        themeMode: ThemeMode.dark,
        home: const SplashView(),
      ),
    );
  }
}
