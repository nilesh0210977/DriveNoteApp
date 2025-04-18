import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:drive_note_app/features/notes/domain/providers/note_provider.dart';
import 'package:drive_note_app/features/notes/domain/models/note_model.dart';
import 'package:drive_note_app/features/notes/presentation/widgets/error_view.dart';
import 'package:intl/intl.dart';

class NoteDetailScreen extends ConsumerWidget {
  final String noteId;

  const NoteDetailScreen({
    super.key,
    required this.noteId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesAsync = ref.watch(notesProvider);

    return notesAsync.when(
      data: (notes) {
        // Try to find the note
        final note = notes.firstWhere(
          (n) => n.id == noteId,
          orElse: () => Note(
              id: '', title: '', content: '', lastModified: DateTime.now()),
        );

        // Handle case when note is not found
        if (note.id.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: const Text('Note not found')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  const Text('The requested note does not exist.'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.go('/'),
                    child: const Text('Go back to notes'),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(note.title),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => context.go('/note/$noteId/edit'),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Last modified: ${DateFormat('MMM d, yyyy h:mm a').format(note.lastModified)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Divider(),
                Expanded(
                  child: Markdown(
                    data: note.content,
                    selectable: true,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: ErrorView(
          message: 'Failed to load note: ${error.toString()}',
          onRetry: () => ref.read(notesProvider.notifier).refreshNotes(),
        ),
      ),
    );
  }
}
