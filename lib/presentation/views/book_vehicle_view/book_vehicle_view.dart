import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../blocs/loading_bloc/loading_bloc.dart';
import '../../../blocs/master_data/vehicle_all_makes_bloc/vehicle_all_makes_bloc.dart';
import '../../../blocs/master_data/vehicle_models_bloc/vehicle_models_bloc.dart';
import '../../../constants/extensions.dart';
import '../../../data/models/booking/make_update_booking_model.dart';
import '../../../data/models/vehicle/vehicle_model.dart';
import '../../../domain/implementations/booking/booking_repository.dart';
import '../../../navigation/navigation_helper.dart';
import '../../../utils/utils.dart';

class BookVehicleView extends StatefulWidget {
  const BookVehicleView(
      {super.key, required this.vehicle, required this.customerId});

  final VehicleModel vehicle;
  final String customerId;

  @override
  State<BookVehicleView> createState() => _BookVehicleViewState();
}

class _BookVehicleViewState extends State<BookVehicleView> {
  final ValueNotifier<DateTime> _pickupDate = ValueNotifier(DateTime.now());
  final ValueNotifier<DateTime> _returnDate =
      ValueNotifier(DateTime.now().add(Duration(days: 2)));
  final ValueNotifier<bool> _isWithOutDriver = ValueNotifier(true);
  final ValueNotifier<int> _totalDays = ValueNotifier(0);
  final ValueNotifier<int> _totalAmount = ValueNotifier(0);
  final ValueNotifier<num> _discount = ValueNotifier(0);
  final ValueNotifier<int> _amountAfterDiscount = ValueNotifier(0);

  @override
  void initState() {
    _calculateAmount();
    super.initState();
  }

  @override
  void dispose() {
    _pickupDate.dispose();
    _returnDate.dispose();
    _isWithOutDriver.dispose();
    _totalDays.dispose();
    _totalAmount.dispose();
    _discount.dispose();
    _amountAfterDiscount.dispose();
    super.dispose();
  }

  _calculateAmount() {
    final startDate = _pickupDate.value;
    final endDate = _returnDate.value;

    _totalDays.value = endDate.difference(startDate).inDays;
    if (_totalDays.value > 0) {
      _totalAmount.value = _totalDays.value *
          (int.tryParse(_isWithOutDriver.value
                  ? widget.vehicle.rateWithoutDriver ?? ""
                  : widget.vehicle.rateWithDriver ?? "") ??
              0);
      if (_totalDays.value >= 30) {
        _discount.value =
            (num.tryParse(widget.vehicle.discountMonth ?? "0")) ?? 0;
        _amountAfterDiscount.value =
            (_totalAmount.value * (_discount.value / 100)).toInt();
      } else if (_totalDays.value >= 7) {
        _discount.value =
            (num.tryParse(widget.vehicle.discountWeek ?? "0")) ?? 0;
        _amountAfterDiscount.value =
            (_totalAmount.value * (_discount.value / 100)).toInt();
      }
    }
  }

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
                    widget.vehicle.makeName?.toLowerCase(),
              )
              .firstOrNull
              ?.makeName ??
          "";
    }
    if (stateModels is VehicleModelsLoaded) {
      vehicleModel = stateModels.models
              .where(
                (element) => element.id == widget.vehicle.carModelId,
              )
              .firstOrNull
              ?.modelName ??
          "";
    }
    return BlocProvider(
      create: (context) => LoadingBloc(),
      child: Builder(builder: (context) {
        return LoadingOverlay(
          isLoading: context.select((LoadingBloc bloc) => bloc.state.isLoading),
          progressIndicator: CircularProgressIndicator.adaptive(),
          child: Scaffold(
            extendBody: true,
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    10.height,
                    Text(
                      'THE BOOKING',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffC6C6C6)),
                    ),
                    20.height,
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: context.colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                widget.vehicle.images?.firstOrNull ?? "",
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              )),
                          12.width,
                          Expanded(
                              child: Text(
                            "$vehicleMake $vehicleModel",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          )),
                        ],
                      ),
                    ),
                    20.height,
                    Text(
                      'PICKUP DATE',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffC6C6C6)),
                    ),
                    12.height,
                    GestureDetector(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          firstDate:
                              DateTime.now().subtract(Duration(days: 10000)),
                          lastDate: DateTime.now().add(Duration(days: 100000)),
                          currentDate: DateTime.now(),
                          initialDate: _pickupDate.value,
                        );
                        if (date != null) {
                          _pickupDate.value = date;
                          _calculateAmount();
                          FocusManager.instance.primaryFocus!.unfocus();
                        }
                      },
                      child: Container(
                        width: 250,
                        height: 55,
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              colors: [
                                Color(0xFFA7910A),
                                Color(0xFF1D1B0C), // #1D1B0C
                              ],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              stops: [0.3, 1]),
                          shape: BoxShape.rectangle,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: context.theme.scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: ValueListenableBuilder(
                                valueListenable: _pickupDate,
                                builder: (context, pickDate, _) {
                                  return Text(
                                    DateFormat('EEE, d MMM yyyy')
                                        .format(pickDate),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: context.colorScheme.onPrimary,
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ),
                    ),
                    20.height,
                    Text(
                      'DROP OFF DATE',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffC6C6C6)),
                    ),
                    12.height,
                    GestureDetector(
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          firstDate:
                              DateTime.now().subtract(Duration(days: 10000)),
                          lastDate: DateTime.now().add(Duration(days: 100000)),
                          currentDate: DateTime.now(),
                          initialDate: _returnDate.value,
                        );
                        if (date != null) {
                          _returnDate.value = date;
                          _calculateAmount();
                          FocusManager.instance.primaryFocus!.unfocus();
                        }
                      },
                      child: Container(
                        width: 250,
                        height: 55,
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              colors: [
                                Color(0xFFA7910A),
                                Color(0xFF1D1B0C), // #1D1B0C
                              ],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              stops: [0.3, 1]),
                          shape: BoxShape.rectangle,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: context.theme.scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: ValueListenableBuilder(
                                valueListenable: _returnDate,
                                builder: (context, returnDate, _) {
                                  return Text(
                                    DateFormat('EEE, d MMM yyyy')
                                        .format(returnDate),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: context.colorScheme.onPrimary,
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ),
                    ),
                    25.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Days',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: context.colorScheme.onPrimary),
                        ),
                        Container(
                          width: 100,
                          height: 38,
                          decoration: BoxDecoration(
                              color: Color(0xffF6BA10),
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                            child: ValueListenableBuilder(
                                valueListenable: _totalDays,
                                builder: (context, days, _) {
                                  return Text(
                                    days.toString(),
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                }),
                          ),
                        )
                      ],
                    ).space(width: 250),
                    20.height,
                    ValueListenableBuilder(
                        valueListenable: _isWithOutDriver,
                        builder: (context, isWithOutDriver, _) {
                          return Row(
                            spacing: 16,
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                      onTap: () {
                                        _isWithOutDriver.value = false;
                                        _calculateAmount();
                                      },
                                      child: _container(!isWithOutDriver, context,
                                          'WITH DRIVER'))),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  _isWithOutDriver.value = true;
                                  _calculateAmount();
                                },
                                child: _container(
                                    isWithOutDriver, context, 'WITH SELF'),
                              )),
                            ],
                          );
                        }),
                    20.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'TOTAL AMOUNT',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: context.colorScheme.onPrimary),
                        ),
                        Container(
                          width: 160,
                          height: 56,
                          decoration: BoxDecoration(
                              color: Color(0xffF6BA10),
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                            child: ListenableBuilder(
                                listenable: Listenable.merge([
                                  _amountAfterDiscount,
                                  _discount,
                                  _totalAmount
                                ]),
                                builder: (context, _) {
                                  return Text(
                                    'Rs ${_amountAfterDiscount.value == 0 ? _totalAmount.value : _amountAfterDiscount.value}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                }),
                          ),
                        )
                      ],
                    ),
                    100.height,
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 28),
              decoration: BoxDecoration(
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
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
              child: GestureDetector(
                onTap: () async {
                  final utils = getIt<Utils>();
                  if (!context.read<LoadingBloc>().state.isLoading) {
                    final repo = getIt<BookingRepository>();

                    try {
                      context.read<LoadingBloc>().add(StartLoading());
                      final res = await repo.createBooking(MakeUpdateBookingModel(
                        customerId: widget.customerId,
                        fromDate: _pickupDate.value,
                        toDate: _returnDate.value,
                        vehicleId: widget.vehicle.id,
                        withDriver: !_isWithOutDriver.value,
                        vehicleLatitude: 0,
                        vehicleLongitude: 0,
                        returnCondition: '',
                      ));
                      if (mounted && context.mounted) {
                        context.read<LoadingBloc>().add(StopLoading());
                        //TODO reload customer Rides bloc
                        getIt<NavigationHelper>().pop(context);
                        getIt<NavigationHelper>().pop(context);
                        utils.showSuccessFlushBar(context,
                            message: res.message ?? "Booking made successfully");
                      }
                    } catch (e, stackTrace) {
                      if (context.mounted) {
                        debugPrint(stackTrace.toString());
                        context.read<LoadingBloc>().add(StopLoading());
                        utils.showErrorFlushBar(context, message: e.toString());
                      }
                    }
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: Color(0xffEEB819),
                      ),
                      color: Color(0xff111214)),
                  child: Center(
                    child: Text(
                      'Request for booking'.toUpperCase(),
                      style: TextStyle(
                          color: context.colorScheme.onPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _container(isSelected, BuildContext context, String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
          color: isSelected ? Color(0xffF6BA10) : Color(0xff454746),
          borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: isSelected ? null : context.colorScheme.onPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
