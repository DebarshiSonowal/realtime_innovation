import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import '../Model/employee.dart';

class DataCubit extends Cubit<List<Employee>> {
  final _storage = FlutterSecureStorage();
  List<Employee> _stateHistory = [];

  DataCubit() : super(List<Employee>.empty(growable: true)) {
    _loadFromSecureStorage();
  }

  void _updateState(List<Employee> val) {
    _stateHistory = List.from(val); // Copy current state for undo purposes
  }

  Future<void> _saveToSecureStorage() async {
    // Convert state to JSON and save
    List<String> employeeJsonList = _stateToJsonList(state);
    await _storage.write(key: 'employeeList', value: jsonEncode(employeeJsonList));
  }

  Future<void> _loadFromSecureStorage() async {
    String? jsonString = await _storage.read(key: 'employeeList');
    if (jsonString != null) {
      List<dynamic> employeeJsonList = jsonDecode(jsonString);
      state.clear();
      List<Employee> employeeList = employeeJsonList
          .map((e) => Employee.fromJson(jsonDecode(e as String)))
          .toList();
      state.addAll(employeeList);
      emit(List.from(state)); // Emit a copy of the loaded state
    }
  }


  List<String> _stateToJsonList(List<Employee> state) {
    return state.map((e) => jsonEncode(e.toJson())).toList(); // Assumes Employee has toJson
  }

  void undo() {
    if (_stateHistory.isNotEmpty) {
      emit(List.from(_stateHistory)); // Restore previous state
      _stateHistory.clear();
      _saveToSecureStorage(); // Update storage with the restored state
    }
  }

  void addEmployee(Employee val) {
    _updateState(state);
    state.add(val);
    emit(List.from(state));
    _saveToSecureStorage();
  }

  void editEmployee(int index, Employee val) {
    _updateState(state);
    state[index] = val;
    emit(List.from(state));
    _saveToSecureStorage();
  }

  void insertAt(int index, Employee val) {
    _updateState(state);
    state.insert(index, val);
    emit(List.from(state));
    _saveToSecureStorage();
  }

  Employee delete(Employee val) {
    _updateState(state);
    var item = state.firstWhere((element) => element == val);
    state.removeWhere((element) => element == val);
    emit(List.from(state));
    _saveToSecureStorage();
    return item;
  }
}
