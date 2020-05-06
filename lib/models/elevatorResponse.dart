class ElevatorsResponse {
  int id;
  String buildingType;
  int elevatorSerialNumber;
  String elevatorModel;
  String elevatorStatus;
  String elevatorInformation;
  int columnId;

  ElevatorsResponse(
      {this.id,
        this.buildingType,
        this.elevatorSerialNumber,
        this.elevatorModel,
        this.elevatorStatus,
        this.elevatorInformation,
        this.columnId});

  ElevatorsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    buildingType = json['building_type'];
    elevatorSerialNumber = json['elevator_serial_number'];
    elevatorModel = json['elevator_model'];
    elevatorStatus = json['elevator_status'];
    elevatorInformation = json['elevator_information'];
    columnId = json['column_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['building_type'] = this.buildingType;
    data['elevator_serial_number'] = this.elevatorSerialNumber;
    data['elevator_model'] = this.elevatorModel;
    data['elevator_status'] = this.elevatorStatus;
    data['elevator_information'] = this.elevatorInformation;
    data['column_id'] = this.columnId;
    return data;
  }
}