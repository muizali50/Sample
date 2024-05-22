import 'package:file_picker/file_picker.dart';

class StressorModel{
  String? stressorId;
  String? title;
  String? status;
  String? icon;
  PlatformFile? iconFile;

  StressorModel({
    this.stressorId,
    this.title,
    this.status,
    this.icon,
    this.iconFile,
  });

  Map<String, dynamic> toMap(){
    return {
      'stressorId': stressorId,
      'title': title,
      'status': status,
      'icon': icon,
    };
  }

  factory StressorModel.fromMap(Map<String, dynamic> map){
    return StressorModel(
      stressorId: map['stressorId'],
      title: map['title'],
      status: map['status'],
      icon: map['icon'], 
    );
  }

}