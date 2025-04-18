import 'dart:convert';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:drive_note_app/features/notes/domain/models/note_model.dart';
import 'package:drive_note_app/core/constants/app_constants.dart';
import 'package:drive_note_app/core/errors/app_errors.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart';

class DriveRepository {
  late drive.DriveApi _driveApi;
  String? _folderDriveId;
  final _uuid = const Uuid();
  bool _isInitialized = false;

  Future<void> initialize(AccessCredentials credentials) async {
    if (_isInitialized) {
      return;
    }

    try {
      debugPrint('Initializing Drive API with credentials...');

      // Create a new HTTP client for each initialization
      final client = authenticatedClient(
        http.Client(),
        credentials,
      );

      _driveApi = drive.DriveApi(client);
      await _ensureFolderExists();
      _isInitialized = true;
      debugPrint('Drive API initialized successfully');
    } catch (e) {
      debugPrint('Failed to initialize Drive API: $e');
      throw DriveError('Failed to initialize Drive API: ${e.toString()}');
    }
  }

  Future<void> _ensureFolderExists() async {
    try {
      debugPrint('Ensuring DriveNotes folder exists...');

      // Search for existing folder
      final fileList = await _driveApi.files.list(
        q: "name='${AppConstants.driveNotesFolder}' and mimeType='application/vnd.google-apps.folder' and trashed=false",
        spaces: 'drive',
      );

      if (fileList.files != null && fileList.files!.isNotEmpty) {
        _folderDriveId = fileList.files!.first.id;
        debugPrint('Found existing DriveNotes folder: $_folderDriveId');
        return;
      }

      // Create the folder if it doesn't exist
      final folder = drive.File()
        ..name = AppConstants.driveNotesFolder
        ..mimeType = 'application/vnd.google-apps.folder';

      final result = await _driveApi.files.create(folder);
      _folderDriveId = result.id;
      debugPrint('Created new DriveNotes folder: $_folderDriveId');
    } catch (e) {
      debugPrint('Failed to ensure folder exists: $e');
      throw DriveError(
          'Failed to create or find DriveNotes folder: ${e.toString()}');
    }
  }

  Future<List<Note>> fetchNotes() async {
    if (!_isInitialized) {
      throw DriveError('Drive API not initialized');
    }

    if (_folderDriveId == null) {
      await _ensureFolderExists();
    }

    try {
      debugPrint('Fetching notes from folder: $_folderDriveId');

      final fileList = await _driveApi.files.list(
        q: "'$_folderDriveId' in parents and mimeType='text/plain' and trashed=false",
        spaces: 'drive',
        $fields: 'files(id, name, modifiedTime)',
      );

      if (fileList.files == null) {
        debugPrint('No notes found in folder');
        return [];
      }

      final notes = <Note>[];
      for (final file in fileList.files!) {
        try {
          final content = await _downloadNoteContent(file.id!);
          notes.add(Note(
            id: file.id!,
            title: file.name!,
            content: content,
            lastModified: file.modifiedTime ?? DateTime.now(),
            driveFileId: file.id,
          ));
        } catch (e) {
          debugPrint('Failed to process note ${file.id}: $e');
          // Continue with other notes even if one fails
        }
      }

      debugPrint('Successfully fetched ${notes.length} notes');
      return notes;
    } catch (e) {
      debugPrint('Failed to fetch notes: $e');
      throw DriveError('Failed to fetch notes: ${e.toString()}');
    }
  }

  Future<String> _downloadNoteContent(String fileId) async {
    try {
      final media = await _driveApi.files.get(
        fileId,
        downloadOptions: drive.DownloadOptions.fullMedia,
      ) as drive.Media;

      final bytes = await media.stream.toList();
      final content = utf8.decode(bytes.expand((e) => e).toList());
      return content;
    } catch (e) {
      throw DriveError('Failed to download note content: ${e.toString()}');
    }
  }

  Future<Note> createNote(String title, String content) async {
    if (_folderDriveId == null) {
      await _ensureFolderExists();
    }

    try {
      final file = drive.File()
        ..name = title
        ..parents = [_folderDriveId!]
        ..mimeType = 'text/plain';

      final uploadedFile = await _driveApi.files.create(
        file,
        uploadMedia: drive.Media(
          Stream.fromIterable([utf8.encode(content)]),
          content.length,
        ),
      );

      return Note(
        id: uploadedFile.id!,
        title: uploadedFile.name!,
        content: content,
        lastModified: uploadedFile.modifiedTime ?? DateTime.now(),
        driveFileId: uploadedFile.id,
      );
    } catch (e) {
      throw DriveError('Failed to create note: ${e.toString()}');
    }
  }

  Future<Note> updateNote(Note note) async {
    try {
      await _driveApi.files.update(
        drive.File()..name = note.title,
        note.driveFileId!,
        uploadMedia: drive.Media(
          Stream.fromIterable([utf8.encode(note.content)]),
          note.content.length,
        ),
      );

      return note.copyWith(
        lastModified: DateTime.now(),
      );
    } catch (e) {
      throw DriveError('Failed to update note: ${e.toString()}');
    }
  }

  Future<void> deleteNote(String driveFileId) async {
    try {
      await _driveApi.files.delete(driveFileId);
    } catch (e) {
      throw DriveError('Failed to delete note: ${e.toString()}');
    }
  }
}
