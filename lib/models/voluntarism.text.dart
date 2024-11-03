class Voluntarism {
  final String name;
  final String description;
  final String location;
  final DateTime date;
  final int numberOfPeople;
  bool isEnrolled = false;

  Voluntarism({
    required this.name,
    required this.description,
    required this.date,
    required this.numberOfPeople,
    required this.location,
  });
}
