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

final class FavouriteDeclarationAdding extends UserState {
  @override
  List<Object?> get props => [];
}

final class FavouriteDeclarationAdded extends UserState {
  @override
  List<Object?> get props => [];
}

final class FavouriteDeclarationAddedFailed extends UserState {
  final String message;
  const FavouriteDeclarationAddedFailed(
    this.message,
  );

  @override
  List<Object?> get props => [
        message,
      ];
}

class BreathworkWatchedVideoLoading extends UserState {
  @override
  List<Object?> get props => [];
}

class BreathworkWatchedVideoLoaded extends UserState {
  final AppUser user;
  final double progress;

  const BreathworkWatchedVideoLoaded(
    this.user,
    this.progress,
  );
  @override
  List<Object?> get props => [
        user,
        progress,
      ];
}

class BreathworkWatchedVideoLoadingError extends UserState {
  final String message;

  const BreathworkWatchedVideoLoadingError({
    required this.message,
  });
  @override
  List<Object?> get props => [
        message,
      ];
}

class MeditationWatchedVideoLoading extends UserState {
  @override
  List<Object?> get props => [];
}

class MeditationWatchedVideoLoaded extends UserState {
  final AppUser user;
  final double progress;

  const MeditationWatchedVideoLoaded(
    this.user,
    this.progress,
  );
  @override
  List<Object?> get props => [
        user,
        progress,
      ];
}

class MeditationWatchedVideoLoadingError extends UserState {
  final String message;

  const MeditationWatchedVideoLoadingError({
    required this.message,
  });
  @override
  List<Object?> get props => [
        message,
      ];
}

class WriteJournalLoading extends UserState {
  @override
  List<Object?> get props => [];
}

class WriteJournalLoaded extends UserState {
  final AppUser user;
  final double progress;

  const WriteJournalLoaded(
    this.user,
    this.progress,
  );
  @override
  List<Object?> get props => [
        user,
        progress,
      ];
}

class WriteJournalLoadingError extends UserState {
  final String message;

  const WriteJournalLoadingError({
    required this.message,
  });
  @override
  List<Object?> get props => [
        message,
      ];
}
