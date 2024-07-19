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

class CreateBreathWorkVideo extends AdminEvent {
  final BreathworkVideo breathWorkVideo;
  final XFile videoIconFile;
  const CreateBreathWorkVideo(
    this.breathWorkVideo,
    this.videoIconFile,
  );

  @override
  List<Object> get props => [
        breathWorkVideo,
        videoIconFile,
      ];
}

class UpdateBreathWorkVideo extends AdminEvent {
  final BreathworkVideo breathWorkVideo;
  final XFile? videoIconFile;
  const UpdateBreathWorkVideo(
    this.breathWorkVideo,
    this.videoIconFile,
  );

  @override
  List<Object> get props => [
        breathWorkVideo,
      ];
}

final class GetBreathworkVideo extends AdminEvent {}

final class DeleteBreathworkVideo extends AdminEvent {
  final String breathworkVideoId;
  const DeleteBreathworkVideo(
    this.breathworkVideoId,
  );
  @override
  List<Object> get props => [
        breathworkVideoId,
      ];
}

final class UpdateBreathWorkVideoReaction extends AdminEvent {
  final String videoId;
  final String reaction;
  const UpdateBreathWorkVideoReaction(
    this.videoId,
    this.reaction,
  );
  @override
  List<Object> get props => [
        videoId,
        reaction,
      ];
}

class CreateMeditationVideo extends AdminEvent {
  final MeditationVideo meditationVideo;
  final XFile videoIconFile;

  const CreateMeditationVideo(
    this.meditationVideo,
    this.videoIconFile,
  );

  @override
  List<Object> get props => [
        meditationVideo,
        videoIconFile,
      ];
}

class UpdateMeditationVideo extends AdminEvent {
  final MeditationVideo meditationVideo;
  final XFile? videoIconFile;

  const UpdateMeditationVideo(
    this.meditationVideo,
    this.videoIconFile,
  );

  @override
  List<Object> get props => [
        meditationVideo,
      ];
}

final class GetMeditationVideo extends AdminEvent {}

final class DeleteMeditationVideo extends AdminEvent {
  final String meditationVideoId;
  const DeleteMeditationVideo(
    this.meditationVideoId,
  );
  @override
  List<Object> get props => [
        meditationVideoId,
      ];
}

final class UpdateMeditationVideoReaction extends AdminEvent {
  final String videoId;
  final String reaction;
  const UpdateMeditationVideoReaction(
    this.videoId,
    this.reaction,
  );
  @override
  List<Object> get props => [
        videoId,
        reaction,
      ];
}

class CreateBlogCategory extends AdminEvent {
  final BlogCategoryModel blogCategory;
  final XFile iconFile;
  const CreateBlogCategory(
    this.blogCategory,
    this.iconFile,
  );

  @override
  List<Object> get props => [
        blogCategory,
        iconFile,
      ];
}

final class UpdateBlogCategory extends AdminEvent {
  final BlogCategoryModel blogCategory;
  final XFile? iconFile;
  const UpdateBlogCategory(
    this.blogCategory,
    this.iconFile,
  );

  @override
  List<Object> get props => [
        blogCategory,
      ];
}

final class GetBlogCategory extends AdminEvent {}

final class DeleteBlogCategory extends AdminEvent {
  final String blogCategoryId;
  const DeleteBlogCategory(
    this.blogCategoryId,
  );
  @override
  List<Object> get props => [
        blogCategoryId,
      ];
}

class CreateBlog extends AdminEvent {
  final BlogModel blog;
  final XFile iconFile;
  const CreateBlog(
    this.blog,
    this.iconFile,
  );

  @override
  List<Object> get props => [
        blog,
        iconFile,
      ];
}

final class UpdateBlog extends AdminEvent {
  final BlogModel blog;
  final XFile? iconFile;
  const UpdateBlog(
    this.blog,
    this.iconFile,
  );

  @override
  List<Object> get props => [
        blog,
      ];
}

final class GetBlog extends AdminEvent {}

final class DeleteBlog extends AdminEvent {
  final String blogId;
  const DeleteBlog(
    this.blogId,
  );
  @override
  List<Object> get props => [
        blogId,
      ];
}

class CreateJournalCategory extends AdminEvent {
  final JournalCategoryModel journalCategory;
  final XFile iconFile;
  const CreateJournalCategory(
    this.journalCategory,
    this.iconFile,
  );

  @override
  List<Object> get props => [
        journalCategory,
        iconFile,
      ];
}

final class UpdateJournalCategory extends AdminEvent {
  final JournalCategoryModel journalCategory;
  final XFile? iconFile;
  const UpdateJournalCategory(
    this.journalCategory,
    this.iconFile,
  );

  @override
  List<Object> get props => [
        journalCategory,
      ];
}

final class GetJournalCategory extends AdminEvent {}

final class DeleteJournalCategory extends AdminEvent {
  final String journalCategoryId;
  const DeleteJournalCategory(
    this.journalCategoryId,
  );
  @override
  List<Object> get props => [
        journalCategoryId,
      ];
}
