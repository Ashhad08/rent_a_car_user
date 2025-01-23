import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/master_data/vehicle_all_makes_bloc/vehicle_all_makes_bloc.dart';
import '../../../blocs/master_data/vehicle_all_types_bloc/vehicle_all_types_bloc.dart';
import '../../../blocs/promotion/all_promotions_bloc/all_promotions_bloc.dart';
import '../../../blocs/vehicle/available_vehicles_bloc/available_vehicles_bloc.dart';
import '../../../constants/extensions.dart';
import '../../../data/models/auth/login_model.dart';
import '../../../domain/services/session_manager.dart';
import '../../../generated/assets.dart';
import '../../../navigation/navigation_helper.dart';
import '../../elements/app_text_field.dart';
import '../../elements/vehicle_card.dart';
import '../available_vehicles_view/available_vehicles_view.dart';
import '../profile_view/profile_view.dart';
import '../promotion_details_view/promotion_details_view.dart';
import '../vehicles_by_make_view/vehicles_by_make_view.dart';
import '../vehicles_by_type_view/vehicles_by_type_view.dart';

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
              onPressed: () {
                getIt<NavigationHelper>().push(context, ProfileView());
              },
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
              padding: EdgeInsets.symmetric(vertical: 20),
              color: Color(0xff1C2427),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'DRIVE YOUR DREAM CAR TODAY!',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: context.colorScheme.onPrimary),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Rent on daily or hourly basis.',
                      style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffCFD7DB)),
                    ),
                  ),
                  20.height,
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
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
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(34),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'NEW OFFERS',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: context.colorScheme.primary),
                      ),
                    ),
                  ),
                  18.height,
                  BlocBuilder<AllPromotionsBloc, AllPromotionsState>(
                    builder: (context, state) {
                      if (state is AllPromotionsError) {
                        return Center(
                          child: Text(
                            state.error,
                            style:
                                TextStyle(color: context.colorScheme.onPrimary),
                          ),
                        );
                      } else if (state is AllPromotionsLoaded) {
                        return ListView.separated(
                          separatorBuilder: (context, index) => 14.width,
                          itemCount: state.promos.length,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              getIt<NavigationHelper>().push(
                                  context,
                                  PromotionDetailsView(
                                    promotion: state.promos[index],
                                  ));
                            },
                            child: Container(
                              width: 260,
                              height: 280,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFF2D3538), // #2D3538
                                      Color(0xFF535554), // #535554
                                    ],
                                    stops: [0.0009, 0.8783],
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Positioned.fill(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(10)),
                                            child: Image.network(
                                              state.promos[index].promoImage ??
                                                  "",
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        20.height,
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            state.promos[index].promoTitle ??
                                                "",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: context
                                                    .colorScheme.onPrimary),
                                          ),
                                        ),
                                        25.height,
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: context.colorScheme.onPrimary,
                                          borderRadius: BorderRadius.vertical(
                                              bottom: Radius.circular(20))),
                                      child: Center(
                                        child: Text(
                                          "${state.promos[index].discountPercentage}% Off",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ).space(height: 280, width: double.infinity);
                      }
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    },
                  ),
                  24.height,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Divider(
                      color: Color(0xff485053),
                    ),
                  ),
                  20.height,
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
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 1.5),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              getIt<NavigationHelper>().push(
                                  context,
                                  VehiclesByTypeView(
                                    typeId: state.allTypes[index].id ?? "",
                                    typeName:
                                        state.allTypes[index].typeName ?? "",
                                  ));
                            },
                            child: ClipRRect(
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
                                          color:
                                              Color(0xff171717).withOp(0.6))),
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
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          itemCount: state.allMakes.length,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) => 8.width,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              getIt<NavigationHelper>().push(
                                  context,
                                  VehiclesByMakeView(
                                    makeName:
                                        state.allMakes[index].makeName ?? "",
                                  ));
                            },
                            child: Container(
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
                          ),
                        ).space(height: 84);
                      }
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    },
                  ),
                  35.height,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Divider(
                      color: Color(0xff485053),
                    ),
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: DefaultTextStyle(
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
                          padding: EdgeInsets.symmetric(horizontal: 12),
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
