import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_uz.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('uz'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Buildify'**
  String get appName;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Build mobile app UIs\nwithout writing code'**
  String get welcomeTitle;

  /// No description provided for @welcomeDesc.
  ///
  /// In en, this message translates to:
  /// **'Select ready-made widgets, drag and drop, and customize them to fit your needs.'**
  String get welcomeDesc;

  /// No description provided for @createProjectBtn.
  ///
  /// In en, this message translates to:
  /// **'Create New Project'**
  String get createProjectBtn;

  /// No description provided for @homeTab.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTab;

  /// No description provided for @createTab.
  ///
  /// In en, this message translates to:
  /// **'New Project'**
  String get createTab;

  /// No description provided for @projectsTab.
  ///
  /// In en, this message translates to:
  /// **'My Projects'**
  String get projectsTab;

  /// No description provided for @settingsTab.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTab;

  /// No description provided for @projectNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Project Name'**
  String get projectNameLabel;

  /// No description provided for @projectNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. My new app'**
  String get projectNameHint;

  /// No description provided for @createWizardDesc.
  ///
  /// In en, this message translates to:
  /// **'Write your project name and start designing.'**
  String get createWizardDesc;

  /// No description provided for @startProjectBtn.
  ///
  /// In en, this message translates to:
  /// **'Start Project'**
  String get startProjectBtn;

  /// No description provided for @projectsDesc.
  ///
  /// In en, this message translates to:
  /// **'List of created projects. You can edit or delete them.'**
  String get projectsDesc;

  /// No description provided for @projectsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No projects found'**
  String get projectsEmpty;

  /// No description provided for @settingsDesc.
  ///
  /// In en, this message translates to:
  /// **'Visual Buildify environment and interface settings.'**
  String get settingsDesc;

  /// No description provided for @themeLabel.
  ///
  /// In en, this message translates to:
  /// **'App Theme'**
  String get themeLabel;

  /// No description provided for @themeDesc.
  ///
  /// In en, this message translates to:
  /// **'Manually change the theme or match the system'**
  String get themeDesc;

  /// No description provided for @scaleLabel.
  ///
  /// In en, this message translates to:
  /// **'Emulator Scale'**
  String get scaleLabel;

  /// No description provided for @scaleDesc.
  ///
  /// In en, this message translates to:
  /// **'Ratio size of the phone emulator'**
  String get scaleDesc;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @langLabel.
  ///
  /// In en, this message translates to:
  /// **'System Language'**
  String get langLabel;

  /// No description provided for @langDesc.
  ///
  /// In en, this message translates to:
  /// **'Change the application interface language'**
  String get langDesc;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @manage.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get manage;

  /// No description provided for @createdBy.
  ///
  /// In en, this message translates to:
  /// **'Created in collaboration with Google DeepMind team'**
  String get createdBy;

  /// No description provided for @elementsCount.
  ///
  /// In en, this message translates to:
  /// **'elements'**
  String get elementsCount;

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @texts.
  ///
  /// In en, this message translates to:
  /// **'Texts'**
  String get texts;

  /// No description provided for @buttons.
  ///
  /// In en, this message translates to:
  /// **'Buttons'**
  String get buttons;

  /// No description provided for @design.
  ///
  /// In en, this message translates to:
  /// **'Design'**
  String get design;

  /// No description provided for @blocks.
  ///
  /// In en, this message translates to:
  /// **'Blocks'**
  String get blocks;

  /// No description provided for @gridToggle.
  ///
  /// In en, this message translates to:
  /// **'Toggle Grid'**
  String get gridToggle;

  /// No description provided for @clearCanvas.
  ///
  /// In en, this message translates to:
  /// **'Clear Canvas'**
  String get clearCanvas;

  /// No description provided for @propertiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Element Properties'**
  String get propertiesTitle;

  /// No description provided for @noElementSelected.
  ///
  /// In en, this message translates to:
  /// **'No element selected'**
  String get noElementSelected;

  /// No description provided for @clickToAdd.
  ///
  /// In en, this message translates to:
  /// **'Click to add elements'**
  String get clickToAdd;

  /// No description provided for @pageProperties.
  ///
  /// In en, this message translates to:
  /// **'Page Settings'**
  String get pageProperties;

  /// No description provided for @pageNameLabelUppercase.
  ///
  /// In en, this message translates to:
  /// **'PAGE NAME'**
  String get pageNameLabelUppercase;

  /// No description provided for @pageNamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Page name'**
  String get pageNamePlaceholder;

  /// No description provided for @addAppBarLabel.
  ///
  /// In en, this message translates to:
  /// **'ADD APPBAR'**
  String get addAppBarLabel;

  /// No description provided for @appBarTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'AppBar Title'**
  String get appBarTitleLabel;

  /// No description provided for @titleTextPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Title text'**
  String get titleTextPlaceholder;

  /// No description provided for @bgColorLabel.
  ///
  /// In en, this message translates to:
  /// **'Background Color'**
  String get bgColorLabel;

  /// No description provided for @textColorLabel.
  ///
  /// In en, this message translates to:
  /// **'Text Color'**
  String get textColorLabel;

  /// No description provided for @bottomNavBarLabel.
  ///
  /// In en, this message translates to:
  /// **'BOTTOM NAVIGATION BAR'**
  String get bottomNavBarLabel;

  /// No description provided for @activeTabColorLabel.
  ///
  /// In en, this message translates to:
  /// **'Active Tab Color'**
  String get activeTabColorLabel;

  /// No description provided for @tab1Label.
  ///
  /// In en, this message translates to:
  /// **'Tab 1 (Home)'**
  String get tab1Label;

  /// No description provided for @tab1Placeholder.
  ///
  /// In en, this message translates to:
  /// **'Tab 1 Name'**
  String get tab1Placeholder;

  /// No description provided for @tab2Label.
  ///
  /// In en, this message translates to:
  /// **'Tab 2 (Profile)'**
  String get tab2Label;

  /// No description provided for @tab2Placeholder.
  ///
  /// In en, this message translates to:
  /// **'Tab 2 Name'**
  String get tab2Placeholder;

  /// No description provided for @deleteBtnLabel.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteBtnLabel;

  /// No description provided for @duplicateBtnLabel.
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get duplicateBtnLabel;

  /// No description provided for @componentsTitle.
  ///
  /// In en, this message translates to:
  /// **'COMPONENTS'**
  String get componentsTitle;

  /// No description provided for @noComponentsInCategory.
  ///
  /// In en, this message translates to:
  /// **'No components in this section'**
  String get noComponentsInCategory;

  /// No description provided for @propertiesHeader.
  ///
  /// In en, this message translates to:
  /// **'PROPERTIES'**
  String get propertiesHeader;

  /// No description provided for @positionAndSizeHeader.
  ///
  /// In en, this message translates to:
  /// **'POSITION & SIZING'**
  String get positionAndSizeHeader;

  /// No description provided for @alignHorizontalCenter.
  ///
  /// In en, this message translates to:
  /// **'Align horizontally'**
  String get alignHorizontalCenter;

  /// No description provided for @alignVerticalCenter.
  ///
  /// In en, this message translates to:
  /// **'Align vertically'**
  String get alignVerticalCenter;

  /// No description provided for @stretchToScreen.
  ///
  /// In en, this message translates to:
  /// **'Stretch to screen width'**
  String get stretchToScreen;

  /// No description provided for @enterProperty.
  ///
  /// In en, this message translates to:
  /// **'Enter {label}...'**
  String enterProperty(String label);

  /// No description provided for @elementsCountLabel.
  ///
  /// In en, this message translates to:
  /// **'Total elements: {count}'**
  String elementsCountLabel(int count);

  /// No description provided for @startFromLeftPanel.
  ///
  /// In en, this message translates to:
  /// **'Start from the left panel'**
  String get startFromLeftPanel;

  /// No description provided for @addNewPageTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add new page'**
  String get addNewPageTooltip;

  /// No description provided for @pageDefaultName.
  ///
  /// In en, this message translates to:
  /// **'Page'**
  String get pageDefaultName;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'uz'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'uz':
      return AppLocalizationsUz();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
