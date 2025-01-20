import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/master_data/vehicle_all_makes_bloc/vehicle_all_makes_bloc.dart';
import '../../../blocs/master_data/vehicle_all_types_bloc/vehicle_all_types_bloc.dart';
import '../../../blocs/vehicle/available_vehicles_bloc/available_vehicles_bloc.dart';
import '../../../constants/extensions.dart';
import '../../../data/models/auth/login_model.dart';
import '../../../domain/services/session_manager.dart';
import '../../../generated/assets.dart';
import '../../../navigation/navigation_helper.dart';
import '../../elements/app_text_field.dart';
import '../../elements/vehicle_card.dart';
import '../available_vehicles_view/available_vehicles_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.person_2_outlined,
                color: context.colorScheme.onPrimary,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xffB8B8B8),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: FutureBuilder<LoginModel?>(
                  future: SessionManager().getCurrentUser(),
                  builder: (context, snap) {
                    return Text(
                      snap.data?.name ?? "Guest",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: context.colorScheme.onPrimary),
                    );
                  }),
            ),
            18.height,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: AppTextField.dark(
                readOnly: true,
                onTap: () {
                  getIt<NavigationHelper>()
                      .push(context, AvailableVehiclesView());
                },
                controller: TextEditingController(),
                hintText: 'Search Your Dream Car',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            32.height,
            Container(
              width: double.infinity,
              color: Color(0xff1C2427),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: Column(
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: context.colorScheme.primary),
                  ),
                  16.height,
                  BlocBuilder<VehicleAllTypesBloc, VehicleAllTypesState>(
                    builder: (context, state) {
                      if (state is VehicleAllTypesError) {
                        return Center(
                          child: Text(
                            state.error,
                            style:
                                TextStyle(color: context.colorScheme.onPrimary),
                          ),
                        );
                      } else if (state is VehicleAllTypesLoaded) {
                        return GridView.builder(
                          itemCount: state.allTypes.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 1.5),
                          itemBuilder: (context, index) => ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned.fill(
                                    child: Image.asset(
                                  Assets.imagesLoginBg,
                                  fit: BoxFit.cover,
                                )),
                                Positioned.fill(
                                    child: ColoredBox(
                                        color: Color(0xff171717).withOp(0.6))),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    state.allTypes[index].typeName ?? "",
                                    style: TextStyle(
                                        color: context.colorScheme.onPrimary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    },
                  ),
                  23.height,
                  Text(
                    'MAJOR BRANDS',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: context.colorScheme.primary),
                  ),
                  16.height,
                  BlocBuilder<VehicleAllMakesBloc, VehicleAllMakesState>(
                    builder: (context, state) {
                      if (state is VehicleAllMakesError) {
                        return Center(
                          child: Text(
                            state.error,
                            style:
                                TextStyle(color: context.colorScheme.onPrimary),
                          ),
                        );
                      } else if (state is VehicleAllMakesLoaded) {
                        return ListView.separated(
                          itemCount: state.allMakes.length,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) => 8.width,
                          itemBuilder: (context, index) => Container(
                            height: 84,
                            width: 82,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFF2D3538), // #2D3538
                                  Color(0xFF535554), // #535554
                                ],
                                stops: [
                                  0.0009,
                                  0.8783
                                ], // Adjust the gradient stops as per your percentage
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.all(8),
                            alignment: Alignment.center,
                            child: Text(
                              state.allMakes[index].makeName ?? '',
                              style: TextStyle(
                                  color: context.colorScheme.onPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ).space(height: 84);
                      }
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    },
                  ),
                  35.height,
                  Divider(
                    color: Color(0xff485053),
                  ),
                  23.height,
                  Text(
                    'BROWSE CARS',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: context.colorScheme.primary),
                  ),
                  16.height,
                  DefaultTextStyle(
                    style: TextStyle(color: context.colorScheme.primary),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          getIt<NavigationHelper>()
                              .push(context, AvailableVehiclesView());
                        },
                        child: Text(
                          'See all',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: context.colorScheme.primary),
                        ),
                      ),
                    ),
                  ),
                  20.height,
                  BlocBuilder<AvailableVehiclesBloc, AvailableVehiclesState>(
                    builder: (context, state) {
                      if (state is AvailableVehiclesError) {
                        return Center(
                          child: Text(
                            state.error,
                            style:
                                TextStyle(color: context.colorScheme.onPrimary),
                          ),
                        );
                      } else if (state is AvailableVehiclesLoaded) {
                        return ListView.separated(
                          separatorBuilder: (context, index) => 12.height,
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
