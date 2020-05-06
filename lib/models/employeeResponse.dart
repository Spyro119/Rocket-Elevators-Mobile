class EmployeeResponse {
  int id;
  String firstname;
  String lastname;
  String function;
  String email;
  String aiProfile;

  EmployeeResponse(
      {this.id,
        this.firstname,
        this.lastname,
        this.function,
        this.email,
        this.aiProfile});

  factory EmployeeResponse.fromJson(Map<String, dynamic> json) {
    return new EmployeeResponse(
    id: json['id'],
    firstname: json['firstname'],
    lastname: json['lastname'],
    function: json['function'],
    email: json['email'],
    aiProfile: json['aiProfile'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['function'] = this.function;
    data['email'] = this.email;
    data['aiProfile'] = this.aiProfile;
    return data;
  }
}

class EmployeesList {
  final List<EmployeeResponse> employees;

  EmployeesList({
    this.employees,
  });

  factory EmployeesList.fromJson(List<dynamic> parsedJson) {

    List<EmployeeResponse> employees = parsedJson.map((i)=>EmployeeResponse.fromJson(i)).toList();
    return new EmployeesList(
      employees: employees
    );
  }
}