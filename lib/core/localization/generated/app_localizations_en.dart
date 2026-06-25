// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Buildify';

  @override
  String get welcomeTitle => 'Build mobile app UIs\nwithout writing code';

  @override
  String get welcomeDesc =>
      'Select ready-made widgets, drag and drop, and customize them to fit your needs.';

  @override
  String get createProjectBtn => 'Create New Project';

  @override
  String get homeTab => 'Home';

  @override
  String get createTab => 'New Project';

  @override
  String get projectsTab => 'My Projects';

  @override
  String get settingsTab => 'Settings';

  @override
  String get projectNameLabel => 'Project Name';

  @override
  String get projectNameHint => 'e.g. My new app';

  @override
  String get createWizardDesc => 'Write your project name and start designing.';

  @override
  String get startProjectBtn => 'Start Project';

  @override
  String get projectsDesc =>
      'List of created projects. You can edit or delete them.';

  @override
  String get projectsEmpty => 'No projects found';

  @override
  String get settingsDesc =>
      'Visual Buildify environment and interface settings.';

  @override
  String get themeLabel => 'App Theme';

  @override
  String get themeDesc => 'Manually change the theme or match the system';

  @override
  String get scaleLabel => 'Emulator Scale';

  @override
  String get scaleDesc => 'Ratio size of the phone emulator';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get langLabel => 'System Language';

  @override
  String get langDesc => 'Change the application interface language';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get manage => 'Manage';

  @override
  String get createdBy => 'Created in collaboration with Google DeepMind team';

  @override
  String get elementsCount => 'elements';

  @override
  String get justNow => 'Just now';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get today => 'Today';

  @override
  String get backToHome => 'Back to Home';

  @override
  String get all => 'All';

  @override
  String get texts => 'Texts';

  @override
  String get buttons => 'Buttons';

  @override
  String get design => 'Design';

  @override
  String get blocks => 'Blocks';

  @override
  String get gridToggle => 'Toggle Grid';

  @override
  String get clearCanvas => 'Clear Canvas';

  @override
  String get propertiesTitle => 'Element Properties';

  @override
  String get noElementSelected => 'No element selected';

  @override
  String get clickToAdd => 'Click to add elements';

  @override
  String get pageProperties => 'Page Settings';

  @override
  String get pageNameLabelUppercase => 'PAGE NAME';

  @override
  String get pageNamePlaceholder => 'Page name';

  @override
  String get addAppBarLabel => 'ADD APPBAR';

  @override
  String get appBarTitleLabel => 'AppBar Title';

  @override
  String get titleTextPlaceholder => 'Title text';

  @override
  String get bgColorLabel => 'Background Color';

  @override
  String get textColorLabel => 'Text Color';

  @override
  String get bottomNavBarLabel => 'BOTTOM NAVIGATION BAR';

  @override
  String get activeTabColorLabel => 'Active Tab Color';

  @override
  String get tab1Label => 'Tab 1 (Home)';

  @override
  String get tab1Placeholder => 'Tab 1 Name';

  @override
  String get tab2Label => 'Tab 2 (Profile)';

  @override
  String get tab2Placeholder => 'Tab 2 Name';

  @override
  String get deleteBtnLabel => 'Delete';

  @override
  String get duplicateBtnLabel => 'Duplicate';

  @override
  String get componentsTitle => 'COMPONENTS';

  @override
  String get noComponentsInCategory => 'No components in this section';

  @override
  String get propertiesHeader => 'PROPERTIES';

  @override
  String get positionAndSizeHeader => 'POSITION & SIZING';

  @override
  String get alignHorizontalCenter => 'Align horizontally';

  @override
  String get alignVerticalCenter => 'Align vertically';

  @override
  String get stretchToScreen => 'Stretch to screen width';

  @override
  String enterProperty(String label) {
    return 'Enter $label...';
  }

  @override
  String elementsCountLabel(int count) {
    return 'Total elements: $count';
  }

  @override
  String get startFromLeftPanel => 'Start from the left panel';

  @override
  String get addNewPageTooltip => 'Add new page';

  @override
  String get pageDefaultName => 'Page';
}
