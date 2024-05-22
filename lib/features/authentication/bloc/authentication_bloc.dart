import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mind_labify/main.dart';
import 'package:mind_labify/models/app_user.dart';
import 'package:mind_labify/user_provider.dart';
import 'package:mind_labify/utils/enums.dart';
import 'package:provider/provider.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    final UserProvider userProvider =
        navigatorKey.currentContext!.read<UserProvider>();
    on<RegisterEvent>(
      (event, emit) async {
        emit(
          const Registering(),
        );
        try {
          final userCreds =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          await FirebaseFirestore.instance
              .collection('users')
              .doc(
                userCreds.user!.uid,
              )
              .set(
            {
              'name': event.name,
              'email': event.email,
              'phoneNumber': event.phoneNumber,
              'userType': UserType.user.toString(),
            },
          );
          userProvider.setUser(
            AppUser(
              uid: userCreds.user!.uid,
              name: event.name,
              email: event.email,
              phoneNumber: event.phoneNumber,
              userType: UserType.user,
            ),
          );
          emit(
            const Registered(
              UserType.user,
            ),
          );
        } catch (e) {
          if (e is FirebaseAuthException) {
            emit(
              RegisteredFailure(
                message: e.message ?? '',
              ),
            );
          } else if (e is FirebaseException) {
            emit(
              RegisteredFailure(
                message: e.message ?? '',
              ),
            );
          } else {
            emit(
              RegisteredFailure(
                message: e.toString(),
              ),
            );
          }
        }
      },
    );
    on<LoginEvent>(
      (event, emit) async {
        emit(
          const AuthenticationLoading(),
        );
        try {
          final userCreds =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          final userDoc = await FirebaseFirestore.instance
              .collection(
                'users',
              )
              .doc(
                userCreds.user!.uid,
              )
              .get();
          AppUser user = AppUser.fromMap(
            userDoc.data()!,
          );
          user.uid = userCreds.user!.uid;
          userProvider.setUser(
            user,
          );
          emit(
            const AuthenticationSuccess(),
          );
        } catch (e) {
          if (e is FirebaseAuthException) {
            emit(
              AuthenticationFailure(
                message: e.code == 'invalid-login-credentials'
                    ? 'Invalid login credentials'
                    : e.message ?? '',
              ),
            );
          } else if (e is FirebaseException) {
            emit(
              AuthenticationFailure(
                message: e.message ?? '',
              ),
            );
          } else {
            emit(
              AuthenticationFailure(
                message: e.toString(),
              ),
            );
          }
        }
      },
    );
    on<GetUser>(
      (event, emit) async {
        String uuid = FirebaseAuth.instance.currentUser!.uid;
        emit(
          const GetUserState.loading(),
        );
        try {
          final userDoc = await FirebaseFirestore.instance
              .collection(
                'users',
              )
              .doc(
                uuid,
              )
              .get();
          AppUser user = AppUser.fromMap(
            userDoc.data()!,
          );
          user.uid = uuid;
          userProvider.setUser(
            user,
          );
          emit(
            GetUserState.success(
              user,
            ),
          );
        } catch (e) {
          emit(
            const GetUserState.failure(),
          );
          if (e is FirebaseAuthException) {
            emit(
              AuthenticationFailure(
                message: e.message ?? '',
              ),
            );
          } else if (e is FirebaseException) {
            emit(
              AuthenticationFailure(
                message: e.message ?? '',
              ),
            );
          } else {
            emit(
              AuthenticationFailure(
                message: e.toString(),
              ),
            );
          }
        }
      },
    );
    on<ResetPassword>(
      (event, emit) async {
        emit(
          const ResetPasswordLoading(),
        );
        try {
          await FirebaseAuth.instance.sendPasswordResetEmail(
            email: event.email,
          );
          emit(
            const ResetPasswordSuccess(),
          );
        } catch (e) {
          if (e is FirebaseAuthException) {
            emit(
              ResetPasswordFailure(
                message: e.message ?? '',
              ),
            );
          } else if (e is FirebaseException) {
            emit(
              ResetPasswordFailure(
                message: e.message ?? '',
              ),
            );
          } else {
            ResetPasswordFailure(
              message: e.toString(),
            );
          }
        }
      },
    );
  }
}
