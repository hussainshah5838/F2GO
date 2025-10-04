class PlanModel {
  final String? id;
  final String? planPhoto;
  final String? title;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? maxMembers;
  final String? location;
  final String? category;
  final String? description;
  final String? age;
  final DateTime? createdAt;
  final String? planCreatorID;
  final String? status;
  final List<String>? participantsIds;

  PlanModel({
    this.id,
    this.planPhoto,
    this.title,
    this.startDate,
    this.endDate,
    this.maxMembers,
    this.location,
    this.category,
    this.description,
    this.age,
    this.createdAt,
    this.planCreatorID,
    this.status,
    this.participantsIds,
  });

  /// Factory to create model from Firebase snapshot or Map
  factory PlanModel.fromMap(Map<String, dynamic> map) {
    return PlanModel(
      id: map.containsKey('id') ? map['id'] as String? : null,
      planPhoto:
          map.containsKey('planPhoto') ? map['planPhoto'] as String? : null,
      title: map.containsKey('title') ? map['title'] as String? : null,
      startDate:
          map.containsKey('startDate') && map['startDate'] != null
              ? DateTime.tryParse(map['startDate'].toString())
              : null,
      endDate:
          map.containsKey('endDate') && map['endDate'] != null
              ? DateTime.tryParse(map['endDate'].toString())
              : null,
      maxMembers:
          map.containsKey('maxMembers') ? map['maxMembers'] as String? : null,
      location: map.containsKey('location') ? map['location'] as String? : null,
      category: map.containsKey('category') ? map['category'] as String? : null,
      description:
          map.containsKey('description') ? map['description'] as String? : null,
      age: map.containsKey('age') ? map['age'] as String? : null,
      createdAt:
          map.containsKey('createdAt') && map['createdAt'] != null
              ? DateTime.tryParse(map['createdAt'].toString())
              : null,
      planCreatorID:
          map.containsKey('planCreatorID')
              ? map['planCreatorID'] as String?
              : null,
      status: map.containsKey('status') ? map['status'] as String? : null,
      participantsIds:
          map.containsKey('participantsIds') && map['participantsIds'] != null
              ? List<String>.from(map['participantsIds'])
              : [],
    );
  }

  /// Convert model to Map for sending data to Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'planPhoto': planPhoto,
      'title': title,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'maxMembers': maxMembers,
      'location': location,
      'category': category,
      'description': description,
      'age': age,
      'createdAt': createdAt?.toIso8601String(),
      'planCreatorID': planCreatorID,
      'status': status,
      'participantsIds': participantsIds ?? [],
    };
  }
}
