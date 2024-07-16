class RateRoomTypes {
  String? id;
  final bool? adjustRates;
  final int? adult;
  final num? amount;
  final bool? breakfast;
  final int? child;
  final String? deriveFrom;
  final bool? dinner;
  final bool? isDelete;
  final bool? lunch;
  final int? maxGuests;
  final String? name;
  final bool? percent;
  final num? rateMax;
  final num? rateMin;
  final int? ratesType;
  RateRoomTypes(
      {this.id,
      this.adjustRates = false,
      this.adult,
      this.amount,
      this.breakfast = false,
      this.child,
      this.deriveFrom,
      this.dinner = false,
      this.isDelete = false,
      this.lunch = false,
      this.maxGuests,
      this.name,
      this.percent = false,
      this.rateMax,
      this.rateMin,
      this.ratesType});

  factory RateRoomTypes.fromSnapShot({dynamic doc, String? key}) {
    return RateRoomTypes(
        id: key,
        adjustRates: doc['adjust_rates'] ?? false,
        adult: doc['aduilt'] ?? 0,
        amount: doc['amount'] ?? 0,
        breakfast: doc['breakfast'] ?? false,
        child: doc['child'] ?? 0,
        deriveFrom: doc['derive_from'] ?? "",
        dinner: doc['dinner'] ?? false,
        isDelete: doc['is_delete'] ?? false,
        lunch: doc['lunch'] ?? false,
        maxGuests: doc['max_guests'] ?? 0,
        name: doc['name'] ?? "",
        percent: doc['percent'] ?? false,
        rateMax: doc['rate_max'] ?? 0,
        rateMin: doc['rate_min'] ?? 0,
        ratesType: doc['rates_type'] ?? 0);
  }
}
