import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mind_labify/models/app_user.dart';
import 'package:mind_labify/models/blog_category_model.dart';
import 'package:mind_labify/models/blog_model.dart';
import 'package:mind_labify/models/breathwork_model.dart';
import 'package:mind_labify/models/breathwork_video.dart';
import 'package:mind_labify/models/journal_category_model.dart';
import 'package:mind_labify/models/meditation_model.dart';
import 'package:mind_labify/models/meditation_video.dart';
import 'package:mind_labify/models/stressor_model.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  List<AppUser> userData = [];
  List<StressorModel> stressors = [];
  List<StressorModel> activeStressors = [];
  List<BreathWorkModel> breathWorks = [];
  List<BreathWorkModel> activeBreathWorks = [];
  List<MeditationModel> meditations = [];
  List<MeditationModel> activeMeditations = [];
  List<BreathworkVideo> breathworkVideos = [];
  List<MeditationVideo> meditationVideos = [];
  List<BlogCategoryModel> blogCategories = [];
  List<BlogCategoryModel> activeBlogCategories = [];
  List<BlogModel> blogs = [];
  List<BlogModel> activeBlogs = [];
  List<JournalCategoryModel> journalCategories = [];
  List<JournalCategoryModel> activeJournalCategories = [];
  AdminBloc() : super(AdminInitial()) {
    on<CreateStressor>(
      (
        event,
        emit,
      ) async {
        emit(
          CreatingStressor(),
        );
        try {
          final ref = FirebaseStorage.instance.ref().child(
                'stressor_icons/${event.iconFile.path.split('/').last}',
              );

          await ref.putData(
            await event.iconFile.readAsBytes(),
          );
          final iconUrl = await ref.getDownloadURL();
          event.stressor.icon = iconUrl;
          final stressorCollection = FirebaseFirestore.instance.collection(
            'stressor',
          );
          final result = await stressorCollection.add(
            event.stressor.toMap(),
          );
          event.stressor.stressorId = result.id;
          stressors.add(
            event.stressor,
          );
          emit(
            CreateStressorSuccess(
              event.stressor,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            CreateStressorFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            CreateStressorFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<GetStressor>(
      (
        event,
        emit,
      ) async {
        emit(
          GettingStressor(),
        );
        try {
          final stressorCollection = FirebaseFirestore.instance.collection(
            'stressor',
          );
          final result = await stressorCollection.get();
          stressors = result.docs.map(
            (e) {
              final stressor = StressorModel.fromMap(
                e.data(),
              );
              stressor.stressorId = e.id;
              return stressor;
            },
          ).toList();
          final document = await stressorCollection
              .where(
                'status',
                isEqualTo: 'Active',
              )
              .get();
          activeStressors = document.docs.map((e) {
            final stressor = StressorModel.fromMap(
              e.data(),
            );
            stressor.stressorId = e.id;
            return stressor;
          }).toList();
          emit(
            GetStressorSuccess(
              stressors,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            GetStressorFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            GetStressorFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<UpdateStressor>(
      (
        event,
        emit,
      ) async {
        emit(
          UpdatingStressor(),
        );
        try {
          if (event.iconFile != null) {
            final ref = FirebaseStorage.instance.ref().child(
                  'stressor_icons/${event.iconFile!.path.split('/').last}',
                );
            await ref.putData(
              await event.iconFile!.readAsBytes(),
            );
            final iconUrl = await ref.getDownloadURL();
            event.stressor.icon = iconUrl;
          }
          final stressorCollection = FirebaseFirestore.instance.collection(
            'stressor',
          );
          await stressorCollection
              .doc(
                event.stressor.stressorId,
              )
              .update(
                event.stressor.toMap(),
              );
          final index = stressors.indexWhere(
            (element) => element.stressorId == event.stressor.stressorId,
          );
          stressors[index] = event.stressor;
          emit(
            UpdateStressorSuccess(
              event.stressor,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            UpdateStressorFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            UpdateStressorFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<DeleteEvent>(
      (
        event,
        emit,
      ) async {
        emit(
          DeletingStressor(
            event.stressorId,
          ),
        );
        try {
          final stressorCollection = FirebaseFirestore.instance.collection(
            'stressor',
          );
          await stressorCollection.doc(event.stressorId).delete();
          stressors.removeWhere(
            (element) => element.stressorId == event.stressorId,
          );
          emit(
            DeletingStressorSuccess(
              event.stressorId,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            DeletingStressorFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            DeletingStressorFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<GetUserData>(
      (
        event,
        emit,
      ) async {
        emit(
          GetUserDataLoading(),
        );
        try {
          final userDataCollection = FirebaseFirestore.instance.collection(
            'users',
          );
          final result = await userDataCollection.get();
          userData = result.docs.map(
            (e) {
              final user = AppUser.fromMap(
                e.data(),
              );
              user.uid = e.id;
              return user;
            },
          ).toList();
          emit(
            GetUserDataSuccess(
              userData,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            GetUserDataFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            GetUserDataFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<CreateBreathWorkCategory>(
      (
        event,
        emit,
      ) async {
        emit(
          CreatingBreathWorkCategory(),
        );
        try {
          final ref = FirebaseStorage.instance.ref().child(
                'breathwork_icons/${event.iconFile.path.split('/').last}',
              );
          await ref.putData(
            await event.iconFile.readAsBytes(),
          );
          final iconUrl = await ref.getDownloadURL();
          event.breathWork.icon = iconUrl;
          final breathworkCollection = FirebaseFirestore.instance.collection(
            'breathwork',
          );
          final result = await breathworkCollection.add(
            event.breathWork.toMap(),
          );
          event.breathWork.breathworkId = result.id;
          breathWorks.add(
            event.breathWork,
          );
          emit(
            CreateBreathWorkCategorySuccess(
              event.breathWork,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            CreateBreathWorkCategoryFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            CreateBreathWorkCategoryFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<GetBreathWorkCategory>(
      (
        event,
        emit,
      ) async {
        GettingBreathWorkCategory();
        try {
          final breathworkCollection = FirebaseFirestore.instance.collection(
            'breathwork',
          );
          final result = await breathworkCollection.get();
          breathWorks = result.docs.map(
            (e) {
              final breathWork = BreathWorkModel.fromMap(
                e.data(),
              );
              breathWork.breathworkId = e.id;
              return breathWork;
            },
          ).toList();
          activeBreathWorks = breathWorks
              .where(
                (element) => element.status == 'Active',
              )
              .toList();
          emit(
            GetBreathWorkCategorySuccess(
              breathWorks,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            GetBreathWorkCategoryFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            GetBreathWorkCategoryFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<UpdateBreathWorkCategory>(
      (
        event,
        emit,
      ) async {
        emit(
          UpdatingBreathWorkCategory(),
        );
        try {
          if (event.iconFile != null) {
            final ref = FirebaseStorage.instance.ref().child(
                  'breathwork_icons/${event.iconFile!.path.split('/').last}',
                );
            await ref.putData(
              await event.iconFile!.readAsBytes(),
            );
            final iconUrl = await ref.getDownloadURL();
            event.breathWork.icon = iconUrl;
          }
          final breathWorkCollection = FirebaseFirestore.instance.collection(
            'breathwork',
          );
          await breathWorkCollection
              .doc(
                event.breathWork.breathworkId,
              )
              .update(
                event.breathWork.toMap(),
              );
          final index = breathWorks.indexWhere(
            (element) => element.breathworkId == event.breathWork.breathworkId,
          );
          breathWorks[index] = event.breathWork;
          emit(
            UpdateBreathWorkCategorySuccess(
              event.breathWork,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            UpdateBreathWorkCategoryFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            UpdateBreathWorkCategoryFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<DeleteBreathWorkCategory>(
      (
        event,
        emit,
      ) async {
        emit(
          DeletingBreathorkCategory(
            event.breathworkId,
          ),
        );
        try {
          final breathworkCollection = FirebaseFirestore.instance.collection(
            'breathwork',
          );
          await breathworkCollection.doc(event.breathworkId).delete();
          breathWorks.removeWhere(
            (element) => element.breathworkId == event.breathworkId,
          );
          emit(
            DeletingBreathorkCategorySuccess(
              event.breathworkId,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            DeletingBreathworkCategoryFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            DeletingBreathworkCategoryFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<CreateMeditationCategory>(
      (
        event,
        emit,
      ) async {
        emit(
          CreatingMeditationCategory(),
        );
        try {
          final ref = FirebaseStorage.instance.ref().child(
                'meditation_icons/${event.iconFile.path.split('/').last}',
              );
          await ref.putData(
            await event.iconFile.readAsBytes(),
          );
          final iconUrl = await ref.getDownloadURL();
          event.meditation.icon = iconUrl;
          final meditationCollection = FirebaseFirestore.instance.collection(
            'meditation',
          );
          final result = await meditationCollection.add(
            event.meditation.toMap(),
          );
          event.meditation.meditationId = result.id;
          meditations.add(
            event.meditation,
          );
          emit(
            CreateMeditationCategorySuccess(
              event.meditation,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            CreateMeditationCategoryFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            CreateMeditationCategoryFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<UpdateMeditationCategory>(
      (
        event,
        emit,
      ) async {
        emit(
          UpdatingMeditationCategory(),
        );
        try {
          if (event.iconFile != null) {
            final ref = FirebaseStorage.instance.ref().child(
                  'meditation_icons/${event.iconFile!.path.split('/').last}',
                );
            await ref.putData(
              await event.iconFile!.readAsBytes(),
            );
            final iconUrl = await ref.getDownloadURL();
            event.meditation.icon = iconUrl;
          }
          final meditationCollection = FirebaseFirestore.instance.collection(
            'meditation',
          );
          await meditationCollection
              .doc(
                event.meditation.meditationId,
              )
              .update(
                event.meditation.toMap(),
              );
          final index = meditations.indexWhere(
            (element) => element.meditationId == event.meditation.meditationId,
          );
          meditations[index] = event.meditation;
          emit(
            UpdateMeditationCategorySuccess(
              event.meditation,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            UpdateMeditationCategoryFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            UpdateMeditationCategoryFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<GetMeditationCategory>(
      (
        event,
        emit,
      ) async {
        emit(
          GettingMeditationCategory(),
        );
        try {
          final meditationCollection = FirebaseFirestore.instance.collection(
            'meditation',
          );
          final result = await meditationCollection.get();
          meditations = result.docs.map(
            (e) {
              final meditation = MeditationModel.fromMap(
                e.data(),
              );
              meditation.meditationId = e.id;
              return meditation;
            },
          ).toList();
          activeMeditations = meditations
              .where(
                (element) => element.status == 'Active',
              )
              .toList();
          emit(
            GetMeditationCategorySuccess(
              meditations,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            GetMeditationCategoryFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            GetMeditationCategoryFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<DeleteMeditationCategory>(
      (
        event,
        emit,
      ) async {
        emit(
          DeletingMeditationCategory(
            event.meditationId,
          ),
        );
        try {
          final meditationCollection = FirebaseFirestore.instance.collection(
            'meditation',
          );
          await meditationCollection.doc(event.meditationId).delete();
          meditations.removeWhere(
            (element) => element.meditationId == event.meditationId,
          );
          emit(
            DeletingMeditationCategorySuccess(
              event.meditationId,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            DeletingMeditationCategoryFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            DeletingMeditationCategoryFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<CreateBreathWorkVideo>(
      (
        event,
        emit,
      ) async {
        emit(
          CreatingBreathWorkVideo(),
        );
        try {
          final ref = FirebaseStorage.instance.ref().child(
                'breathwork_video_icons/${event.videoIconFile.path.split('/').last}',
              );
          await ref.putData(
            await event.videoIconFile.readAsBytes(),
          );
          final iconUrl = await ref.getDownloadURL();
          event.breathWorkVideo.videoIcon = iconUrl;

          // final videoRef = FirebaseStorage.instance.ref().child(
          //       'breathwork_videos/${event.video.path.split('/').last}',
          //     );
          // await videoRef.putData(
          //   await event.video.readAsBytes(),
          // );
          // final videoUrl = await videoRef.getDownloadURL();
          // event.breathWorkVideo.video = videoUrl;
          final breathworkVideoCollection =
              FirebaseFirestore.instance.collection(
            'breathwork_videos',
          );
          final result = await breathworkVideoCollection.add(
            event.breathWorkVideo.toMap(),
          );
          event.breathWorkVideo.videoId = result.id;
          breathworkVideos.add(
            event.breathWorkVideo,
          );
          emit(
            CreateBreathWorkVideoSuccess(
              event.breathWorkVideo,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            CreateBreathWorkVideoFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            CreateBreathWorkVideoFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<UpdateBreathWorkVideo>(
      (
        event,
        emit,
      ) async {
        emit(
          UpdatingBreathWorkVideo(),
        );
        try {
          if (event.videoIconFile != null) {
            final ref = FirebaseStorage.instance.ref().child(
                  'breathwork_video_icons/${event.videoIconFile!.path.split('/').last}',
                );
            await ref.putData(
              await event.videoIconFile!.readAsBytes(),
            );
            final iconUrl = await ref.getDownloadURL();
            event.breathWorkVideo.videoIcon = iconUrl;
          }
          // if (event.video != null) {
          //   final videoRef = FirebaseStorage.instance.ref().child(
          //         'breathwork_videos/${event.video!.path.split('/').last}',
          //       );
          //   await videoRef.putData(
          //     await event.video!.readAsBytes(),
          //   );
          //   final videoUrl = await videoRef.getDownloadURL();
          //   event.breathWorkVideo.video = videoUrl;
          // }
          final breathworkVideoCollection =
              FirebaseFirestore.instance.collection(
            'breathwork_videos',
          );
          await breathworkVideoCollection
              .doc(
                event.breathWorkVideo.videoId,
              )
              .update(
                event.breathWorkVideo.toMap(),
              );
          final index = breathworkVideos.indexWhere(
            (element) => element.videoId == event.breathWorkVideo.videoId,
          );
          breathworkVideos[index] = event.breathWorkVideo;
          emit(
            UpdateBreathWorkVideoSuccess(
              event.breathWorkVideo,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            UpdateBreathWorkVideoFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            UpdateBreathWorkVideoFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<GetBreathworkVideo>(
      (
        event,
        emit,
      ) async {
        GettingBreathworkVideo();
        try {
          final breathworkVideosCollection =
              FirebaseFirestore.instance.collection(
            'breathwork_videos',
          );
          final result = await breathworkVideosCollection.get();
          breathworkVideos = result.docs.map(
            (e) {
              final breathworkVideo = BreathworkVideo.fromMap(
                e.data(),
              );
              breathworkVideo.videoId = e.id;
              return breathworkVideo;
            },
          ).toList();
          emit(
            GetBreathworkVideoSuccess(
              breathworkVideos,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            GetBreathworkVideoFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            GetBreathworkVideoFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<DeleteBreathworkVideo>(
      (
        event,
        emit,
      ) async {
        emit(
          DeletingBreathorkVideo(
            event.breathworkVideoId,
          ),
        );
        try {
          final breathworkVideoCollection =
              FirebaseFirestore.instance.collection(
            'breathwork_videos',
          );
          await breathworkVideoCollection.doc(event.breathworkVideoId).delete();
          breathworkVideos.removeWhere(
            (element) => element.videoId == event.breathworkVideoId,
          );
          emit(
            DeletingBreathorkVideoSuccess(
              event.breathworkVideoId,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            DeletingBreathworkVideoFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            DeletingBreathworkVideoFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<UpdateBreathWorkVideoReaction>(
      (
        event,
        emit,
      ) async {
        emit(
          UpdatingBreathworkVideoReaction(),
        );
        try {
          String userId = FirebaseAuth.instance.currentUser!.uid;
          DocumentReference videoRef = FirebaseFirestore.instance
              .collection('breathwork_videos')
              .doc(event.videoId);
          DocumentSnapshot videoSnapshot = await videoRef.get();
          if (videoSnapshot.exists) {
            BreathworkVideo video = BreathworkVideo.fromMap(
                videoSnapshot.data() as Map<String, dynamic>);
            if (video.reactions!.containsKey(userId)) {
              video.reactions![userId]!.add(event.reaction);
            } else {
              video.reactions![userId] = [event.reaction];
            }
            await videoRef.update(
              video.toMap(),
            );
          }
          emit(
            BreathworkVideoReactionUpdated(),
          );
        } on FirebaseException catch (e) {
          emit(
            BreathworkVideoReactionUpdatedFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            BreathworkVideoReactionUpdatedFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<CreateMeditationVideo>(
      (
        event,
        emit,
      ) async {
        emit(
          CreatingMeditationVideo(),
        );
        try {
          final ref = FirebaseStorage.instance.ref().child(
                'meditation_video_icons/${event.videoIconFile.path.split('/').last}',
              );
          await ref.putData(
            await event.videoIconFile.readAsBytes(),
          );
          final iconUrl = await ref.getDownloadURL();
          event.meditationVideo.videoIcon = iconUrl;

          // final videoRef = FirebaseStorage.instance.ref().child(
          //       'meditation_videos/${event.video.path.split('/').last}',
          //     );
          // await videoRef.putData(
          //   await event.video.readAsBytes(),
          // );
          // final videoUrl = await videoRef.getDownloadURL();
          // event.meditationVideo.video = videoUrl;
          final meditationVideoCollection =
              FirebaseFirestore.instance.collection(
            'meditation_videos',
          );
          final result = await meditationVideoCollection.add(
            event.meditationVideo.toMap(),
          );
          event.meditationVideo.videoId = result.id;
          meditationVideos.add(
            event.meditationVideo,
          );
          emit(
            CreateMeditationVideoSuccess(
              event.meditationVideo,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            CreateMeditationVideoFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            CreateMeditationVideoFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<UpdateMeditationVideo>(
      (
        event,
        emit,
      ) async {
        emit(
          UpdatingMeditationVideo(),
        );
        try {
          if (event.videoIconFile != null) {
            final ref = FirebaseStorage.instance.ref().child(
                  'meditation_video_icons/${event.videoIconFile!.path.split('/').last}',
                );
            await ref.putData(
              await event.videoIconFile!.readAsBytes(),
            );
            final iconUrl = await ref.getDownloadURL();
            event.meditationVideo.videoIcon = iconUrl;
          }
          // if (event.video != null) {
          //   final videoRef = FirebaseStorage.instance.ref().child(
          //         'meditation_videos/${event.video!.path.split('/').last}',
          //       );
          //   await videoRef.putData(
          //     await event.video!.readAsBytes(),
          //   );
          //   final videoUrl = await videoRef.getDownloadURL();
          //   event.meditationVideo.video = videoUrl;
          // }
          final meditationVideoCollection =
              FirebaseFirestore.instance.collection(
            'meditation_videos',
          );
          await meditationVideoCollection
              .doc(
                event.meditationVideo.videoId,
              )
              .update(
                event.meditationVideo.toMap(),
              );
          final index = meditationVideos.indexWhere(
            (element) => element.videoId == event.meditationVideo.videoId,
          );
          meditationVideos[index] = event.meditationVideo;
          emit(
            UpdateMeditationVideoSuccess(
              event.meditationVideo,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            UpdateMeditationVideoFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            UpdateMeditationVideoFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<GetMeditationVideo>(
      (
        event,
        emit,
      ) async {
        GettingMeditationVideo();
        try {
          final meditationVideosCollection =
              FirebaseFirestore.instance.collection(
            'meditation_videos',
          );
          final result = await meditationVideosCollection.get();
          meditationVideos = result.docs.map(
            (e) {
              final meditationVideo = MeditationVideo.fromMap(
                e.data(),
              );
              meditationVideo.videoId = e.id;
              return meditationVideo;
            },
          ).toList();
          emit(
            GetMeditationVideoSuccess(
              meditationVideos,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            GetMeditationVideoFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            GetMeditationVideoFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<DeleteMeditationVideo>(
      (
        event,
        emit,
      ) async {
        emit(
          DeletingMeditationVideo(
            event.meditationVideoId,
          ),
        );
        try {
          final meditationVideoCollection =
              FirebaseFirestore.instance.collection(
            'meditation_videos',
          );
          await meditationVideoCollection.doc(event.meditationVideoId).delete();
          meditationVideos.removeWhere(
            (element) => element.videoId == event.meditationVideoId,
          );
          emit(
            DeletingMeditationVideoSuccess(
              event.meditationVideoId,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            DeletingMeditationVideoFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            DeletingMeditationVideoFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<UpdateMeditationVideoReaction>(
      (
        event,
        emit,
      ) async {
        emit(
          UpdatingMeditationVideoReaction(),
        );
        try {
          String userId = FirebaseAuth.instance.currentUser!.uid;
          DocumentReference videoRef = FirebaseFirestore.instance
              .collection('meditation_videos')
              .doc(event.videoId);
          DocumentSnapshot videoSnapshot = await videoRef.get();
          if (videoSnapshot.exists) {
            MeditationVideo video = MeditationVideo.fromMap(
                videoSnapshot.data() as Map<String, dynamic>);
            if (video.reactions!.containsKey(userId)) {
              video.reactions![userId]!.add(event.reaction);
            } else {
              video.reactions![userId] = [event.reaction];
            }
            await videoRef.update(
              video.toMap(),
            );
          }
          emit(
            MeditationVideoReactionUpdated(),
          );
        } on FirebaseException catch (e) {
          emit(
            MeditationVideoReactionUpdatedFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            MeditationVideoReactionUpdatedFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<CreateBlogCategory>(
      (
        event,
        emit,
      ) async {
        emit(
          CreatingBlogCategory(),
        );
        try {
          final ref = FirebaseStorage.instance.ref().child(
                'blog_category_icons/${event.iconFile.path.split('/').last}',
              );
          await ref.putData(
            await event.iconFile.readAsBytes(),
          );
          final iconUrl = await ref.getDownloadURL();
          event.blogCategory.icon = iconUrl;
          final blogCategoryCollection = FirebaseFirestore.instance.collection(
            'blog_category',
          );
          final result = await blogCategoryCollection.add(
            event.blogCategory.toMap(),
          );
          event.blogCategory.blogCategoryId = result.id;
          blogCategories.add(
            event.blogCategory,
          );
          emit(
            CreateBlogCategorySuccess(
              event.blogCategory,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            CreateBlogCategoryFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            CreateBlogCategoryFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<GetBlogCategory>(
      (
        event,
        emit,
      ) async {
        GettingBlogCategory();
        try {
          final blogCategoryCollection = FirebaseFirestore.instance.collection(
            'blog_category',
          );
          final result = await blogCategoryCollection.get();
          blogCategories = result.docs.map(
            (e) {
              final blogCategory = BlogCategoryModel.fromMap(
                e.data(),
              );
              blogCategory.blogCategoryId = e.id;
              return blogCategory;
            },
          ).toList();
          activeBlogCategories = blogCategories
              .where(
                (element) => element.status == 'Active',
              )
              .toList();
          emit(
            GetBlogCategorySuccess(
              blogCategories,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            GetBlogCategoryFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            GetBlogCategoryFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<UpdateBlogCategory>(
      (
        event,
        emit,
      ) async {
        emit(
          UpdatingBlogCategory(),
        );
        try {
          if (event.iconFile != null) {
            final ref = FirebaseStorage.instance.ref().child(
                  'blog_category_icons/${event.iconFile!.path.split('/').last}',
                );
            await ref.putData(
              await event.iconFile!.readAsBytes(),
            );
            final iconUrl = await ref.getDownloadURL();
            event.blogCategory.icon = iconUrl;
          }
          final blogCategoryCollection = FirebaseFirestore.instance.collection(
            'blog_category',
          );
          await blogCategoryCollection
              .doc(
                event.blogCategory.blogCategoryId,
              )
              .update(
                event.blogCategory.toMap(),
              );
          final index = blogCategories.indexWhere(
            (element) =>
                element.blogCategoryId == event.blogCategory.blogCategoryId,
          );
          blogCategories[index] = event.blogCategory;
          emit(
            UpdateBlogCategorySuccess(
              event.blogCategory,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            UpdateBlogCategoryFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            UpdateBlogCategoryFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<DeleteBlogCategory>(
      (
        event,
        emit,
      ) async {
        emit(
          DeletingBlogCategory(
            event.blogCategoryId,
          ),
        );
        try {
          final blogCategoryCollection = FirebaseFirestore.instance.collection(
            'blog_category',
          );
          await blogCategoryCollection.doc(event.blogCategoryId).delete();
          blogCategories.removeWhere(
            (element) => element.blogCategoryId == event.blogCategoryId,
          );
          emit(
            DeletingBlogCategorySuccess(
              event.blogCategoryId,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            DeletingBlogCategoryFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            DeletingBlogCategoryFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<CreateBlog>(
      (
        event,
        emit,
      ) async {
        emit(
          CreatingBlog(),
        );
        try {
          final ref = FirebaseStorage.instance.ref().child(
                'blog_images/${event.iconFile.path.split('/').last}',
              );
          await ref.putData(
            await event.iconFile.readAsBytes(),
          );
          final iconUrl = await ref.getDownloadURL();
          event.blog.image = iconUrl;
          final blogCollection = FirebaseFirestore.instance.collection(
            'blogs',
          );
          final result = await blogCollection.add(
            event.blog.toMap(),
          );
          event.blog.blogId = result.id;
          blogs.add(
            event.blog,
          );
          emit(
            CreateBlogSuccess(
              event.blog,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            CreateBlogFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            CreateBlogFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<GetBlog>(
      (
        event,
        emit,
      ) async {
        GettingBlog();
        try {
          final blogCollection = FirebaseFirestore.instance.collection(
            'blogs',
          );
          final result = await blogCollection.get();
          blogs = result.docs.map(
            (e) {
              final blog = BlogModel.fromMap(
                e.data(),
              );
              blog.blogId = e.id;
              return blog;
            },
          ).toList();
          activeBlogs = blogs
              .where(
                (element) => element.status == 'Active',
              )
              .toList();
          emit(
            GetBlogSuccess(
              blogs,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            GetBlogFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            GetBlogFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<UpdateBlog>(
      (
        event,
        emit,
      ) async {
        emit(
          UpdatingBlog(),
        );
        try {
          if (event.iconFile != null) {
            final ref = FirebaseStorage.instance.ref().child(
                  'blog_images/${event.iconFile!.path.split('/').last}',
                );
            await ref.putData(
              await event.iconFile!.readAsBytes(),
            );
            final iconUrl = await ref.getDownloadURL();
            event.blog.image = iconUrl;
          }
          final blogCollection = FirebaseFirestore.instance.collection(
            'blogs',
          );
          await blogCollection
              .doc(
                event.blog.blogId,
              )
              .update(
                event.blog.toMap(),
              );
          final index = blogs.indexWhere(
            (element) => element.blogId == event.blog.blogId,
          );
          blogs[index] = event.blog;
          emit(
            UpdateBlogSuccess(
              event.blog,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            UpdateBlogFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            UpdateBlogFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<DeleteBlog>(
      (
        event,
        emit,
      ) async {
        emit(
          DeletingBlog(
            event.blogId,
          ),
        );
        try {
          final blogCollection = FirebaseFirestore.instance.collection(
            'blogs',
          );
          await blogCollection.doc(event.blogId).delete();
          blogs.removeWhere(
            (element) => element.blogId == event.blogId,
          );
          emit(
            DeletingBlogSuccess(
              event.blogId,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            DeletingBlogFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            DeletingBlogFailed(
              e.toString(),
            ),
          );
        }
      },
    );
     on<CreateJournalCategory>(
      (
        event,
        emit,
      ) async {
        emit(
          CreatingJournalCategory(),
        );
        try {
          final ref = FirebaseStorage.instance.ref().child(
                'journal_category_icons/${event.iconFile.path.split('/').last}',
              );
          await ref.putData(
            await event.iconFile.readAsBytes(),
          );
          final iconUrl = await ref.getDownloadURL();
          event.journalCategory.icon = iconUrl;
          final journalCategoryCollection = FirebaseFirestore.instance.collection(
            'journal_category',
          );
          final result = await journalCategoryCollection.add(
            event.journalCategory.toMap(),
          );
          event.journalCategory.journalCategoryId = result.id;
          journalCategories.add(
            event.journalCategory,
          );
          emit(
            CreateJournalCategorySuccess(
              event.journalCategory,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            CreateJournalCategoryFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            CreateJournalCategoryFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<GetJournalCategory>(
      (
        event,
        emit,
      ) async {
        GettingJournalCategory();
        try {
          final journalCategoryCollection = FirebaseFirestore.instance.collection(
            'journal_category',
          );
          final result = await journalCategoryCollection.get();
          journalCategories = result.docs.map(
            (e) {
              final journalCategory = JournalCategoryModel.fromMap(
                e.data(),
              );
              journalCategory.journalCategoryId = e.id;
              return journalCategory;
            },
          ).toList();
          activeJournalCategories = journalCategories
              .where(
                (element) => element.status == 'Active',
              )
              .toList();
          emit(
            GetJournalCategorySuccess(
              journalCategories,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            GetJournalCategoryFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            GetJournalCategoryFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<UpdateJournalCategory>(
      (
        event,
        emit,
      ) async {
        emit(
          UpdatingJournalCategory(),
        );
        try {
          if (event.iconFile != null) {
            final ref = FirebaseStorage.instance.ref().child(
                  'journal_category_icons/${event.iconFile!.path.split('/').last}',
                );
            await ref.putData(
              await event.iconFile!.readAsBytes(),
            );
            final iconUrl = await ref.getDownloadURL();
            event.journalCategory.icon = iconUrl;
          }
          final journalCategoryCollection = FirebaseFirestore.instance.collection(
            'journal_category',
          );
          await journalCategoryCollection
              .doc(
                event.journalCategory.journalCategoryId,
              )
              .update(
                event.journalCategory.toMap(),
              );
          final index = journalCategories.indexWhere(
            (element) =>
                element.journalCategoryId == event.journalCategory.journalCategoryId,
          );
          journalCategories[index] = event.journalCategory;
          emit(
            UpdateJournalCategorySuccess(
              event.journalCategory,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            UpdateJournalCategoryFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            UpdateJournalCategoryFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<DeleteJournalCategory>(
      (
        event,
        emit,
      ) async {
        emit(
          DeletingJournalCategory(
            event.journalCategoryId,
          ),
        );
        try {
          final journalCategoryCollection = FirebaseFirestore.instance.collection(
            'journal_category',
          );
          await journalCategoryCollection.doc(event.journalCategoryId).delete();
          journalCategories.removeWhere(
            (element) => element.journalCategoryId == event.journalCategoryId,
          );
          emit(
            DeletingJournalCategorySuccess(
              event.journalCategoryId,
            ),
          );
        } on FirebaseException catch (e) {
          emit(
            DeletingJournalCategoryFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            DeletingJournalCategoryFailed(
              e.toString(),
            ),
          );
        }
      },
    );
  }
}
