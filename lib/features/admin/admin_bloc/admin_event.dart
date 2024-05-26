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
  List<Object> get props => [stressor];
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
