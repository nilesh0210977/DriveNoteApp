import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drive_note_app/features/auth/domain/providers/auth_provider.dart';
import 'package:drive_note_app/core/constants/app_constants.dart';
import 'package:googleapis_auth/auth_io.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              AppConstants.appName,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your notes, synced with Google Drive',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 48),
            Icon(
              Icons.note_alt_outlined,
              size: 120,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: authState.maybeWhen(
                initial: () => () =>
                    ref.read(authProvider.notifier).signIn(AccessCredentials()),
                unauthenticated: () => () =>
                    ref.read(authProvider.notifier).signIn(AccessCredentials()),
                orElse: () => null,
              ),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('Sign in with Google'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
