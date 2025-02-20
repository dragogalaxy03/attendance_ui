class Employee {
  final String imageUrl;
  final String name;
  final String position;
  final int id;
  final int present;
  final int absent;
  final int halfDay;
  final int holiday;
  final int weekend;
  final int notavail;
  final double debits;
  final double bonus;
  final int overtimeHours;
  final double overtimeWages;
  final double totalSalary;

  Employee({
    required this.imageUrl,
    required this.name,
    required this.position,
    required this.id,
    required this.present,
    required this.absent,
    required this.halfDay,
    required this.holiday,
    required this.weekend,
    required this.notavail,
    required this.debits,
    required this.bonus,
    required this.overtimeHours,
    required this.overtimeWages,
    required this.totalSalary,
  });
}