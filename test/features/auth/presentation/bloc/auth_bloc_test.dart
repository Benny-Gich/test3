import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test3/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:test3/core/error/failure.dart';
import 'package:test3/core/usecase/usecase.dart';
import 'package:test3/core/entities/profile.dart';
import 'package:test3/features/auth/domain/usecase/current_user.dart';
import 'package:test3/features/auth/domain/usecase/user_login_impl.dart';
import 'package:test3/features/auth/domain/usecase/user_signup_impl.dart';
import 'package:test3/features/auth/presentation/bloc/auth_bloc.dart';

class MockCurrentUser extends Mock implements CurrentUser {}

class MockUserSignUpImpl extends Mock implements UserSignUpImpl {}

class MockUserLoginImpl extends Mock implements UserLoginImpl {}

class MockAppUserCubit extends Mock implements AppUserCubit {}

void main() {
  late MockCurrentUser mockCurrentUser;
  late MockUserSignUpImpl mockUserSignUpImpl;
  late MockUserLoginImpl mockUserLoginImpl;

  setUpAll(() {
    registerFallbackValue(Params());
    registerFallbackValue(
      UserSignUpParams(name: 'n', email: 'e', password: 'p'),
    );
    registerFallbackValue(UserLoginParams(email: 'e', password: 'p'));
  });

  setUp(() {
    mockCurrentUser = MockCurrentUser();
    mockUserSignUpImpl = MockUserSignUpImpl();
    mockUserLoginImpl = MockUserLoginImpl();
  });

  blocTest<AuthBloc, AuthState>(
    'emits [AuthLoading, AuthSuccess] when current user returns profile',
    build: () => AuthBloc(
      currentUser: mockCurrentUser,
      userSignUpImpl: mockUserSignUpImpl,
      userLoginImpl: mockUserLoginImpl,
    ),
    setUp: () {
      final profile = Profile(id: '1', email: 'a@b.com', password: 'secret');
      when(
        () => mockCurrentUser.call(any()),
      ).thenAnswer((_) async => Right(profile));
    },
    act: (bloc) => bloc.add(const AuthIsUserLoggedIn()),
    expect: () => [isA<AuthLoading>(), isA<AuthSuccess>()],
    verify: (_) {
      verify(() => mockCurrentUser.call(any())).called(1);
    },
  );

  blocTest<AuthBloc, AuthState>(
    'emits [AuthLoading, AuthSuccess] when signup returns profile',
    build: () => AuthBloc(
      currentUser: mockCurrentUser,
      userSignUpImpl: mockUserSignUpImpl,
      userLoginImpl: mockUserLoginImpl,
    ),
    setUp: () {
      final profile = Profile(id: '2', email: 'c@d.com', password: 'secret2');
      when(
        () => mockUserSignUpImpl.call(any()),
      ).thenAnswer((_) async => Right(profile));
    },
    act: (bloc) =>
        bloc.add(const AuthSignUp(name: 'n', email: 'e', passWord: 'p')),
    expect: () => [isA<AuthLoading>(), isA<AuthSuccess>()],
    verify: (_) {
      verify(() => mockUserSignUpImpl.call(any())).called(1);
    },
  );

  blocTest<AuthBloc, AuthState>(
    'emits [AuthLoading, AuthFailure] when signup returns failure',
    build: () => AuthBloc(
      currentUser: mockCurrentUser,
      userSignUpImpl: mockUserSignUpImpl,
      userLoginImpl: mockUserLoginImpl,
    ),
    setUp: () {
      final failure = Failure('signup failed');
      when(
        () => mockUserSignUpImpl.call(any()),
      ).thenAnswer((_) async => Left(failure));
    },
    act: (bloc) =>
        bloc.add(const AuthSignUp(name: 'n', email: 'e', passWord: 'p')),
    expect: () => [isA<AuthLoading>(), isA<AuthFailure>()],
    verify: (_) {
      verify(() => mockUserSignUpImpl.call(any())).called(1);
    },
  );

  blocTest<AuthBloc, AuthState>(
    'emits [AuthLoading, AuthSuccess] when login returns profile',
    build: () => AuthBloc(
      currentUser: mockCurrentUser,
      userSignUpImpl: mockUserSignUpImpl,
      userLoginImpl: mockUserLoginImpl,
    ),
    setUp: () {
      final profile = Profile(id: '3', email: 'x@y.com', password: 'pw');
      when(
        () => mockUserLoginImpl.call(any()),
      ).thenAnswer((_) async => Right(profile));
    },
    act: (bloc) => bloc.add(const AuthLogIn(email: 'x@y.com', passWord: 'pw')),
    expect: () => [isA<AuthLoading>(), isA<AuthSuccess>()],
    verify: (_) {
      verify(() => mockUserLoginImpl.call(any())).called(1);
    },
  );

  blocTest<AuthBloc, AuthState>(
    'emits [AuthLoading, AuthFailure] when login returns failure',
    build: () => AuthBloc(
      currentUser: mockCurrentUser,
      userSignUpImpl: mockUserSignUpImpl,
      userLoginImpl: mockUserLoginImpl,
    ),
    setUp: () {
      final failure = Failure('login failed');
      when(
        () => mockUserLoginImpl.call(any()),
      ).thenAnswer((_) async => Left(failure));
    },
    act: (bloc) => bloc.add(const AuthLogIn(email: 'x@y.com', passWord: 'pw')),
    expect: () => [isA<AuthLoading>(), isA<AuthFailure>()],
    verify: (_) {
      verify(() => mockUserLoginImpl.call(any())).called(1);
    },
  );

  blocTest<AuthBloc, AuthState>(
    'emits [AuthLoading, AuthFailure] when current user returns failure',
    build: () => AuthBloc(
      currentUser: mockCurrentUser,
      userSignUpImpl: mockUserSignUpImpl,
      userLoginImpl: mockUserLoginImpl,
    ),
    setUp: () {
      final failure = Failure('no user');
      when(
        () => mockCurrentUser.call(any()),
      ).thenAnswer((_) async => Left(failure));
    },
    act: (bloc) => bloc.add(const AuthIsUserLoggedIn()),
    expect: () => [isA<AuthLoading>(), isA<AuthFailure>()],
    verify: (_) {
      verify(() => mockCurrentUser.call(any())).called(1);
    },
  );
}
