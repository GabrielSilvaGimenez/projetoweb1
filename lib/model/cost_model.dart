class CostModel {
  final int id;
  final String name;
  final double value;
  final String description;
  final int itemId;

  CostModel({
    required this.id,
    required this.name,
    required this.value,
    required this.description,
    required this.itemId,
  });

  factory CostModel.fromJson(Map<String, dynamic> json) {
    return CostModel(
      id: json['id'],
      name: json['name'],
      value: json['value'].toDouble(),
      description: json['description'],
      itemId: json['itemId'],
    );
  }
}
