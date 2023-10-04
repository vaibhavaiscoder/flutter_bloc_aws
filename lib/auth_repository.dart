import 'package:amplify_flutter/amplify_flutter.dart';

class AuthRepository {

  Future<String> fetchUserIdFromAttributes() async {
    try {
      final attributes = await Amplify.Auth.fetchUserAttributes();
      final subAttribute =
          attributes.firstWhere((element) => element.userAttributeKey.toString() == 'sub');
      final userId = subAttribute.value;
      return userId;
    } catch (e) {
      rethrow;
    }
  }

  // Sign in
  Future<String> webSignIn() async {
    try {
      final result = await Amplify.Auth.signInWithWebUI();
      if (result.isSignedIn) {
        // get user id
        return await fetchUserIdFromAttributes();
      } else {
        throw Exception('could not sign in');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  // Auto sign in
  Future<String> attemptAutoSignIn() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();
      if (session.isSignedIn) {
        return await fetchUserIdFromAttributes();
      } else {
        throw Exception('Not signed in');
      }
    } catch (e) {
      rethrow;
    }
  }
}
