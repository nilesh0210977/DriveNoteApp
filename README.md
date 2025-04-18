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

## Screenshots

### Light Theme

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/9d88bdde-2609-45c1-b997-95a5deca6dfa" width="200"></td>
    <td><img src="https://github.com/user-attachments/assets/b56b4c63-59ef-4e2e-a8c4-218df3223b51" width="200"></td>
    <td><img src="https://github.com/user-attachments/assets/a40b5677-fb82-4ed6-b7d1-d36332d6435e" width="200"></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/9fcfd626-679f-48c9-a472-7c8794effb30" width="200"></td>
    <td><img src="https://github.com/user-attachments/assets/41db2348-9f1a-4356-af81-0a125c1662cd" width="200"></td>
    <td><img src="https://github.com/user-attachments/assets/bfbcb895-261e-4a95-a7e9-c1faef401659" width="200"></td>
  </tr>
</table>

### Dark Theme

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/149a49ba-eda3-4397-8bfe-cf987108d787" width="200"></td>
    <td><img src="https://github.com/user-attachments/assets/00653278-2fae-4799-9afc-c9076fd6f0a6" width="200"></td>
    <td><img src="https://github.com/user-attachments/assets/24fb4d2c-6242-44c9-80de-debeabcbdb74" width="200"></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/f9977c7a-2e2a-441e-a25f-6ae672b6ef01" width="200"></td>
    <td><img src="https://github.com/user-attachments/assets/a84d41f0-21ef-46e3-8716-b507e15f4e27" width="200"></td>
    <td></td>
  </tr>
</table>


