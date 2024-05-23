import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mind_labify/models/stressor_model.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  List<StressorModel> stressors = [];
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
          // await ref.putFile(
          //   event.iconFile.toString() as File
          // );
          await ref.putString(
            event.iconFile,
          );
          final iconUrl = await ref.getDownloadURL();
          event.stressor.icon = iconUrl;
          final eventCollection = FirebaseFirestore.instance.collection(
            'stressor',
          );
          final result = await eventCollection.add(
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
      (event, emit) async {
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
  }
}
