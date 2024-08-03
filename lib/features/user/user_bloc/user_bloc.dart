import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mind_labify/models/journal_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<GenderEvent>(
      (
        event,
        emit,
      ) async {
        String userId = FirebaseAuth.instance.currentUser!.uid;
        emit(
          GenderLoading(),
        );
        try {
          await FirebaseFirestore.instance
              .collection(
                'users',
              )
              .doc(
                userId,
              )
              .update(
            {
              'gender': event.gender,
            },
          );
          emit(
            GenderSuccess(),
          );
        } catch (e) {
          if (e is FirebaseAuthException) {
            emit(
              GenderFailed(
                message: e.message ?? '',
              ),
            );
          } else if (e is FirebaseException) {
            emit(
              GenderFailed(
                message: e.message ?? '',
              ),
            );
          } else {
            emit(
              GenderFailed(
                message: e.toString(),
              ),
            );
          }
        }
      },
    );
    on<AgeSelect>(
      (
        event,
        emit,
      ) async {
        String userId = FirebaseAuth.instance.currentUser!.uid;
        emit(
          AgeSelecting(),
        );
        try {
          await FirebaseFirestore.instance
              .collection(
                'users',
              )
              .doc(
                userId,
              )
              .update(
            {
              'age': event.age,
            },
          );
          emit(
            AgeSelected(),
          );
        } catch (e) {
          if (e is FirebaseAuthException) {
            emit(
              AgeSelectedFailed(
                message: e.message ?? '',
              ),
            );
          } else if (e is FirebaseException) {
            emit(
              AgeSelectedFailed(
                message: e.message ?? '',
              ),
            );
          } else {
            emit(
              AgeSelectedFailed(
                message: e.toString(),
              ),
            );
          }
        }
      },
    );
    on<SelectMood>(
      (
        event,
        emit,
      ) async {
        String userId = FirebaseAuth.instance.currentUser!.uid;
        emit(
          MoodSelecting(),
        );
        try {
          await FirebaseFirestore.instance
              .collection(
                'users',
              )
              .doc(
                userId,
              )
              .update(
            {
              'mood': event.mood,
            },
          );
          emit(
            MoodSelected(),
          );
        } catch (e) {
          if (e is FirebaseAuthException) {
            emit(
              MoodSelectedFailed(
                message: e.message ?? '',
              ),
            );
          } else if (e is FirebaseException) {
            emit(
              MoodSelectedFailed(
                message: e.message ?? '',
              ),
            );
          } else {
            emit(
              MoodSelectedFailed(
                message: e.toString(),
              ),
            );
          }
        }
      },
    );
    on<SelectStressor>(
      (
        event,
        emit,
      ) async {
        String userId = FirebaseAuth.instance.currentUser!.uid;
        emit(
          SelectingStressor(),
        );
        try {
          await FirebaseFirestore.instance
              .collection(
                'users',
              )
              .doc(
                userId,
              )
              .update(
            {
              'stressorsName': event.stressorsName,
            },
          );
          emit(
            StressorSelected(),
          );
        } catch (e) {
          if (e is FirebaseAuthException) {
            emit(
              StressorSelectedFailed(
                message: e.message ?? '',
              ),
            );
          } else if (e is FirebaseException) {
            emit(
              StressorSelectedFailed(
                message: e.message ?? '',
              ),
            );
          } else {
            emit(
              StressorSelectedFailed(
                message: e.toString(),
              ),
            );
          }
        }
      },
    );
    on<UpdateJournalAnswer>(
      (
        event,
        emit,
      ) async {
        emit(
          JournalAnswerUpdating(),
        );
        try {
          String userId = FirebaseAuth.instance.currentUser!.uid;
          DocumentReference journalRef = FirebaseFirestore.instance
              .collection('journal')
              .doc(event.journalId);
          DocumentSnapshot journalSnapshot = await journalRef.get();
          if (journalSnapshot.exists) {
            JournalModel journal = JournalModel.fromMap(
                journalSnapshot.data() as Map<String, dynamic>);
            journal.answers![userId] = event.answer;
            await journalRef.update(journal.toMap());
          }
          emit(
            JournalAnswerUpdated(),
          );
        } on FirebaseException catch (e) {
          emit(
            JournalAnswerUpdatedFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            JournalAnswerUpdatedFailed(
              e.toString(),
            ),
          );
        }
      },
    );
  }
}
