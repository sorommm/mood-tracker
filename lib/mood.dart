class Mood {

  final int day;
  final int month;
  final int year;
  final String mood;
  final String description;


  Mood({

    required this.day,
    required this.month,
    required this.year,
    required this.mood,
    required this.description,
  });


  Map<String, Object?> toMap() {

    return {
      'day': day,
      'month': month,
      'year': year,
      'mood': mood,
      'description': description,
    };
  }


  @override
  String toString() {

    return '$day, $month, $year, $mood, $description';
  }
}