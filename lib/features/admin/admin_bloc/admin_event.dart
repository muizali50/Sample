part of 'admin_bloc.dart';

sealed class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object> get props => [];
}

class CreateStressor extends AdminEvent {
  final StressorModel stressor;
  final XFile iconFile;
  const CreateStressor(
    this.stressor,
    this.iconFile,
  );

  @override
  List<Object> get props => [
        stressor,
        iconFile,
      ];
}

final class GetStressor extends AdminEvent {}

final class UpdateStressor extends AdminEvent {
  final StressorModel stressor;
  final XFile? iconFile;
  const UpdateStressor(
    this.stressor,
    this.iconFile,
  );

  @override
  List<Object> get props => [
        stressor,
      ];
}

final class DeleteEvent extends AdminEvent {
  final String stressorId;
  const DeleteEvent(
    this.stressorId,
  );
  @override
  List<Object> get props => [
        stressorId,
      ];
}

class GetUserData extends AdminEvent {}

class CreateBreathWorkCategory extends AdminEvent {
  final BreathWorkModel breathWork;
  final XFile iconFile;
  const CreateBreathWorkCategory(
    this.breathWork,
    this.iconFile,
  );

  @override
  List<Object> get props => [
        breathWork,
        iconFile,
      ];
}

final class UpdateBreathWorkCategory extends AdminEvent {
  final BreathWorkModel breathWork;
  final XFile? iconFile;
  const UpdateBreathWorkCategory(
    this.breathWork,
    this.iconFile,
  );

  @override
  List<Object> get props => [
        breathWork,
      ];
}

final class GetBreathWorkCategory extends AdminEvent {}

final class DeleteBreathWorkCategory extends AdminEvent {
  final String breathworkId;
  const DeleteBreathWorkCategory(
    this.breathworkId,
  );
  @override
  List<Object> get props => [
        breathworkId,
      ];
}

class CreateMeditationCategory extends AdminEvent {
  final MeditationModel meditation;
  final XFile iconFile;
  const CreateMeditationCategory(
    this.meditation,
    this.iconFile,
  );

  @override
  List<Object> get props => [
        meditation,
        iconFile,
      ];
}

final class UpdateMeditationCategory extends AdminEvent {
  final MeditationModel meditation;
  final XFile? iconFile;
  const UpdateMeditationCategory(
    this.meditation,
    this.iconFile,
  );

  @override
  List<Object> get props => [
        meditation,
      ];
}

final class GetMeditationCategory extends AdminEvent {}

final class DeleteMeditationCategory extends AdminEvent {
  final String meditationId;
  const DeleteMeditationCategory(
    this.meditationId,
  );
  @override
  List<Object> get props => [
        meditationId,
      ];
}
