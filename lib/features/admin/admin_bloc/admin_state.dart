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
