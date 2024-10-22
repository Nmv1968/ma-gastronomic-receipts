class Excersise {
  late int id;
  late String userId;
  late String day;
  late String month;
  late String year;
  late DateTime date;
  late int time;

  Excersise(
      {required this.id,
      required this.userId,
      required this.day,
      required this.month,
      required this.year,
      required this.date,
      required this.time});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'day': day,
      'month': month,
      'year': year,
      'date': date,
      'time': time
    };
  }
}
