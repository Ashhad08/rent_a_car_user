import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../blocs/master_data/vehicle_all_makes_bloc/vehicle_all_makes_bloc.dart';
import '../../../blocs/master_data/vehicle_all_types_bloc/vehicle_all_types_bloc.dart';
import '../../../blocs/master_data/vehicle_models_bloc/vehicle_models_bloc.dart';
import '../../../constants/extensions.dart';
import '../../../data/models/vehicle/vehicle_model.dart';
import '../../../domain/services/session_manager.dart';
import '../../../generated/assets.dart';
import '../../../navigation/navigation_helper.dart';
import '../auth/login_sign_up_view.dart';
import '../book_vehicle_view/book_vehicle_view.dart';

class VehicleDetailsView extends StatelessWidget {
  const VehicleDetailsView({super.key, required this.vehicle});

  final VehicleModel vehicle;

  @override
  Widget build(BuildContext context) {
    final state = context.read<VehicleAllTypesBloc>().state;
    final stateModels = context.read<VehicleModelsBloc>().state;
    final stateMakes = context.read<VehicleAllMakesBloc>().state;
    String vehicleType = '';
    String vehicleModel = '';
    String vehicleMake = '';
    if (state is VehicleAllTypesLoaded) {
      vehicleType = state.allTypes
              .where(
                (element) => element.id == vehicle.carTypeId,
              )
              .firstOrNull
              ?.typeName ??
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
    if (stateMakes is VehicleAllMakesLoaded) {
      vehicleMake = stateMakes.allMakes
              .where(
                (element) =>
                    element.makeName?.toLowerCase() ==
                    vehicle.makeName?.toLowerCase(),
              )
              .firstOrNull
              ?.makeName ??
          "";
    }

    final List<Map<String, String>> overViewItems = [
      {
        'title': 'Make',
        'value': vehicleMake,
      },
      {
        'title': 'Model',
        'value': vehicleModel,
      },
      {
        'title': 'Year',
        'value': vehicle.yearOfModel ?? "",
      },
      {
        'title': 'Color',
        'value': vehicle.color ?? "",
      },
      {
        'title': 'Rate Without Driver',
        'value': 'Rs. ${vehicle.rateWithoutDriver ?? ""}',
      },
      {
        'title': 'Rate With Driver',
        'value': 'Rs. ${vehicle.rateWithDriver ?? ""}',
      },
      {
        'title': 'Weekly Discount',
        'value': '${vehicle.discountWeek ?? ""}%',
      },
      {
        'title': 'Monthly Discount',
        'value': '${vehicle.discountMonth ?? ""}%',
      },
      {
        'title': 'Registered City',
        'value': vehicle.regCity ?? "",
      },
      {
        'title': 'Vehicle Type',
        'value': vehicleType,
      },
      {
        'title': 'Status',
        'value': (vehicle.status ?? "available").capitalizeFirst,
      },
      {
        'title': 'Transmission',
        'value': vehicle.transmission ?? "",
      },
      {
        'title': 'Fuel Type',
        'value': vehicle.fuelType ?? "",
      },
      {
        'title': 'Engine Capacity',
        'value': vehicle.engineCapacity ?? "",
      },
      {
        'title': 'Chassis No',
        'value': vehicle.chasisNo ?? "",
      },
      {
        'title': 'Engine No',
        'value': vehicle.engineNo ?? "",
      },
    ];
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(),
        body: ColoredBox(
          color: Color(0xff1C2427),
          child: Column(
            children: [
              if (vehicle.images?.firstOrNull != null)
                Image.network(
                  vehicle.images!.first,
                  height: context.screenHeight * 0.3,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              else
                SizedBox(
                  height: context.screenHeight * 0.3,
                  width: double.infinity,
                ),
              TabBar(
                padding: EdgeInsets.all(20),
                tabs: [
                  Tab(
                    text: 'PRICE',
                  ),
                  Tab(
                    text: 'SPECS',
                  ),
                  Tab(
                    text: 'IMAGES',
                  )
                ],
                dividerHeight: 0,
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                labelStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                tabAlignment: TabAlignment.center,
              ),
              18.height,
              Expanded(
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 115,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 26, vertical: 7),
                              transform: Matrix4.skewX(-.3),
                              color: Color(0xff757575),
                              child: Text(
                                'PER DAY',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: context.colorScheme.onPrimary),
                              ),
                            ),
                            Container(
                              width: 160,
                              margin: EdgeInsets.only(right: 12),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 37, vertical: 10),
                              transform: Matrix4.skewX(-.3),
                              color: Color(0xffFCDC0F),
                              alignment: Alignment.center,
                              child: Text(
                                "${vehicle.rateWithoutDriver} Rs",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            20.height,
                            Text(
                              'GET AMAZING DISCOUNTS AND OFFERS\nWHILE PURCHASING VIA APP',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: context.colorScheme.onPrimary),
                            ),
                            24.height,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    shape: StadiumBorder(),
                                    backgroundColor:
                                        context.colorScheme.onPrimary),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      size: 24,
                                      color: Color(0xff1C274C),
                                    ),
                                    10.width,
                                    Text(
                                      'ADD TO FAVOURITES',
                                      style: TextStyle(
                                        color: Color(0xff1C2427),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ).space(width: double.infinity, height: 48),
                            ),
                            24.height,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Divider(
                                color: context.colorScheme.onPrimary,
                                thickness: 1.4,
                              ),
                            ),
                            30.height,
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.separated(
                            separatorBuilder: (context, index) => 8.width,
                            itemCount: overViewItems.length,
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.all(20),
                            itemBuilder: (context, index) => Container(
                              height: 150,
                              width: 100,
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
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
                                  ], // Corresponds to 0.09% and 87.83%
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      overViewItems[index]['title'] as String,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: context.colorScheme.onPrimary),
                                    ),
                                    3.height,
                                    Text(
                                      overViewItems[index]['value'] as String,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: context.colorScheme.onPrimary),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ).space(height: 150, width: double.infinity),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          if (vehicle.images?.isNotEmpty ?? false)
                            PageView.builder(
                              itemCount: vehicle.images?.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        (vehicle.images ?? [])[index]),
                                  ),
                                ),
                              ),
                            ).space(height: context.screenHeight * 0.25),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(top: 40, bottom: 26, right: 20, left: 20),
          decoration: BoxDecoration(
              color: Color(0xff111214),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: Row(
            children: [
              GestureDetector(
                onTap: () async {
                  final Uri callUri = Uri.parse('https://wa.me/+923104460986');
                  if (!await launchUrl(callUri)) {
                    throw Exception('Could not launch $callUri');
                  }
                },
                child: Image.asset(
                  Assets.iconsWhatsapp,
                  height: 48,
                  width: 48,
                ),
              ),
              12.width,
              GestureDetector(
                onTap: () async {
                  final Uri callUri = Uri(
                    scheme: 'tel',
                    path: '+923104460986',
                  );
                  if (!await launchUrl(callUri)) {
                    throw Exception('Could not launch $callUri');
                  }
                },
                child: Image.asset(
                  Assets.iconsPhone,
                  height: 48,
                  width: 48,
                ),
              ),
              12.width,
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    final user = await SessionManager().getCurrentUser();
                    if (context.mounted) {
                      if (user != null) {
                        getIt<NavigationHelper>().push(
                            context,
                            BookVehicleView(
                                vehicle: vehicle,
                                customerId: user.customerId.toString()));
                      } else {
                        getIt<NavigationHelper>()
                            .push(context, LoginSignUpView());
                      }
                    }
                  },
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFA7910A), // #A7910A
                          Color(0xFF1D1B0C), // #1D1B0C
                        ],
                        transform: GradientRotation(
                          272.06 * (3.14159 / 180),
                        ),
                      ),
                      border: Border.all(
                        color: Color(0xff040500),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Book now',
                        style: TextStyle(
                            color: context.colorScheme.onPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
