import 'app_localizations.dart';

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get enterFullName => 'Entrez votre nom';

  @override
  String get enterFullNameAgain => 'Entrez votre nom s\'il vous plait!';

  @override
  String get enterEmail => 'Entrez votre email';

  @override
  String get enterEmailAgain => 'Entrez une email valide s\'il vous plait!';

  @override
  String get enterPassword => 'Entrez votre mot de passe';

  @override
  String get enterPasswordAgain => 'Entrez un mot de passe de 6 caracteres minimum';

  @override
  String get login => 'Connexion';

  @override
  String get signup => 'Inscription';

  @override
  String get noAccount => 'Vous n\'avez pas de compte ? Inscrivez-vous';

  @override
  String get yesAccount => 'Vous avez déja un compte ? Connecter vous';

  @override
  String name(Object name) {
    return 'Pseudo  : $name';
  }

  @override
  String email(Object email) {
    return 'Email : $email';
  }

  @override
  String get edit => 'Modifier';

  @override
  String get language => 'Langues';

  @override
  String get popular => 'Populaire';

  @override
  String get trendingPerson => 'Les personnes de la semaine';

  @override
  String get overview => 'Synopsis';

  @override
  String get release => 'Date de sortie';

  @override
  String get length => 'Durée';

  @override
  String get budget => 'Budget';

  @override
  String get screenshots => 'Capture d\'écran';

  @override
  String get casts => 'Casting';

  @override
  String get newplaying => 'Nouveautés';

  @override
  String get signout => 'Deconnexion';
}
