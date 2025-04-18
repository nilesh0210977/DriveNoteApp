import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drive_note_app/features/notes/data/repositories/drive_repository.dart';
import 'package:drive_note_app/features/notes/domain/models/note_model.dart';
import 'package:drive_note_app/features/auth/domain/providers/auth_provider.dart';
import 'package:drive_note_app/core/errors/app_errors.dart';
import 'package:flutter/foundation.dart';

final driveRepositoryProvider = Provider<DriveRepository>((ref) {
  return DriveRepository();
});

final notesProvider = AsyncNotifierProvider<NotesNotifier, List<Note>>(() {
  return NotesNotifier();
});

class NotesNotifier extends AsyncNotifier<List<Note>> {
  @override
  Future<List<Note>> build() async {
    final authState = ref.watch(authProvider);

    if (authState is AuthenticatedAuthState) {
      try {
        debugPrint('Building notes provider with authenticated state');

        // Initialize the repository and fetch notes in the main thread
        final driveRepository = ref.read(driveRepositoryProvider);
        final notes = await driveRepository.fetchNotes();

        debugPrint('Successfully loaded ${notes.length} notes');
        return notes;
      } catch (e) {
        debugPrint('Error building notes provider: $e');
        throw DriveError('Failed to load notes: ${e.toString()}');
      }
    } else {
      debugPrint('Building notes provider with unauthenticated state');
      return [];
    }
  }

  Future<void> refreshNotes() async {
    debugPrint('Refreshing notes...');
    state = const AsyncValue.loading();

    try {
      final authState = ref.read(authProvider);

      if (authState is AuthenticatedAuthState) {
        final driveRepository = ref.read(driveRepositoryProvider);
        final notes = await driveRepository.fetchNotes();
        debugPrint('Successfully refreshed ${notes.length} notes');
        state = AsyncValue.data(notes);
      } else {
        state = AsyncValue.data([]);
      }
    } catch (e) {
      debugPrint('Error refreshing notes: $e');
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> createNote(String title, String content) async {
    debugPrint('Creating new note: $title');
    state = const AsyncValue.loading();

    try {
      final driveRepository = ref.read(driveRepositoryProvider);
      final newNote = await driveRepository.createNote(title, content);
      final currentNotes = state.valueOrNull ?? [];
      state = AsyncValue.data([...currentNotes, newNote]);
      debugPrint('Successfully created note: ${newNote.id}');
    } catch (e) {
      debugPrint('Error creating note: $e');
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateNote(Note note) async {
    debugPrint('Updating note: ${note.id}');
    state = const AsyncValue.loading();

    try {
      final driveRepository = ref.read(driveRepositoryProvider);
      final updatedNote = await driveRepository.updateNote(note);
      final currentNotes = state.valueOrNull ?? [];
      state = AsyncValue.data(
        currentNotes.map((n) => n.id == note.id ? updatedNote : n).toList(),
      );
      debugPrint('Successfully updated note: ${note.id}');
    } catch (e) {
      debugPrint('Error updating note: $e');
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> deleteNote(Note note) async {
    debugPrint('Deleting note: ${note.id}');
    state = const AsyncValue.loading();

    try {
      final driveRepository = ref.read(driveRepositoryProvider);
      await driveRepository.deleteNote(note.driveFileId!);
      final currentNotes = state.value!;
      state = AsyncValue.data(
        currentNotes.where((n) => n.id != note.id).toList(),
      );
      debugPrint('Successfully deleted note: ${note.id}');
    } catch (e) {
      debugPrint('Error deleting note: $e');
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final noteProvider = Provider.family<Note?, String>((ref, id) {
  final notesState = ref.watch(notesProvider);
  return notesState.whenOrNull(
    data: (notes) {
      try {
        return notes.firstWhere((note) => note.id == id);
      } catch (_) {
        return null;
      }
    },
  );
});
