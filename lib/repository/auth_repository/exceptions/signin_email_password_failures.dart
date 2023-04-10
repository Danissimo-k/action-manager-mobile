class SigninWithEmailAndPasswordFailure {
  final String message;

  const SigninWithEmailAndPasswordFailure(
      [this.message = "An unknown error error occurred."]);

  factory SigninWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
        return const SigninWithEmailAndPasswordFailure(
            'Email already used. Go to login page.');
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return const SigninWithEmailAndPasswordFailure(
            'Email already used. Go to login page.');
      case "wrong-password":
        return const SigninWithEmailAndPasswordFailure(
            "Wrong email/password combination.");
      case "user-not-found":
        return const SigninWithEmailAndPasswordFailure(
            "No user found with this email.");
      case "user-disabled":
        return const SigninWithEmailAndPasswordFailure(
            'This user has been disabled.');
      case 'operation-not-allowed':
        return const SigninWithEmailAndPasswordFailure(
            'Operation is not allowed. Please contact support.');
      case "invalid-email":
        return const SigninWithEmailAndPasswordFailure(
            'Email is invalid or badly formatted.');
      default:
        return const SigninWithEmailAndPasswordFailure();
    }
  }
}
