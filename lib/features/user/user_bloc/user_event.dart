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

final class UpdateJournalAnswer extends UserEvent {
  final String journalId;
  final String answer;
  const UpdateJournalAnswer(
    this.journalId,
    this.answer,
  );
  @override
  List<Object> get props => [
        journalId,
        answer,
      ];
}

final class AddFavouriteDeclaration extends UserEvent {
  final String declarationId;
  final String userId;
  const AddFavouriteDeclaration(
    this.declarationId,
    this.userId,
  );
  @override
  List<Object?> get props => [
        declarationId,
        userId,
      ];
}

class LoadBreathworkWatchedVideo extends UserEvent {
  @override
  List<Object?> get props => [];
}

class BreathWorkVideoWatched extends UserEvent {
  final String videoId;
  const BreathWorkVideoWatched(
    this.videoId,
  );
  @override
  List<Object?> get props => [
        videoId,
      ];
}

class MeditationVideoWatched extends UserEvent {
  final String videoId;
  const MeditationVideoWatched(
    this.videoId,
  );
  @override
  List<Object?> get props => [
        videoId,
      ];
}

class WriteJournal extends UserEvent {
  final String journalId;
  const WriteJournal(
    this.journalId,
  );
  @override
  List<Object?> get props => [
        journalId,
      ];
}
