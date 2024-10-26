// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_helper_web.dart';

// ignore_for_file: type=lint
class $EmployeesTable extends Employees
    with TableInfo<$EmployeesTable, Employee> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmployeesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _jobTitleMeta =
      const VerificationMeta('jobTitle');
  @override
  late final GeneratedColumn<String> jobTitle = GeneratedColumn<String>(
      'job_title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _fromDateMeta =
      const VerificationMeta('fromDate');
  @override
  late final GeneratedColumn<String> fromDate = GeneratedColumn<String>(
      'from_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _toDateMeta = const VerificationMeta('toDate');
  @override
  late final GeneratedColumn<String> toDate = GeneratedColumn<String>(
      'to_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name, jobTitle, fromDate, toDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'employees';
  @override
  VerificationContext validateIntegrity(Insertable<Employee> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('job_title')) {
      context.handle(_jobTitleMeta,
          jobTitle.isAcceptableOrUnknown(data['job_title']!, _jobTitleMeta));
    } else if (isInserting) {
      context.missing(_jobTitleMeta);
    }
    if (data.containsKey('from_date')) {
      context.handle(_fromDateMeta,
          fromDate.isAcceptableOrUnknown(data['from_date']!, _fromDateMeta));
    } else if (isInserting) {
      context.missing(_fromDateMeta);
    }
    if (data.containsKey('to_date')) {
      context.handle(_toDateMeta,
          toDate.isAcceptableOrUnknown(data['to_date']!, _toDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Employee map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Employee(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      jobTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}job_title'])!,
      fromDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}from_date'])!,
      toDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}to_date']),
    );
  }

  @override
  $EmployeesTable createAlias(String alias) {
    return $EmployeesTable(attachedDatabase, alias);
  }
}

class Employee extends DataClass implements Insertable<Employee> {
  final int id;
  final String name;
  final String jobTitle;
  final String fromDate;
  final String? toDate;
  const Employee(
      {required this.id,
      required this.name,
      required this.jobTitle,
      required this.fromDate,
      this.toDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['job_title'] = Variable<String>(jobTitle);
    map['from_date'] = Variable<String>(fromDate);
    if (!nullToAbsent || toDate != null) {
      map['to_date'] = Variable<String>(toDate);
    }
    return map;
  }

  EmployeesCompanion toCompanion(bool nullToAbsent) {
    return EmployeesCompanion(
      id: Value(id),
      name: Value(name),
      jobTitle: Value(jobTitle),
      fromDate: Value(fromDate),
      toDate:
          toDate == null && nullToAbsent ? const Value.absent() : Value(toDate),
    );
  }

  factory Employee.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Employee(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      jobTitle: serializer.fromJson<String>(json['jobTitle']),
      fromDate: serializer.fromJson<String>(json['fromDate']),
      toDate: serializer.fromJson<String?>(json['toDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'jobTitle': serializer.toJson<String>(jobTitle),
      'fromDate': serializer.toJson<String>(fromDate),
      'toDate': serializer.toJson<String?>(toDate),
    };
  }

  Employee copyWith(
          {int? id,
          String? name,
          String? jobTitle,
          String? fromDate,
          Value<String?> toDate = const Value.absent()}) =>
      Employee(
        id: id ?? this.id,
        name: name ?? this.name,
        jobTitle: jobTitle ?? this.jobTitle,
        fromDate: fromDate ?? this.fromDate,
        toDate: toDate.present ? toDate.value : this.toDate,
      );
  Employee copyWithCompanion(EmployeesCompanion data) {
    return Employee(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      jobTitle: data.jobTitle.present ? data.jobTitle.value : this.jobTitle,
      fromDate: data.fromDate.present ? data.fromDate.value : this.fromDate,
      toDate: data.toDate.present ? data.toDate.value : this.toDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Employee(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('jobTitle: $jobTitle, ')
          ..write('fromDate: $fromDate, ')
          ..write('toDate: $toDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, jobTitle, fromDate, toDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Employee &&
          other.id == this.id &&
          other.name == this.name &&
          other.jobTitle == this.jobTitle &&
          other.fromDate == this.fromDate &&
          other.toDate == this.toDate);
}

class EmployeesCompanion extends UpdateCompanion<Employee> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> jobTitle;
  final Value<String> fromDate;
  final Value<String?> toDate;
  const EmployeesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.jobTitle = const Value.absent(),
    this.fromDate = const Value.absent(),
    this.toDate = const Value.absent(),
  });
  EmployeesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String jobTitle,
    required String fromDate,
    this.toDate = const Value.absent(),
  })  : name = Value(name),
        jobTitle = Value(jobTitle),
        fromDate = Value(fromDate);
  static Insertable<Employee> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? jobTitle,
    Expression<String>? fromDate,
    Expression<String>? toDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (jobTitle != null) 'job_title': jobTitle,
      if (fromDate != null) 'from_date': fromDate,
      if (toDate != null) 'to_date': toDate,
    });
  }

  EmployeesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? jobTitle,
      Value<String>? fromDate,
      Value<String?>? toDate}) {
    return EmployeesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      jobTitle: jobTitle ?? this.jobTitle,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (jobTitle.present) {
      map['job_title'] = Variable<String>(jobTitle.value);
    }
    if (fromDate.present) {
      map['from_date'] = Variable<String>(fromDate.value);
    }
    if (toDate.present) {
      map['to_date'] = Variable<String>(toDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmployeesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('jobTitle: $jobTitle, ')
          ..write('fromDate: $fromDate, ')
          ..write('toDate: $toDate')
          ..write(')'))
        .toString();
  }
}

abstract class _$DatabaseHelper extends GeneratedDatabase {
  _$DatabaseHelper(QueryExecutor e) : super(e);
  $DatabaseHelperManager get managers => $DatabaseHelperManager(this);
  late final $EmployeesTable employees = $EmployeesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [employees];
}

typedef $$EmployeesTableCreateCompanionBuilder = EmployeesCompanion Function({
  Value<int> id,
  required String name,
  required String jobTitle,
  required String fromDate,
  Value<String?> toDate,
});
typedef $$EmployeesTableUpdateCompanionBuilder = EmployeesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> jobTitle,
  Value<String> fromDate,
  Value<String?> toDate,
});

class $$EmployeesTableFilterComposer
    extends Composer<_$DatabaseHelper, $EmployeesTable> {
  $$EmployeesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get jobTitle => $composableBuilder(
      column: $table.jobTitle, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fromDate => $composableBuilder(
      column: $table.fromDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get toDate => $composableBuilder(
      column: $table.toDate, builder: (column) => ColumnFilters(column));
}

class $$EmployeesTableOrderingComposer
    extends Composer<_$DatabaseHelper, $EmployeesTable> {
  $$EmployeesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get jobTitle => $composableBuilder(
      column: $table.jobTitle, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fromDate => $composableBuilder(
      column: $table.fromDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get toDate => $composableBuilder(
      column: $table.toDate, builder: (column) => ColumnOrderings(column));
}

class $$EmployeesTableAnnotationComposer
    extends Composer<_$DatabaseHelper, $EmployeesTable> {
  $$EmployeesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get jobTitle =>
      $composableBuilder(column: $table.jobTitle, builder: (column) => column);

  GeneratedColumn<String> get fromDate =>
      $composableBuilder(column: $table.fromDate, builder: (column) => column);

  GeneratedColumn<String> get toDate =>
      $composableBuilder(column: $table.toDate, builder: (column) => column);
}

class $$EmployeesTableTableManager extends RootTableManager<
    _$DatabaseHelper,
    $EmployeesTable,
    Employee,
    $$EmployeesTableFilterComposer,
    $$EmployeesTableOrderingComposer,
    $$EmployeesTableAnnotationComposer,
    $$EmployeesTableCreateCompanionBuilder,
    $$EmployeesTableUpdateCompanionBuilder,
    (Employee, BaseReferences<_$DatabaseHelper, $EmployeesTable, Employee>),
    Employee,
    PrefetchHooks Function()> {
  $$EmployeesTableTableManager(_$DatabaseHelper db, $EmployeesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmployeesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmployeesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmployeesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> jobTitle = const Value.absent(),
            Value<String> fromDate = const Value.absent(),
            Value<String?> toDate = const Value.absent(),
          }) =>
              EmployeesCompanion(
            id: id,
            name: name,
            jobTitle: jobTitle,
            fromDate: fromDate,
            toDate: toDate,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String jobTitle,
            required String fromDate,
            Value<String?> toDate = const Value.absent(),
          }) =>
              EmployeesCompanion.insert(
            id: id,
            name: name,
            jobTitle: jobTitle,
            fromDate: fromDate,
            toDate: toDate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$EmployeesTableProcessedTableManager = ProcessedTableManager<
    _$DatabaseHelper,
    $EmployeesTable,
    Employee,
    $$EmployeesTableFilterComposer,
    $$EmployeesTableOrderingComposer,
    $$EmployeesTableAnnotationComposer,
    $$EmployeesTableCreateCompanionBuilder,
    $$EmployeesTableUpdateCompanionBuilder,
    (Employee, BaseReferences<_$DatabaseHelper, $EmployeesTable, Employee>),
    Employee,
    PrefetchHooks Function()>;

class $DatabaseHelperManager {
  final _$DatabaseHelper _db;
  $DatabaseHelperManager(this._db);
  $$EmployeesTableTableManager get employees =>
      $$EmployeesTableTableManager(_db, _db.employees);
}
