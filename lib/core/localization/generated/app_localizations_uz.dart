// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class AppLocalizationsUz extends AppLocalizations {
  AppLocalizationsUz([String locale = 'uz']) : super(locale);

  @override
  String get appName => 'Buildify';

  @override
  String get welcomeTitle =>
      'Mobil ilova interfeyslarini\nkod yozmasdan yarating';

  @override
  String get welcomeDesc =>
      'Tayyor andozalarni tanlang, sudrab olib kelib joylang va o\'zingizga mos ravishda sozlang.';

  @override
  String get createProjectBtn => 'Yangi loyiha yaratish';

  @override
  String get homeTab => 'Bosh sahifa';

  @override
  String get createTab => 'Yangi loyiha';

  @override
  String get projectsTab => 'Loyihalarim';

  @override
  String get settingsTab => 'Sozlamalar';

  @override
  String get projectNameLabel => 'Loyiha nomi';

  @override
  String get projectNameHint => 'Masalan: Mening yangi ilovam';

  @override
  String get createWizardDesc => 'Loyiha nomini yozing va dizaynni boshlang.';

  @override
  String get startProjectBtn => 'Loyihani boshlash';

  @override
  String get projectsDesc =>
      'Yaratilgan loyihalar ro\'yxati. Ularni tahrirlashingiz yoki o\'chirishingiz mumkin.';

  @override
  String get projectsEmpty => 'Loyihalar topilmadi';

  @override
  String get settingsDesc => 'Visual Buildify muhiti va interfeys sozlamalari.';

  @override
  String get themeLabel => 'Ilova mavzusi';

  @override
  String get themeDesc => 'Mavzuni qo\'lda o\'zgartirish yoki tizimga moslash';

  @override
  String get scaleLabel => 'Emulator Masshtabi';

  @override
  String get scaleDesc => 'Telefon emulyatori o\'lchami nisbati';

  @override
  String get lightMode => 'Yorug\' rejim';

  @override
  String get darkMode => 'Qorong\'u rejim';

  @override
  String get langLabel => 'Tizim tili';

  @override
  String get langDesc => 'Ilova interfeysi tilini o\'zgartirish';

  @override
  String get edit => 'Tahrirlash';

  @override
  String get delete => 'O\'chirish';

  @override
  String get manage => 'Boshqarish';

  @override
  String get createdBy => 'Google DeepMind jamoasi bilan hamkorlikda yaratildi';

  @override
  String get elementsCount => 'ta element';

  @override
  String get justNow => 'Hozirgina';

  @override
  String get yesterday => 'Kecha';

  @override
  String get today => 'Bugun';

  @override
  String get backToHome => 'Bosh sahifaga qaytish';

  @override
  String get all => 'Barchasi';

  @override
  String get texts => 'Matnlar';

  @override
  String get buttons => 'Tugmalar';

  @override
  String get design => 'Dizayn';

  @override
  String get blocks => 'Bloklar';

  @override
  String get gridToggle => 'Setkani yoqish/o\'chirish';

  @override
  String get clearCanvas => 'Tozalash';

  @override
  String get propertiesTitle => 'Element xususiyatlari';

  @override
  String get noElementSelected => 'Element tanlanmagan';

  @override
  String get clickToAdd => 'Element qo\'shish uchun bosing';

  @override
  String get pageProperties => 'Sahifa sozlamalari';

  @override
  String get pageNameLabelUppercase => 'SAHIFA NOMI';

  @override
  String get pageNamePlaceholder => 'Sahifa nomi';

  @override
  String get addAppBarLabel => 'APPBAR QO\'SHISH';

  @override
  String get appBarTitleLabel => 'AppBar Sarlavhasi';

  @override
  String get titleTextPlaceholder => 'Sarlavha matni';

  @override
  String get bgColorLabel => 'Orqa fon rangi';

  @override
  String get textColorLabel => 'Matn rangi';

  @override
  String get bottomNavBarLabel => 'BOTTOM NAVIGATION BAR';

  @override
  String get activeTabColorLabel => 'Aktiv tab rangi';

  @override
  String get tab1Label => 'Tab 1 (Home)';

  @override
  String get tab1Placeholder => 'Tab 1 nomi';

  @override
  String get tab2Label => 'Tab 2 (Profile)';

  @override
  String get tab2Placeholder => 'Tab 2 nomi';

  @override
  String get deleteBtnLabel => 'O\'chirish';

  @override
  String get duplicateBtnLabel => 'Nusxalash';

  @override
  String get componentsTitle => 'KOMPONENTLAR';

  @override
  String get noComponentsInCategory => 'Bu bo\'limda komponentlar yo\'q';

  @override
  String get propertiesHeader => 'XUSUSIYATLAR';

  @override
  String get positionAndSizeHeader => 'JOYLASHUV VA O\'LCHAM';

  @override
  String get alignHorizontalCenter => 'Gorizontal markazlash';

  @override
  String get alignVerticalCenter => 'Vertikal markazlash';

  @override
  String get stretchToScreen => 'Ekran bo\'ylab cho\'zish';

  @override
  String enterProperty(String label) {
    return '$label kiriting...';
  }

  @override
  String elementsCountLabel(int count) {
    return 'Elementlar soni: $count';
  }

  @override
  String get startFromLeftPanel => 'Chap paneldan boshlang';

  @override
  String get addNewPageTooltip => 'Yangi oyna qo\'shish';

  @override
  String get pageDefaultName => 'Oyna';
}
