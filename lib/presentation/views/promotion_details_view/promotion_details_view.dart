import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/extensions.dart';
import '../../../data/models/promotion/promotion_model.dart';
import '../../elements/vehicle_card.dart';

class PromotionDetailsView extends StatelessWidget {
  const PromotionDetailsView({super.key, required this.promotion});

  final PromotionInfo promotion;

  @override
  Widget build(BuildContext context) {
    String dateRange;
    if (promotion.startDate == null || promotion.endDate == null) {
      dateRange = '';
    }

    String formattedStartDate =
        DateFormat('MMM d, yyyy').format(promotion.startDate!);
    String formattedEndDate =
        DateFormat('MMM d, yyyy').format(promotion.endDate!);

    dateRange = '$formattedStartDate - $formattedEndDate';
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          if (promotion.promoImage != null)
            Image.network(
              promotion.promoImage!,
              height: context.screenHeight * 0.3,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  20.height,
                  Text(
                    promotion.promoTitle ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: context.colorScheme.onPrimary),
                  ),
                  Text(
                    promotion.description ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: context.colorScheme.onPrimary),
                  ),
                  20.height,
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    decoration: BoxDecoration(
                        color: context.colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "${promotion.discountPercentage}% Off",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                  20.height,
                  Text(
                    dateRange,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: context.colorScheme.onPrimary,
                    ),
                  ),
                  20.height,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Vehicles',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: context.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  20.height,
                  ListView.separated(
                    separatorBuilder: (context, index) => 12.height,
                    itemCount: (promotion.vehicleList ?? []).length,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => VehicleCard(
                      vehicle: (promotion.vehicleList ?? [])[index],
                    ),
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
