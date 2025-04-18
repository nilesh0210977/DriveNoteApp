import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drive_note_app/features/auth/presentation/screens/login_screen.dart';
import 'package:drive_note_app/features/auth/domain/providers/auth_provider.dart';
import 'package:drive_note_app/features/notes/presentation/screens/notes_list_screen.dart';
import 'package:drive_note_app/features/notes/presentation/screens/note_detail_screen.dart';
import 'package:drive_note_app/features/notes/presentation/screens/note_edit_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isAuthenticated = authState.maybeWhen(
        authenticated: () => true,
        orElse: () => false,
      );

      // If the user is not logged in, redirect to login
      if (!isAuthenticated && state.uri.path != '/login') {
        return '/login';
      }

      // If the user is logged in and on login screen, redirect to home
      if (isAuthenticated && state.uri.path == '/login') {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const NotesListScreen(),
      ),
      GoRoute(
        path: '/note/new',
        builder: (context, state) => const NoteEditScreen(),
      ),
      GoRoute(
        path: '/note/:id',
        builder: (context, state) {
          final noteId = state.pathParameters['id']!;
          return NoteDetailScreen(noteId: noteId);
        },
      ),
      GoRoute(
        path: '/note/:id/edit',
        builder: (context, state) {
          final noteId = state.pathParameters['id']!;
          return NoteEditScreen(noteId: noteId);
        },
      ),
    ],
  );
});
