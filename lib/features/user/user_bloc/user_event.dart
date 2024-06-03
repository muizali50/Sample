part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

final class GenderEvent extends UserEvent {
  final String gender;
  const GenderEvent({
    required this.gender,
  });
  @override
  List<Object?> get props => [
        gender,
      ];
}

final class AgeSelect extends UserEvent {
  final String age;
  const AgeSelect({
    required this.age,
  });
  @override
  List<Object?> get props => [
        age,
      ];
}

final class SelectMood extends UserEvent {
  final String mood;
  const SelectMood({
    required this.mood,
  });
  @override
  List<Object?> get props => [
        mood,
      ];
}

final class SelectStressor extends UserEvent {
  final List<String?>? stressorsName;
  const SelectStressor({
    required this.stressorsName,
  });
  @override
  List<Object?> get props => [
        stressorsName,
      ];
}
