
import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:drift/web.dart';
import '../Model/employee.dart';

// Assuming 'employee.dart' contains the necessary code for the Employee data class.

part 'database_helper_web.g.dart';

@DriftDatabase(tables: [Employees])
class DatabaseHelper extends _$DatabaseHelper {
  DatabaseHelper()
      : super(WebDatabase('employees.db'));


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
  TextColumn get jobTitle => text().withLength(min: 1, max: 50)();
  TextColumn get fromDate => text()();
  TextColumn get toDate => text().nullable()();
}
