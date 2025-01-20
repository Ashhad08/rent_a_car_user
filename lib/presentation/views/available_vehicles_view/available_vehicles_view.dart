import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/vehicle/available_vehicles_bloc/available_vehicles_bloc.dart';
import '../../../constants/extensions.dart';
import '../../../generated/assets.dart';
import '../../elements/app_text_field.dart';
import '../../elements/vehicle_card.dart';

class AvailableVehiclesView extends StatelessWidget {
  const AvailableVehiclesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'BROWSE ALL CARS',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: context.colorScheme.onPrimary),
            ),
            40.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: AppTextField.dark(
                  prefixIcon: Icon(Icons.search),
                  controller: TextEditingController(),
                  hintText: 'Search Your Dream Car'),
            ),
            20.height,
            Expanded(child:
                BlocBuilder<AvailableVehiclesBloc, AvailableVehiclesState>(
              builder: (context, state) {
                if (state is AvailableVehiclesError) {
                  return Center(
                    child: Text(
                      state.error,
                      style: TextStyle(color: context.colorScheme.onPrimary),
                    ),
                  );
                } else if (state is AvailableVehiclesLoaded) {
                  return ListView.separated(
                    separatorBuilder: (context, index) => 12.height,
                    padding: EdgeInsets.all(10),
                    itemCount: state.vehicles.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => VehicleCard(
                      vehicle: state.vehicles[index],
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
    );
  }
}
