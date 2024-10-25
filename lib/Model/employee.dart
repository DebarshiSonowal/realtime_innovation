class Employee {
  String name;
  String jobTitle;
  String from;
  String? to;

  Employee(this.name, this.jobTitle, this.from, this.to);

  // Method to convert a map to an Employee object
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      json['name'] as String? ?? '',         // Default to empty string if null
      json['jobTitle'] as String? ?? '',      // Default to empty string if null
      json['from'] as String? ?? '',          // Default to empty string if null
      json['to'] as String?,                  // Optional field can remain nullable
    );
  }

  // Method to convert an Employee object to a map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'jobTitle': jobTitle,
      'from': from,
      'to': to,
    };
  }
}
