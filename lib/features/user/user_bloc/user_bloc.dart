import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mind_labify/models/app_user.dart';
import 'package:mind_labify/models/journal_model.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  // double breathworkProgress = 0.0;
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
    on<AddFavouriteDeclaration>(
      (
        event,
        emit,
      ) async {
        emit(
          FavouriteDeclarationAdding(),
        );
        try {
          final declarationDoc = FirebaseFirestore.instance
              .collection('declaration')
              .doc(event.declarationId);
          final docSnapshot = await declarationDoc.get();
          final data = docSnapshot.data()!;
          final List<String> favorites =
              List<String>.from(data['isFavorite'] ?? []);

          if (favorites.contains(event.userId)) {
            favorites.remove(event.userId);
          } else {
            favorites.add(event.userId);
          }

          await declarationDoc.update(
            {
              'isFavorite': favorites,
            },
          );
          emit(
            FavouriteDeclarationAdded(),
          );
        } on FirebaseException catch (e) {
          emit(
            FavouriteDeclarationAddedFailed(
              e.message ?? '',
            ),
          );
        } catch (e) {
          log(
            e.toString(),
          );
          emit(
            FavouriteDeclarationAddedFailed(
              e.toString(),
            ),
          );
        }
      },
    );
    on<LoadBreathworkWatchedVideo>(
      (
        event,
        emit,
      ) async {
        emit(
          BreathworkWatchedVideoLoading(),
        );
        try {
          String userId = FirebaseAuth.instance.currentUser!.uid;
          DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();
          if (!userDoc.exists) {
            emit(
              const BreathworkWatchedVideoLoadingError(
                  message: "User data not found"),
            );
            return;
          }

          AppUser user =
              AppUser.fromMap(userDoc.data() as Map<String, dynamic>);

          // Calculate the start of the current week (Monday at 00:00)
          DateTime now = DateTime.now();
          DateTime mondayThisWeek = DateTime(
            now.year,
            now.month,
            now.day - (now.weekday - 1), // Monday of this week
            0,
            0,
            0,
          ).toUtc();

          // Check if the stored weekStartDate is null or if it is before the start of this week
          if (user.weekStartDate == null ||
              user.weekStartDate!.isBefore(mondayThisWeek)) {
            // If the week has changed, reset the watched videos list
            user = AppUser(
              uid: user.uid,
              name: user.name,
              age: user.age,
              gender: user.gender,
              mood: user.mood,
              breathworkWatchedVideos: [],
              meditationWatchedVideos: [],
              writtenJournals: [],
              weekStartDate: mondayThisWeek,
              email: user.email,
              phoneNumber: user.phoneNumber,
              userType: user.userType,
            );

            // Update the user's data in Firestore
            await FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .update(user.toMap());
          }

          double progress = user.breathworkWatchedVideos!.length / 5.0;
          emit(
            BreathworkWatchedVideoLoaded(
              user,
              progress,
            ),
          );
        } catch (e) {
          emit(
            BreathworkWatchedVideoLoadingError(
              message: e.toString(),
            ),
          );
        }
      },
    );
    on<BreathWorkVideoWatched>(
      (
        event,
        emit,
      ) async {
        emit(
          BreathworkWatchedVideoLoading(),
        );
        try {
          String userId = FirebaseAuth.instance.currentUser!.uid;
          DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();
          if (!userDoc.exists) {
            emit(
              const BreathworkWatchedVideoLoadingError(
                  message: "User data not found"),
            );
            return;
          }
          AppUser user =
              AppUser.fromMap(userDoc.data() as Map<String, dynamic>);
          // Avoid duplicate video watch counting
          if (!user.breathworkWatchedVideos!.contains(event.videoId)) {
            user.breathworkWatchedVideos!.add(event.videoId);

            // Update user data in Firestore
            await FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .update(
                  user.toMap(),
                );
            // breathworkProgress = user.breathworkWatchedVideos!.length / 5.0;
            double progress = user.breathworkWatchedVideos!.length / 5.0;
            emit(
              BreathworkWatchedVideoLoaded(user, progress),
            );
          } else {
            // If the video has already been watched, re-emit the current state
            emit(
              BreathworkWatchedVideoLoaded(
                user,
                user.breathworkWatchedVideos!.length / 5.0,
              ),
            );
          }
        } catch (e) {
          emit(
            BreathworkWatchedVideoLoadingError(
              message: e.toString(),
            ),
          );
        }
      },
    );
    on<MeditationVideoWatched>(
      (
        event,
        emit,
      ) async {
        emit(
          MeditationWatchedVideoLoading(),
        );
        try {
          String userId = FirebaseAuth.instance.currentUser!.uid;
          DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();
          if (!userDoc.exists) {
            emit(
              const MeditationWatchedVideoLoadingError(
                  message: "User data not found"),
            );
            return;
          }
          AppUser user =
              AppUser.fromMap(userDoc.data() as Map<String, dynamic>);
          // Avoid duplicate video watch counting
          if (!user.meditationWatchedVideos!.contains(event.videoId)) {
            user.meditationWatchedVideos!.add(event.videoId);

            // Update user data in Firestore
            await FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .update(
                  user.toMap(),
                );
            // breathworkProgress = user.breathworkWatchedVideos!.length / 5.0;
            double progress = user.meditationWatchedVideos!.length / 5.0;
            emit(
              MeditationWatchedVideoLoaded(user, progress),
            );
          } else {
            // If the video has already been watched, re-emit the current state
            emit(
              MeditationWatchedVideoLoaded(
                user,
                user.meditationWatchedVideos!.length / 5.0,
              ),
            );
          }
        } catch (e) {
          emit(
            MeditationWatchedVideoLoadingError(
              message: e.toString(),
            ),
          );
        }
      },
    );
    on<WriteJournal>(
      (
        event,
        emit,
      ) async {
        emit(
          WriteJournalLoading(),
        );
        try {
          String userId = FirebaseAuth.instance.currentUser!.uid;
          DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();
          if (!userDoc.exists) {
            emit(
              const WriteJournalLoadingError(message: "User data not found"),
            );
            return;
          }
          AppUser user =
              AppUser.fromMap(userDoc.data() as Map<String, dynamic>);
          // Avoid duplicate video watch counting
          if (!user.writtenJournals!.contains(event.journalId)) {
            user.writtenJournals!.add(event.journalId);

            // Update user data in Firestore
            await FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .update(
                  user.toMap(),
                );
            // breathworkProgress = user.breathworkWatchedVideos!.length / 5.0;
            double progress = user.writtenJournals!.length / 3.0;
            emit(
              WriteJournalLoaded(user, progress),
            );
          } else {
            // If the video has already been watched, re-emit the current state
            emit(
              WriteJournalLoaded(
                user,
                user.writtenJournals!.length / 3.0,
              ),
            );
          }
        } catch (e) {
          emit(
            WriteJournalLoadingError(
              message: e.toString(),
            ),
          );
        }
      },
    );
  }
}
