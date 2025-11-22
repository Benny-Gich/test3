import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test3/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:test3/features/auth/data/models/profile_model.dart';
import 'package:test3/core/error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockSession extends Mock implements Session {}

class MockUser extends Mock implements User {}

/// A tiny test subclass that overrides `currentUserSession` and the
/// `queryProfileById` helper so we don't need to mock the supabase query
/// builder chain.
class TestAuthRemoteDataSource extends AuthRemoteDataSourceImpl {
  final Session? _session;
  final Future<List<Map<String, dynamic>>> Function(String id)? _queryFn;

  TestAuthRemoteDataSource({
    required super.supabaseClient,
    Session? session,
    Future<List<Map<String, dynamic>>> Function(String id)? queryFn,
  }) : _session = session,
       _queryFn = queryFn;

  @override
  Session? get currentUserSession => _session;

  @override
  Future<List<Map<String, dynamic>>> queryProfileById(String id) async {
    if (_queryFn != null) return await _queryFn(id);
    return super.queryProfileById(id);
  }
}

void main() {
  late MockSupabaseClient mockClient;
  late MockSession mockSession;
  late MockUser mockUser;

  setUp(() {
    mockClient = MockSupabaseClient();
    mockSession = MockSession();
    mockUser = MockUser();
  });

  group('getCurrentUserData', () {
    test(
      'returns ProfileModel when session exists and query returns data',
      () async {
        when(() => mockUser.id).thenReturn('uid');
        when(() => mockSession.user).thenReturn(mockUser);

        final fakeResult = [
          {'id': 'uid', 'email': 'a@b.com', 'password': 'pw'},
        ];

        final ds = TestAuthRemoteDataSource(
          supabaseClient: mockClient,
          session: mockSession,
          queryFn: (id) async => fakeResult,
        );

        final result = await ds.getCurrentUserData();
        expect(result, isA<ProfileModel>());
        expect(result!.email, 'a@b.com');
      },
    );

    test('returns null when there is no current session', () async {
      final ds = TestAuthRemoteDataSource(
        supabaseClient: mockClient,
        session: null,
        queryFn: (_) async => [],
      );

      final result = await ds.getCurrentUserData();
      expect(result, isNull);
    });

    test('throws ServerException when query throws', () async {
      when(() => mockUser.id).thenReturn('uid');
      when(() => mockSession.user).thenReturn(mockUser);

      final ds = TestAuthRemoteDataSource(
        supabaseClient: mockClient,
        session: mockSession,
        queryFn: (id) async => throw Exception('db error'),
      );

      expect(() => ds.getCurrentUserData(), throwsA(isA<ServerException>()));
    });
  });
}
