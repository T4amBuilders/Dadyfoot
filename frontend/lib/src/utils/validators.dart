class Validators {
  // Fonction de validation pour vérifier si le pseudo est alphanumérique
  static bool isValidUsername(String username) {
    final RegExp usernameRegExp = RegExp(r'^[a-zA-Z0-9]+$');
    return usernameRegExp.hasMatch(username);
  }
}
