part of 'admin_bloc.dart';

sealed class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object> get props => [];
}

final class AdminInitial extends AdminState {}

final class CreateStressorFailed extends AdminState {
  final String message;
  const CreateStressorFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class CreatingStressor extends AdminState {}

final class CreateStressorSuccess extends AdminState {
  final StressorModel stressor;
  const CreateStressorSuccess(
    this.stressor,
  );

  @override
  List<Object> get props => [
        stressor,
      ];
}

final class GetStressorFailed extends AdminState {
  final String message;
  const GetStressorFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GettingStressor extends AdminState {}

final class GetStressorSuccess extends AdminState {
  final List<StressorModel> stressors;
  const GetStressorSuccess(
    this.stressors,
  );

  @override
  List<Object> get props => [
        stressors,
      ];
}

final class UpdateStressorFailed extends AdminState {
  final String message;
  const UpdateStressorFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class UpdatingStressor extends AdminState {}

final class UpdateStressorSuccess extends AdminState {
  final StressorModel stressor;
  const UpdateStressorSuccess(
    this.stressor,
  );

  @override
  List<Object> get props => [
        stressor,
      ];
}

final class DeletingStressorFailed extends AdminState {
  final String message;
  const DeletingStressorFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class DeletingStressor extends AdminState {
  final String stressorId;
  const DeletingStressor(
    this.stressorId,
  );

  @override
  List<Object> get props => [
        stressorId,
      ];
}

final class DeletingStressorSuccess extends AdminState {
  final String stressorId;
  const DeletingStressorSuccess(
    this.stressorId,
  );

  @override
  List<Object> get props => [
        stressorId,
      ];
}

final class GetUserDataFailed extends AdminState {
  final String message;
  const GetUserDataFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GetUserDataLoading extends AdminState {}

final class GetUserDataSuccess extends AdminState {
  final List<AppUser> userData;
  const GetUserDataSuccess(
    this.userData,
  );

  @override
  List<Object> get props => [
        userData,
      ];
}

final class CreateBreathWorkCategoryFailed extends AdminState {
  final String message;
  const CreateBreathWorkCategoryFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class CreatingBreathWorkCategory extends AdminState {}

final class CreateBreathWorkCategorySuccess extends AdminState {
  final BreathWorkModel breathWork;
  const CreateBreathWorkCategorySuccess(
    this.breathWork,
  );

  @override
  List<Object> get props => [
        breathWork,
      ];
}

final class UpdateBreathWorkCategoryFailed extends AdminState {
  final String message;
  const UpdateBreathWorkCategoryFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class UpdatingBreathWorkCategory extends AdminState {}

final class UpdateBreathWorkCategorySuccess extends AdminState {
  final BreathWorkModel breathWork;
  const UpdateBreathWorkCategorySuccess(
    this.breathWork,
  );

  @override
  List<Object> get props => [
        breathWork,
      ];
}

final class GetBreathWorkCategoryFailed extends AdminState {
  final String message;
  const GetBreathWorkCategoryFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GettingBreathWorkCategory extends AdminState {}

final class GetBreathWorkCategorySuccess extends AdminState {
  final List<BreathWorkModel> breathWorks;
  const GetBreathWorkCategorySuccess(
    this.breathWorks,
  );

  @override
  List<Object> get props => [
        breathWorks,
      ];
}

final class DeletingBreathworkCategoryFailed extends AdminState {
  final String message;
  const DeletingBreathworkCategoryFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class DeletingBreathorkCategory extends AdminState {
  final String breathworkId;
  const DeletingBreathorkCategory(
    this.breathworkId,
  );

  @override
  List<Object> get props => [
        breathworkId,
      ];
}

final class DeletingBreathorkCategorySuccess extends AdminState {
  final String breathworkId;
  const DeletingBreathorkCategorySuccess(
    this.breathworkId,
  );

  @override
  List<Object> get props => [
        breathworkId,
      ];
}

final class CreateMeditationCategoryFailed extends AdminState {
  final String message;
  const CreateMeditationCategoryFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class CreatingMeditationCategory extends AdminState {}

final class CreateMeditationCategorySuccess extends AdminState {
  final MeditationModel meditation;
  const CreateMeditationCategorySuccess(
    this.meditation,
  );

  @override
  List<Object> get props => [
        meditation,
      ];
}

final class UpdateMeditationCategoryFailed extends AdminState {
  final String message;
  const UpdateMeditationCategoryFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class UpdatingMeditationCategory extends AdminState {}

final class UpdateMeditationCategorySuccess extends AdminState {
  final MeditationModel meditation;
  const UpdateMeditationCategorySuccess(
    this.meditation,
  );

  @override
  List<Object> get props => [
        meditation,
      ];
}

final class GetMeditationCategoryFailed extends AdminState {
  final String message;
  const GetMeditationCategoryFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GettingMeditationCategory extends AdminState {}

final class GetMeditationCategorySuccess extends AdminState {
  final List<MeditationModel> meditations;
  const GetMeditationCategorySuccess(
    this.meditations,
  );

  @override
  List<Object> get props => [
        meditations,
      ];
}

final class DeletingMeditationCategoryFailed extends AdminState {
  final String message;
  const DeletingMeditationCategoryFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class DeletingMeditationCategory extends AdminState {
  final String meditationId;
  const DeletingMeditationCategory(
    this.meditationId,
  );

  @override
  List<Object> get props => [
        meditationId,
      ];
}

final class DeletingMeditationCategorySuccess extends AdminState {
  final String meditationId;
  const DeletingMeditationCategorySuccess(
    this.meditationId,
  );

  @override
  List<Object> get props => [
        meditationId,
      ];
}
