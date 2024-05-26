import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mind_labify/models/app_user.dart';
import 'package:mind_labify/models/stressor_model.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  List<AppUser> userData = [];
  List<StressorModel> stressors = [];
  List<StressorModel> activeStressors = [];
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
          final ref = FirebaseStorage.instance
              .ref()
              .child(
                'stressor_icons',
              )
              .child(
                '${event.stressor.title}',
              );
              
          await ref.putString(
            event.iconFile,
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
          final ref = FirebaseStorage.instance
              .ref()
              .child(
                'stressor_icons',
              )
              .child(
                '${event.stressor.title}',
              );
          await ref.putString(
            event.iconFile,
          );
          final iconUrl = await ref.getDownloadURL();
          event.stressor.icon = iconUrl;
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
  }
}
