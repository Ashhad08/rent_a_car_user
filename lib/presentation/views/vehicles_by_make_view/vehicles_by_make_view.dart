import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/vehicle/vehicles_by_make_bloc/vehicles_by_make_bloc.dart';
import '../../../constants/extensions.dart';
import '../../../domain/implementations/vehicle/vehicle_repository.dart';
import '../../../generated/assets.dart';
import '../../elements/vehicle_card.dart';

class VehiclesByMakeView extends StatelessWidget {
  const VehiclesByMakeView({super.key, required this.makeName});

  final String makeName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VehiclesByMakeBloc(getIt<VehicleRepository>())
        ..add(LoadVehiclesByMakeEvent(makeName: makeName)),
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            Assets.imagesAppLogo,
            fit: BoxFit.cover,
            width: 53,
            height: 53,
          ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              10.height,
              Text(
                makeName,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: context.colorScheme.onPrimary),
              ),
              40.height,
              Expanded(
                  child: BlocBuilder<VehiclesByMakeBloc, VehiclesByMakeState>(
                builder: (context, state) {
                  if (state is VehiclesByMakeError) {
                    return Center(
                      child: Text(
                        state.error,
                        style: TextStyle(color: context.colorScheme.onPrimary),
                      ),
                    );
                  } else if (state is VehiclesByMakeLoaded) {
                    return RefreshIndicator.adaptive(
                      onRefresh: () async => context
                          .read<VehiclesByMakeBloc>()
                          .add(LoadVehiclesByMakeEvent(makeName: makeName)),
                      child: ListView.separated(
                        separatorBuilder: (context, index) => 12.height,
                        padding: EdgeInsets.all(10),
                        itemCount: state.vehicles.length,
                        itemBuilder: (context, index) => VehicleCard(
                          vehicle: state.vehicles[index],
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
