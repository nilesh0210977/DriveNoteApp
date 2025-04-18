import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drive_note_app/features/notes/domain/providers/note_provider.dart';
import 'package:drive_note_app/features/notes/domain/models/note_model.dart';

class NoteEditScreen extends ConsumerStatefulWidget {
  final String? noteId; // This should be nullable

  const NoteEditScreen({
    super.key,
    this.noteId, // This should be optional
  });

  @override
  ConsumerState<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends ConsumerState<NoteEditScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool _isLoading = false;
  bool _isNewNote = false; // Add this flag to track if it's a new note
  Note? _originalNote;

  @override
  void initState() {
    super.initState();
    // Set flag based on noteId
    _isNewNote = widget.noteId == null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadNoteData();
    });
  }

  Future<void> _loadNoteData() async {
    if (widget.noteId != null) {
      // Only try to load existing note if we have an ID
      final notesState = ref.read(notesProvider);
      if (notesState.hasValue) {
        final notes = notesState.value!;
        final note = notes.firstWhere(
          (n) => n.id == widget.noteId,
          orElse: () => Note(
              id: '', title: '', content: '', lastModified: DateTime.now()),
        );

        if (note.id.isNotEmpty) {
          setState(() {
            _originalNote = note; // Initialize _originalNote
            _titleController.text = note.title;
            _contentController.text = note.content;
          });
        } else if (mounted) {
          // Note not found but we're trying to edit a specific note
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Note not found')),
          );
          // Navigate back to notes list
          context.go('/');
        }
      }
    }
    // If it's a new note, we don't need to load anything
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  // Fix for the save function - create new note with unique ID
  Future<void> _saveNote() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title cannot be empty')),
      );
      return;
    }

    if (content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Content cannot be empty')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      if (_originalNote != null) {
        // Update existing note
        await ref.read(notesProvider.notifier).updateNote(
              _originalNote!.copyWith(
                title: title,
                content: content,
              ),
            );
      } else {
        // Create new note - no need to provide ID, let the repository handle it
        await ref.read(notesProvider.notifier).createNote(
              title,
              content,
            );
      }

      if (mounted) {
        context.go('/');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save note: ${e.toString()}'),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: _saveNote,
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isNewNote ? 'New Note' : 'Edit Note'),
        actions: [
          IconButton(
            onPressed: _isLoading ? null : _saveNote,
            icon: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
