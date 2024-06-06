import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mind_labify/models/app_user.dart';
import 'package:mind_labify/models/breathwork_model.dart';
import 'package:mind_labify/models/meditation_model.dart';
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
  }
}
