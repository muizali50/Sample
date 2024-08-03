part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}

final class GenderLoading extends UserState {
  @override
  List<Object?> get props => [];
}

final class GenderSuccess extends UserState {
  @override
  List<Object?> get props => [];
}

final class GenderFailed extends UserState {
  final String message;
  const GenderFailed({
    required this.message,
  });
  @override
  List<Object?> get props => [];
}

final class AgeSelecting extends UserState {
  @override
  List<Object?> get props => [];
}

final class AgeSelected extends UserState {
  @override
  List<Object?> get props => [];
}

final class AgeSelectedFailed extends UserState {
  final String message;
  const AgeSelectedFailed({
    required this.message,
  });
  @override
  List<Object?> get props => [
        message,
      ];
}

final class MoodSelecting extends UserState {
  @override
  List<Object?> get props => [];
}

final class MoodSelected extends UserState {
  @override
  List<Object?> get props => [];
}

final class MoodSelectedFailed extends UserState {
  final String message;
  const MoodSelectedFailed({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

final class SelectingStressor extends UserState {
  @override
  List<Object?> get props => [];
}

final class StressorSelected extends UserState {
  @override
  List<Object?> get props => [];
}

final class StressorSelectedFailed extends UserState {
  final String message;
  const StressorSelectedFailed({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}

final class JournalAnswerUpdating extends UserState {
  @override
  List<Object?> get props => [];
}

final class JournalAnswerUpdated extends UserState {
  @override
  List<Object?> get props => [];
}

final class JournalAnswerUpdatedFailed extends UserState {
  final String message;
  const JournalAnswerUpdatedFailed(
    this.message,
  );

  @override
  List<Object?> get props => [
        message,
      ];
}
