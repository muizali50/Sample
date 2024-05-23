part of 'admin_bloc.dart';

sealed class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object> get props => [];
}

class CreateStressor extends AdminEvent {
  final StressorModel stressor;
  final String iconFile;
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
  const UpdateStressor(
    this.stressor,
  );

  @override
  List<Object> get props => [
        stressor,
      ];
}
