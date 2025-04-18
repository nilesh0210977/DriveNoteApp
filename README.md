# DriveNotes

A Flutter application that allows you to create, edit, and manage notes that are automatically synced with your Google Drive account.

## Features

- 🔐 Secure Google Sign-In authentication
- 📝 Create, edit, and delete notes
- ☁️ Automatic sync with Google Drive
- 🔄 Real-time updates
- 🌓 Light/Dark theme support
- 📱 Responsive design for mobile devices
- 🔍 Markdown support for note content
- 📅 Last modified timestamps

## Getting Started

### Prerequisites

- Flutter SDK (version 3.0.0 or higher)
- Android Studio / VS Code with Flutter extensions
- Google Cloud Platform account

### Setting up Google API Credentials

1. Go to the [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Enable the Google Drive API for your project
4. Create OAuth 2.0 credentials:
   - Go to "APIs & Services" > "Credentials"
   - Click "Create Credentials" > "OAuth client ID"
   - Select "Android" as the application type
   - Add your package name: `com.example.drive_note_app`
   - Add your SHA-1 signing certificate fingerprint
     (Note: To get SHA-1 signing certificate fingerprint, run the following command in the terminal:
     ```bash
     keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
     ```
     For release builds, use your release keystore instead of the debug keystore)
5. Update the client ID in `lib/features/auth/data/repositories/auth_repository.dart`:
   ```dart
   final ClientId _clientId = ClientId(
     Platform.isAndroid
         ? "YOUR_ANDROID_CLIENT_ID"  // Replace with your Android client ID
         : "YOUR_IOS_CLIENT_ID",     // Replace with your iOS client ID if needed
     null, // Client secret is null for mobile apps
   );
   ```

### Running the App

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Technical Details

- Uses `google_sign_in` package for authentication
- Implements secure token storage using `flutter_secure_storage`
- Stores notes in a dedicated "DriveNotes" folder in Google Drive
- Uses Riverpod for state management
- Implements GoRouter for navigation
- Supports both Android and iOS platforms

## Known Limitations

- Notes are stored as plain text files in Google Drive
- No offline support - requires internet connection
- No image or file attachments support
- No note sharing functionality
- No note categories or tags
- No search functionality within notes
- No note version history
- Limited to Google Drive storage quota

## License

This project is licensed under the MIT License - see the LICENSE file for details.


