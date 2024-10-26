// class Employee {
//   int? id;
//   String name, jobTitle, from;
//   String? to;
//
//   Employee(this.name, this.jobTitle, this.from, this.to, {this.id});
//
//   factory Employee.fromJson(Map<String, dynamic> json) {
//     return Employee(
//       json['name'] as String,
//       json['jobTitle'] as String,
//       json['fromDate'] as String,
//       json['toDate'] as String?,
//       id: json['id'] as int?,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'jobTitle': jobTitle,
//       'fromDate': from,
//       'toDate': to,
//     };
//   }
// }
