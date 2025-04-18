import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drive_note_app/features/auth/domain/providers/auth_provider.dart';
import 'package:drive_note_app/features/notes/domain/providers/note_provider.dart';
import 'package:drive_note_app/features/notes/domain/models/note_model.dart';
import 'package:drive_note_app/core/theme/app_theme.dart';
import 'package:drive_note_app/features/notes/presentation/widgets/note_card.dart';
import 'package:drive_note_app/features/notes/presentation/widgets/error_view.dart';

class NotesListScreen extends ConsumerWidget {
  const NotesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesAsync = ref.watch(notesProvider);
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DriveNotes'),
        actions: [
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () => ref.read(themeModeProvider.notifier).toggleTheme(),
            tooltip: 'Toggle theme',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(notesProvider.notifier).refreshNotes(),
            tooltip: 'Refresh notes',
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('Sign out'),
                onTap: () => ref.read(authProvider.notifier).signOut(),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(notesProvider.notifier).refreshNotes(),
        child: notesAsync.when(
          data: (notes) {
            if (notes.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.note_add,
                      size: 64,
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    const Text('No notes yet. Create your first note!'),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return NoteCard(
                  note: note,
                  onTap: () => context.go('/note/${note.id}'),
                  onLongPress: () => _showDeleteDialog(context, ref, note),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ErrorView(
            message: 'Failed to load notes: $error',
            onRetry: () => ref.read(notesProvider.notifier).refreshNotes(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/note/new'),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref, Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note'),
        content: Text('Are you sure you want to delete "${note.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await ref.read(notesProvider.notifier).deleteNote(note);
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              } catch (e) {
                if (context.mounted) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to delete note: ${e.toString()}'),
                      action: SnackBarAction(
                        label: 'Retry',
                        onPressed: () => _showDeleteDialog(context, ref, note),
                      ),
                    ),
                  );
                }
              }
            },
            child: const Text('DELETE'),
          ),
        ],
      ),
    );
  }
}
