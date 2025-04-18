class AppConstants {
  static const String driveNotesFolder = 'DriveNotes';
  static const String appName = 'DriveNotes';
  
  // Storage keys
  static const String accessTokenKey = 'accessToken';
  static const String refreshTokenKey = 'refreshToken';
  static const String expiryKey = 'expiry';
  
  // OAuth scopes
  static const List<String> driveScopes = [
    'https://www.googleapis.com/auth/drive.file',
    'email',
    'profile',
  ];
}
