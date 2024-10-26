import 'package:flutter_bloc/flutter_bloc.dart';
import '../Helper/database_helper_web.dart'; // Ensure you import the correct database helper for web.

class WebDataCubit extends Cubit<List<Employee>> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  Employee? _lastDeletedEmployee;

  WebDataCubit() : super([]) {
    _loadEmployees();
  }

  Future<void> _loadEmployees() async {
    final employees = await _databaseHelper.getEmployees();
    emit(employees);
  }

  Future<void> addEmployee(Employee employee) async {
    await _databaseHelper.insertEmployee(employee);
    _loadEmployees();
  }

  Future<void> deleteEmployee(Employee employee) async {
    if (employee.id != null) {
      _lastDeletedEmployee = employee; // Store the last deleted employee
      await _databaseHelper.deleteEmployee(employee.id!);
      _loadEmployees();
    }
  }

  // Future<void> deleteEmployeeById(int id) async {
  //   // Find the employee by ID and store it for undo
  //   _lastDeletedEmployee = state.firstWhere((e) => e.id == id, orElse: () => null);
  //   if (_lastDeletedEmployee != null) {
  //     await _databaseHelper.deleteEmployee(id);
  //     _loadEmployees();
  //   }
  // }

  Future<void> updateEmployee(Employee employee) async {
    await _databaseHelper.updateEmployee(employee);
    _loadEmployees();
  }

  Future<void> undoDelete() async {
    if (_lastDeletedEmployee != null) {
      await _databaseHelper.insertEmployee(_lastDeletedEmployee!);
      _lastDeletedEmployee = null;
      _loadEmployees();
    }
  }
}
