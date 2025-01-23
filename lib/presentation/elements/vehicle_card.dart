import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/master_data/vehicle_all_makes_bloc/vehicle_all_makes_bloc.dart';
import '../../blocs/master_data/vehicle_models_bloc/vehicle_models_bloc.dart';
import '../../constants/extensions.dart';
import '../../data/models/vehicle/vehicle_model.dart';
import '../../navigation/navigation_helper.dart';
import '../views/vehicle_details_view/vehicle_details_view.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard({
    super.key,
    required this.vehicle,
  });

  final VehicleModel vehicle;

  @override
  Widget build(BuildContext context) {
    final state = context.read<VehicleAllMakesBloc>().state;
    final stateModels = context.read<VehicleModelsBloc>().state;
    String vehicleMake = '';
    String vehicleModel = '';
    if (state is VehicleAllMakesLoaded) {
      vehicleMake = state.allMakes
              .where(
                (element) =>
                    element.makeName?.toLowerCase() ==
                    vehicle.makeName?.toLowerCase(),
              )
              .firstOrNull
              ?.makeName ??
          "";
    }
    if (stateModels is VehicleModelsLoaded) {
      vehicleModel = stateModels.models
              .where(
                (element) => element.id == vehicle.carModelId,
              )
              .firstOrNull
              ?.modelName ??
          "";
    }
    return GestureDetector(
      onTap: () {
        getIt<NavigationHelper>().push(
            context,
            VehicleDetailsView(
              vehicle: vehicle,
            ));
      },
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 16,
            child: Container(
                height: 134,
                decoration: BoxDecoration(
                  color: Color(0xff383F47),
                  image: vehicle.images?.firstOrNull != null
                      ? DecorationImage(
                          image: NetworkImage(vehicle.images!.first),
                          fit: BoxFit.cover)
                      : null,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.topCenter,
                child: Container(
                  color: Colors.black12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.heart,
                            color: context.colorScheme.primary,
                          )),
                      Text(
                        "$vehicleMake $vehicleModel",
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: context.colorScheme.onPrimary,
                        ),
                      ),
                      30.width,
                    ],
                  ),
                )),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Color(0xff111214),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.local_offer_outlined,
                    color: context.colorScheme.onPrimary,
                    size: 18,
                  ),
                  4.width,
                  Text(
                    'Price per day : ${vehicle.rateWithoutDriver} Rs',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: context.colorScheme.onPrimary,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF2D3538), // #2D3538
                      Color(0xFF535554), // #535554
                    ],
                    stops: [0.0009, 0.8783], // Corresponds to 0.09% and 87.83%
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
              ))
        ],
      ).space(height: 134, width: double.infinity),
    );
  }
}
