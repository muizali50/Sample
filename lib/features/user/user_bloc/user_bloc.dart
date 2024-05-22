import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<GenderEvent>(
      (event, emit) async {
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
      (event, emit) async {
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
  }
}
