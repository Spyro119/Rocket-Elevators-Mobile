class ElevatorStatus {
  final List<String> elevator_status;

  ElevatorStatus({this.elevator_status});

  factory ElevatorStatus.fromJson(List<dynamic> json) {
    return ElevatorStatus(
      elevator_status: json != null ? new List<String>.from(json) : null,
    );
  }

  List<dynamic> toJson() {
    List<dynamic> data = new List<String>();
    if (this.elevator_status != null) {
      data = this.elevator_status;
    }
    return data;
  }
}