class Policy {
  String? id;
  String? title;
  num? day;
  String? policyType;
  double? amount;
  bool? isDelete;
  String? notes;

  Policy(
      {this.id,
      this.title,
      this.day,
      this.policyType,
      this.isDelete,
      this.amount,
      this.notes});

  factory Policy.fromSnapshot(dynamic doc, String key) {
    return Policy(
      id: key,
      title: doc['title'],
      day: doc['day'],
      policyType: doc['politity'],
      isDelete: doc['is_delete'] ?? false,
      amount: doc['amount'],
      notes: doc['note'],
    );
  }
}
