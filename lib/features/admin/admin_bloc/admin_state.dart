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

final class CreateBreathWorkVideoFailed extends AdminState {
  final String message;
  const CreateBreathWorkVideoFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class CreatingBreathWorkVideo extends AdminState {}

final class CreateBreathWorkVideoSuccess extends AdminState {
  final BreathworkVideo breathWorkVideo;
  const CreateBreathWorkVideoSuccess(
    this.breathWorkVideo,
  );

  @override
  List<Object> get props => [
        breathWorkVideo,
      ];
}

final class UpdateBreathWorkVideoFailed extends AdminState {
  final String message;
  const UpdateBreathWorkVideoFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class UpdatingBreathWorkVideo extends AdminState {}

final class UpdateBreathWorkVideoSuccess extends AdminState {
  final BreathworkVideo breathWorkVideo;
  const UpdateBreathWorkVideoSuccess(
    this.breathWorkVideo,
  );

  @override
  List<Object> get props => [
        breathWorkVideo,
      ];
}

final class GetBreathworkVideoFailed extends AdminState {
  final String message;
  const GetBreathworkVideoFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GettingBreathworkVideo extends AdminState {}

final class GetBreathworkVideoSuccess extends AdminState {
  final List<BreathworkVideo> breathworkVideos;
  const GetBreathworkVideoSuccess(
    this.breathworkVideos,
  );

  @override
  List<Object> get props => [
        breathworkVideos,
      ];
}

final class DeletingBreathworkVideoFailed extends AdminState {
  final String message;
  const DeletingBreathworkVideoFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class DeletingBreathorkVideo extends AdminState {
  final String breathworkVideoId;
  const DeletingBreathorkVideo(
    this.breathworkVideoId,
  );

  @override
  List<Object> get props => [
        breathworkVideoId,
      ];
}

final class DeletingBreathorkVideoSuccess extends AdminState {
  final String breathworkVideoId;
  const DeletingBreathorkVideoSuccess(
    this.breathworkVideoId,
  );

  @override
  List<Object> get props => [
        breathworkVideoId,
      ];
}

final class BreathworkVideoReactionUpdated extends AdminState {}

final class UpdatingBreathworkVideoReaction extends AdminState {}

final class BreathworkVideoReactionUpdatedFailed extends AdminState {
  final String message;
  const BreathworkVideoReactionUpdatedFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class CreateMeditationVideoFailed extends AdminState {
  final String message;
  const CreateMeditationVideoFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class CreatingMeditationVideo extends AdminState {}

final class CreateMeditationVideoSuccess extends AdminState {
  final MeditationVideo meditationVideo;
  const CreateMeditationVideoSuccess(
    this.meditationVideo,
  );

  @override
  List<Object> get props => [
        meditationVideo,
      ];
}

final class UpdateMeditationVideoFailed extends AdminState {
  final String message;
  const UpdateMeditationVideoFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class UpdatingMeditationVideo extends AdminState {}

final class UpdateMeditationVideoSuccess extends AdminState {
  final MeditationVideo meditationVideo;
  const UpdateMeditationVideoSuccess(
    this.meditationVideo,
  );

  @override
  List<Object> get props => [
        meditationVideo,
      ];
}

final class GetMeditationVideoFailed extends AdminState {
  final String message;
  const GetMeditationVideoFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GettingMeditationVideo extends AdminState {}

final class GetMeditationVideoSuccess extends AdminState {
  final List<MeditationVideo> meditationVideos;
  const GetMeditationVideoSuccess(
    this.meditationVideos,
  );

  @override
  List<Object> get props => [
        meditationVideos,
      ];
}

final class DeletingMeditationVideoFailed extends AdminState {
  final String message;
  const DeletingMeditationVideoFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class DeletingMeditationVideo extends AdminState {
  final String meditationVideoId;
  const DeletingMeditationVideo(
    this.meditationVideoId,
  );

  @override
  List<Object> get props => [
        meditationVideoId,
      ];
}

final class DeletingMeditationVideoSuccess extends AdminState {
  final String meditationVideoId;
  const DeletingMeditationVideoSuccess(
    this.meditationVideoId,
  );

  @override
  List<Object> get props => [
        meditationVideoId,
      ];
}

final class MeditationVideoReactionUpdated extends AdminState {}

final class UpdatingMeditationVideoReaction extends AdminState {}

final class MeditationVideoReactionUpdatedFailed extends AdminState {
  final String message;
  const MeditationVideoReactionUpdatedFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class CreateBlogCategoryFailed extends AdminState {
  final String message;
  const CreateBlogCategoryFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class CreatingBlogCategory extends AdminState {}

final class CreateBlogCategorySuccess extends AdminState {
  final BlogCategoryModel blogCategory;
  const CreateBlogCategorySuccess(
    this.blogCategory,
  );

  @override
  List<Object> get props => [
        blogCategory,
      ];
}

final class UpdateBlogCategoryFailed extends AdminState {
  final String message;
  const UpdateBlogCategoryFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class UpdatingBlogCategory extends AdminState {}

final class UpdateBlogCategorySuccess extends AdminState {
  final BlogCategoryModel blogCategory;
  const UpdateBlogCategorySuccess(
    this.blogCategory,
  );

  @override
  List<Object> get props => [
        blogCategory,
      ];
}

final class GetBlogCategoryFailed extends AdminState {
  final String message;
  const GetBlogCategoryFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GettingBlogCategory extends AdminState {}

final class GetBlogCategorySuccess extends AdminState {
  final List<BlogCategoryModel> blogCategories;
  const GetBlogCategorySuccess(
    this.blogCategories,
  );

  @override
  List<Object> get props => [
        blogCategories,
      ];
}

final class DeletingBlogCategoryFailed extends AdminState {
  final String message;
  const DeletingBlogCategoryFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class DeletingBlogCategory extends AdminState {
  final String blogCategoryId;
  const DeletingBlogCategory(
    this.blogCategoryId,
  );

  @override
  List<Object> get props => [
        blogCategoryId,
      ];
}

final class DeletingBlogCategorySuccess extends AdminState {
  final String blogCategoryId;
  const DeletingBlogCategorySuccess(
    this.blogCategoryId,
  );

  @override
  List<Object> get props => [
        blogCategoryId,
      ];
}

final class CreateBlogFailed extends AdminState {
  final String message;
  const CreateBlogFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class CreatingBlog extends AdminState {}

final class CreateBlogSuccess extends AdminState {
  final BlogModel blog;
  const CreateBlogSuccess(
    this.blog,
  );

  @override
  List<Object> get props => [
        blog,
      ];
}

final class UpdateBlogFailed extends AdminState {
  final String message;
  const UpdateBlogFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class UpdatingBlog extends AdminState {}

final class UpdateBlogSuccess extends AdminState {
  final BlogModel blog;
  const UpdateBlogSuccess(
    this.blog,
  );

  @override
  List<Object> get props => [
        blog,
      ];
}

final class GetBlogFailed extends AdminState {
  final String message;
  const GetBlogFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GettingBlog extends AdminState {}

final class GetBlogSuccess extends AdminState {
  final List<BlogModel> blogs;
  const GetBlogSuccess(
    this.blogs,
  );

  @override
  List<Object> get props => [
        blogs,
      ];
}

final class DeletingBlogFailed extends AdminState {
  final String message;
  const DeletingBlogFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class DeletingBlog extends AdminState {
  final String blogId;
  const DeletingBlog(
    this.blogId,
  );

  @override
  List<Object> get props => [
        blogId,
      ];
}

final class DeletingBlogSuccess extends AdminState {
  final String blogId;
  const DeletingBlogSuccess(
    this.blogId,
  );

  @override
  List<Object> get props => [
        blogId,
      ];
}

final class CreateJournalCategoryFailed extends AdminState {
  final String message;
  const CreateJournalCategoryFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class CreatingJournalCategory extends AdminState {}

final class CreateJournalCategorySuccess extends AdminState {
  final JournalCategoryModel journalCategory;
  const CreateJournalCategorySuccess(
    this.journalCategory,
  );

  @override
  List<Object> get props => [
        journalCategory,
      ];
}

final class UpdateJournalCategoryFailed extends AdminState {
  final String message;
  const UpdateJournalCategoryFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class UpdatingJournalCategory extends AdminState {}

final class UpdateJournalCategorySuccess extends AdminState {
  final JournalCategoryModel journalCategory;
  const UpdateJournalCategorySuccess(
    this.journalCategory,
  );

  @override
  List<Object> get props => [
        journalCategory,
      ];
}

final class GetJournalCategoryFailed extends AdminState {
  final String message;
  const GetJournalCategoryFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GettingJournalCategory extends AdminState {}

final class GetJournalCategorySuccess extends AdminState {
  final List<JournalCategoryModel> journalCategories;
  const GetJournalCategorySuccess(
    this.journalCategories,
  );

  @override
  List<Object> get props => [
        journalCategories,
      ];
}

final class DeletingJournalCategoryFailed extends AdminState {
  final String message;
  const DeletingJournalCategoryFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class DeletingJournalCategory extends AdminState {
  final String journalCategoryId;
  const DeletingJournalCategory(
    this.journalCategoryId,
  );

  @override
  List<Object> get props => [
        journalCategoryId,
      ];
}

final class DeletingJournalCategorySuccess extends AdminState {
  final String journalCategoryId;
  const DeletingJournalCategorySuccess(
    this.journalCategoryId,
  );

  @override
  List<Object> get props => [
        journalCategoryId,
      ];
}

final class CreateJournalFailed extends AdminState {
  final String message;
  const CreateJournalFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class CreatingJournal extends AdminState {}

final class CreateJournalSuccess extends AdminState {
  final JournalModel journal;
  const CreateJournalSuccess(
    this.journal,
  );

  @override
  List<Object> get props => [
        journal,
      ];
}

final class UpdateJournalFailed extends AdminState {
  final String message;
  const UpdateJournalFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class UpdatingJournal extends AdminState {}

final class UpdateJournalSuccess extends AdminState {
  final JournalModel journal;
  const UpdateJournalSuccess(
    this.journal,
  );

  @override
  List<Object> get props => [
        journal,
      ];
}

final class GetJournalFailed extends AdminState {
  final String message;
  const GetJournalFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GettingJournal extends AdminState {}

final class GetJournalSuccess extends AdminState {
  final List<JournalModel> journals;
  const GetJournalSuccess(
    this.journals,
  );

  @override
  List<Object> get props => [
        journals,
      ];
}

final class DeletingJournalFailed extends AdminState {
  final String message;
  const DeletingJournalFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class DeletingJournal extends AdminState {
  final String journalId;
  const DeletingJournal(
    this.journalId,
  );

  @override
  List<Object> get props => [
        journalId,
      ];
}

final class DeletingJournalSuccess extends AdminState {
  final String journalId;
  const DeletingJournalSuccess(
    this.journalId,
  );

  @override
  List<Object> get props => [
        journalId,
      ];
}

final class CreateDeclarationCategoryFailed extends AdminState {
  final String message;
  const CreateDeclarationCategoryFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class CreatingDeclarationCategory extends AdminState {}

final class CreateDeclarationCategorySuccess extends AdminState {
  final DeclarationCategoryModel declarationCategory;
  const CreateDeclarationCategorySuccess(
    this.declarationCategory,
  );

  @override
  List<Object> get props => [
        declarationCategory,
      ];
}

final class UpdateDeclarationCategoryFailed extends AdminState {
  final String message;
  const UpdateDeclarationCategoryFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class UpdatingDeclarationCategory extends AdminState {}

final class UpdateDeclarationCategorySuccess extends AdminState {
  final DeclarationCategoryModel declarationCategory;
  const UpdateDeclarationCategorySuccess(
    this.declarationCategory,
  );

  @override
  List<Object> get props => [
        declarationCategory,
      ];
}

final class GetDeclarationCategoryFailed extends AdminState {
  final String message;
  const GetDeclarationCategoryFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GettingDeclarationCategory extends AdminState {}

final class GetDeclarationCategorySuccess extends AdminState {
  final List<DeclarationCategoryModel> declarationCategories;
  const GetDeclarationCategorySuccess(
    this.declarationCategories,
  );

  @override
  List<Object> get props => [
        declarationCategories,
      ];
}

final class DeletingDeclarationCategoryFailed extends AdminState {
  final String message;
  const DeletingDeclarationCategoryFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class DeletingDeclarationCategory extends AdminState {
  final String declarationCategoryId;
  const DeletingDeclarationCategory(
    this.declarationCategoryId,
  );

  @override
  List<Object> get props => [
        declarationCategoryId,
      ];
}

final class DeletingDeclarationCategorySuccess extends AdminState {
  final String declarationCategoryId;
  const DeletingDeclarationCategorySuccess(
    this.declarationCategoryId,
  );

  @override
  List<Object> get props => [
        declarationCategoryId,
      ];
}

final class CreateDeclarationFailed extends AdminState {
  final String message;
  const CreateDeclarationFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class CreatingDeclaration extends AdminState {}

final class CreateDeclarationSuccess extends AdminState {
  final DeclarationModel declaration;
  const CreateDeclarationSuccess(
    this.declaration,
  );

  @override
  List<Object> get props => [
        declaration,
      ];
}

final class UpdateDeclarationFailed extends AdminState {
  final String message;
  const UpdateDeclarationFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class UpdatingDeclaration extends AdminState {}

final class UpdateDeclarationSuccess extends AdminState {
  final DeclarationModel declaration;
  const UpdateDeclarationSuccess(
    this.declaration,
  );

  @override
  List<Object> get props => [
        declaration,
      ];
}

final class GetDeclarationFailed extends AdminState {
  final String message;
  const GetDeclarationFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GettingDeclaration extends AdminState {}

final class GetDeclarationSuccess extends AdminState {
  final List<DeclarationModel> declarations;
  const GetDeclarationSuccess(
    this.declarations,
  );

  @override
  List<Object> get props => [
        declarations,
      ];
}

final class DeletingDeclarationFailed extends AdminState {
  final String message;
  const DeletingDeclarationFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class DeletingDeclaration extends AdminState {
  final String declarationId;
  const DeletingDeclaration(
    this.declarationId,
  );

  @override
  List<Object> get props => [
        declarationId,
      ];
}

final class DeletingDeclarationSuccess extends AdminState {
  final String declarationId;
  const DeletingDeclarationSuccess(
    this.declarationId,
  );

  @override
  List<Object> get props => [
        declarationId,
      ];
}

final class CreateFAQsCategoryFailed extends AdminState {
  final String message;
  const CreateFAQsCategoryFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class CreatingFAQsCategory extends AdminState {}

final class CreateFAQsCategorySuccess extends AdminState {
  final FAQsCategoryModel faqsCategory;
  const CreateFAQsCategorySuccess(
    this.faqsCategory,
  );

  @override
  List<Object> get props => [
        faqsCategory,
      ];
}

final class UpdateFAQsCategoryFailed extends AdminState {
  final String message;
  const UpdateFAQsCategoryFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class UpdatingFAQsCategory extends AdminState {}

final class UpdateFAQsCategorySuccess extends AdminState {
  final FAQsCategoryModel faqsCategory;
  const UpdateFAQsCategorySuccess(
    this.faqsCategory,
  );

  @override
  List<Object> get props => [
        faqsCategory,
      ];
}

final class GetFAQsCategoryFailed extends AdminState {
  final String message;
  const GetFAQsCategoryFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GettingFAQsCategory extends AdminState {}

final class GetFAQsCategorySuccess extends AdminState {
  final List<FAQsCategoryModel> faqsCategories;
  const GetFAQsCategorySuccess(
    this.faqsCategories,
  );

  @override
  List<Object> get props => [
        faqsCategories,
      ];
}

final class DeletingFAQsCategoryFailed extends AdminState {
  final String message;
  const DeletingFAQsCategoryFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class DeletingFAQsCategory extends AdminState {
  final String faqsCategoryId;
  const DeletingFAQsCategory(
    this.faqsCategoryId,
  );

  @override
  List<Object> get props => [
        faqsCategoryId,
      ];
}

final class DeletingFAQsCategorySuccess extends AdminState {
  final String faqsCategoryId;
  const DeletingFAQsCategorySuccess(
    this.faqsCategoryId,
  );

  @override
  List<Object> get props => [
        faqsCategoryId,
      ];
}

final class CreateFAQsFailed extends AdminState {
  final String message;
  const CreateFAQsFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class CreatingFAQs extends AdminState {}

final class CreateFAQsSuccess extends AdminState {
  final FAQsModel faqs;
  const CreateFAQsSuccess(
    this.faqs,
  );

  @override
  List<Object> get props => [
        faqs,
      ];
}

final class UpdateFAQsFailed extends AdminState {
  final String message;
  const UpdateFAQsFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class UpdatingFAQs extends AdminState {}

final class UpdateFAQsSuccess extends AdminState {
  final FAQsModel faqs;
  const UpdateFAQsSuccess(
    this.faqs,
  );

  @override
  List<Object> get props => [
        faqs,
      ];
}

final class GetFAQsFailed extends AdminState {
  final String message;
  const GetFAQsFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class GettingFAQs extends AdminState {}

final class GetFAQsSuccess extends AdminState {
  final List<FAQsModel> faqss;
  const GetFAQsSuccess(
    this.faqss,
  );

  @override
  List<Object> get props => [
        faqss,
      ];
}

final class DeletingFAQsFailed extends AdminState {
  final String message;
  const DeletingFAQsFailed(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}

final class DeletingFAQs extends AdminState {
  final String faqsId;
  const DeletingFAQs(
    this.faqsId,
  );

  @override
  List<Object> get props => [
        faqsId,
      ];
}

final class DeletingFAQsSuccess extends AdminState {
  final String faqsId;
  const DeletingFAQsSuccess(
    this.faqsId,
  );

  @override
  List<Object> get props => [
        faqsId,
      ];
}
