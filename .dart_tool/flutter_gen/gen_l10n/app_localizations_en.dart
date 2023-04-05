import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get enterFullName => 'Enter Full Name';

  @override
  String get enterFullNameAgain => 'Please Enter Full Name';

  @override
  String get enterEmail => 'Enter Email';

  @override
  String get enterEmailAgain => 'Please Enter valid Email';

  @override
  String get enterPassword => 'Enter Password';

  @override
  String get enterPasswordAgain => 'Please Enter Password of min length 6';

  @override
  String get login => 'Login';

  @override
  String get signup => 'Signup';

  @override
  String get noAccount => 'Don\'t have an account? Signup';

  @override
  String get yesAccount => 'Already have an account? Login';

  @override
  String name(Object name) {
    return 'Name  : $name';
  }

  @override
  String email(Object email) {
    return 'Email : $email';
  }

  @override
  String get edit => 'Edit';

  @override
  String get language => 'Languages';

  @override
  String get popular => 'Popular';

  @override
  String get trendingPerson => 'Trending persons on this week';

  @override
  String get overview => 'Overview';

  @override
  String get release => 'Release date';

  @override
  String get length => 'run time';

  @override
  String get budget => 'Budget';

  @override
  String get screenshots => 'Screenshots';

  @override
  String get casts => 'Casts';

  @override
  String get newplaying => 'Nouveautés';

  @override
  String get signout => 'Sign out';
}
