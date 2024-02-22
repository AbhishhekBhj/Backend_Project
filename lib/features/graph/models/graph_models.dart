class CaloricIntakeModel {
  final String date;
  final double caloricIntake;

  CaloricIntakeModel({required this.date, required this.caloricIntake});

  factory CaloricIntakeModel.fromJson(Map<String, dynamic> json) {
    return CaloricIntakeModel(
        date: json['date'], caloricIntake: json['caloricIntake']);
  }

  Map<String, dynamic> toJson() {
    return {'date': date, 'caloricIntake': caloricIntake};
  }

  @override
  String toString() {
    return 'CaloricIntakeModel{date: $date, caloricIntake: $caloricIntake}';
  }

  static List<CaloricIntakeModel> sampleDataList = [
    CaloricIntakeModel(date: '2024-01-01', caloricIntake: 2000.9),
    CaloricIntakeModel(date: '2024-01-02', caloricIntake: 2100),
    CaloricIntakeModel(date: '2024-01-03', caloricIntake: 2200),
    CaloricIntakeModel(date: '2024-01-04', caloricIntake: 2300),
    CaloricIntakeModel(date: '2024-01-05', caloricIntake: 2400),
    CaloricIntakeModel(date: '2024-01-06', caloricIntake: 2500),
    CaloricIntakeModel(date: '2024-01-07', caloricIntake: 2600),
    CaloricIntakeModel(date: '2024-01-08', caloricIntake: 2700),
    CaloricIntakeModel(date: '2024-01-09', caloricIntake: 2800),
    CaloricIntakeModel(date: '2024-01-10', caloricIntake: 2900),
    CaloricIntakeModel(date: '2024-01-11', caloricIntake: 2000),
    CaloricIntakeModel(date: '2024-01-12', caloricIntake: 2100),
    CaloricIntakeModel(date: '2024-01-13', caloricIntake: 2200),
    CaloricIntakeModel(date: '2024-01-14', caloricIntake: 2300),
    CaloricIntakeModel(date: '2024-01-15', caloricIntake: 2400),
    CaloricIntakeModel(date: '2024-01-16', caloricIntake: 2500),
    CaloricIntakeModel(date: '2024-01-17', caloricIntake: 2600),
    CaloricIntakeModel(date: '2024-01-18', caloricIntake: 2700),
    CaloricIntakeModel(date: '2024-01-19', caloricIntake: 2800),
    CaloricIntakeModel(date: '2024-01-20', caloricIntake: 2900),
    CaloricIntakeModel(date: '2024-01-21', caloricIntake: 2000),
    CaloricIntakeModel(date: '2024-01-22', caloricIntake: 2100),
    CaloricIntakeModel(date: '2024-01-23', caloricIntake: 2200),
    CaloricIntakeModel(date: '2024-01-24', caloricIntake: 2300),
    CaloricIntakeModel(date: '2024-01-25', caloricIntake: 2400),
    CaloricIntakeModel(date: '2024-01-26', caloricIntake: 2500),
    CaloricIntakeModel(date: '2024-01-27', caloricIntake: 2600),
    CaloricIntakeModel(date: '2024-01-28', caloricIntake: 2700),
    CaloricIntakeModel(date: '2024-01-29', caloricIntake: 2800),
    CaloricIntakeModel(date: '2024-01-30', caloricIntake: 2900),
    CaloricIntakeModel(date: '2024-01-31', caloricIntake: 2000),
    CaloricIntakeModel(date: '2024-02-01', caloricIntake: 2100),
    CaloricIntakeModel(date: '2024-02-02', caloricIntake: 2200),
    CaloricIntakeModel(date: '2024-02-03', caloricIntake: 2300),
    CaloricIntakeModel(date: '2024-02-04', caloricIntake: 2400),
    CaloricIntakeModel(date: '2024-02-05', caloricIntake: 2500),
    CaloricIntakeModel(date: '2024-02-06', caloricIntake: 2600),
    CaloricIntakeModel(date: '2024-02-07', caloricIntake: 2700.5),
    CaloricIntakeModel(date: '2024-02-08', caloricIntake: 2800),
    CaloricIntakeModel(date: '2024-02-09', caloricIntake: 2900),
    CaloricIntakeModel(date: '2024-02-10', caloricIntake: 2000),
    CaloricIntakeModel(date: '2024-02-11', caloricIntake: 2100),
    CaloricIntakeModel(date: '2024-02-12', caloricIntake: 2200),
    CaloricIntakeModel(date: '2024-02-13', caloricIntake: 2300),
    CaloricIntakeModel(date: '2024-02-14', caloricIntake: 2400),
    CaloricIntakeModel(date: '2024-02-15', caloricIntake: 2500),
    CaloricIntakeModel(date: '2024-02-16', caloricIntake: 2600),
    CaloricIntakeModel(date: '2024-02-17', caloricIntake: 2700),
    CaloricIntakeModel(date: '2024-02-18', caloricIntake: 2800),
    CaloricIntakeModel(date: '2024-02-19', caloricIntake: 2900),
    CaloricIntakeModel(date: '2024-02-20', caloricIntake: 3000),
  ];
}
