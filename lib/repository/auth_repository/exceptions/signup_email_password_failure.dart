class SignupWithEmailAndPasswordFailure {
  final String message;

  const SignupWithEmailAndPasswordFailure(
      [this.message = "An unknown error error occurred."]);

  factory SignupWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return const SignupWithEmailAndPasswordFailure(
            'Please enter a stronger password.');
      case 'invalid-email':
        return const SignupWithEmailAndPasswordFailure(
            'Email is invalid or badly formatted.');
      case 'email-already-in-use':
        return const SignupWithEmailAndPasswordFailure(
            'An account already exist for that email.');
      case 'operation-not-allowed':
        return const SignupWithEmailAndPasswordFailure(
            'Operation is not allowed. Please contact support.');
      case 'user-disabled':
        return const SignupWithEmailAndPasswordFailure(
            'This user has been disabled.');
      default:
        return const SignupWithEmailAndPasswordFailure();
    }
  }
}
