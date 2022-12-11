# naql

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## How to use provider 
```instatnce of appState --> final _store = Provider.of<AppState>(context); to get data --->  print(_store.getDisplayText);```


 ## locatization
 ```flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/locale/localization.dart```

 ```flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/l10n/intl_en.arb lib/l10n/intl_messages.arb lib/l10n/intl_ar.arb lib/locale/localization.dart```

