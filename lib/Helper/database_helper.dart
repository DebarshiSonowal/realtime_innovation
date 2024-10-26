import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../Model/employee.dart';
// Assuming 'employee.dart' contains the necessary code for the Employee data class.

part 'database_helper.g.dart';

@DriftDatabase(tables: [Employees])
class DatabaseHelper extends _$DatabaseHelper {
  DatabaseHelper() : super(_openConnection());

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final appDocDir = await getApplicationDocumentsDirectory();
      final dbFolder = appDocDir.path;
      final file = File(join(dbFolder, 'employees.db'));
      return NativeDatabase(file);
    });
  }

  @override
  int get schemaVersion => 1;

  Future<void> insertEmployee(Employee employee) async {
    into(employees).insert(employee.toCompanion(true));
  }

  Future<List<Employee>> getEmployees() async {
    return select(employees).get();
  }

  Future<void> deleteEmployee(int id) async {
    (delete(employees)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> updateEmployee(Employee employee) async {
    update(employees).replace(employee);
  }
}

@DataClassName('Employee')
class Employees extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get jobTitle => text().withLength(min: 1, max: 50)();  // Ensure this matches the code used
  TextColumn get fromDate => text()();
  TextColumn get toDate => text().nullable()();
}
