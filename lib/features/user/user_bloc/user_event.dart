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
