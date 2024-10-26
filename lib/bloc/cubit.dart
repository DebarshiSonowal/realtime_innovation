import 'package:flutter_bloc/flutter_bloc.dart';
// import '../Helper/database_helper.dart';
import '../../Helper/database_helper_common.dart';
import '../Model/employee.dart';

class DataCubit extends Cubit<List<Employee>> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  Employee? _lastDeletedEmployee;

  DataCubit() : super([]) {
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
  
  Future<void> deleteEmployeeById(int id) async {
    _lastDeletedEmployee = state.firstWhere((e) => e.id == id,);
    await _databaseHelper.deleteEmployee(id);
    _loadEmployees();
  }

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
