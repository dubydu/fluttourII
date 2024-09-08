[![Build Status](https://github.com/dubydu/fluttourII/actions/workflows/ci.yml/badge.svg)](https://github.com/dubydu/fluttourII/actions/workflows/ci.yml)

A Flutter project template, an upgrade version of [`fluttour`](https://github.com/dubydu/fluttour)

### [Getting Started](#getting-started)

* Flutter (Channel stable, 3.24.1)
* Dart 3.5.1
* Cocoapods 1.15.2

### [Article](#article)
* [`Flutter x Clean Architecture`](https://dubydu.medium.com/b53ce9e19d5a)

### [Main Packages](#main-packages)
* [`flutter_bloc`](https://pub.dev/packages/flutter_bloc): State management package.
* [`dio`](https://pub.dev/packages/dio): A powerful Http client for Dart.
* [`graphql`](https://pub.dev/packages/graphql): A stand-alone GraphQL client for Dart.
* [`mockito`](https://pub.dev/packages/mockito): A mock framework with APIs for Fakes, Mocks, behavior verification, and stubbing.

### [Usage](#usage)

#### Run App with a specific environment.
* Development: `flutter run --flavor dev -t lib/main_dev.dart`
* Production: `flutter run --flavor prod -t lib/main_prod.dart`

### [Project Structure](#project-structure)
```
.
├── README.md
├── {project_name}
│   ├── asssets
│   │   ├── fonts
│   │   ├── icons
│   │   ├── images
│   │   └── locales
│   └── lib
│       ├── config
│       │   ├── app_config.dart
│       │   ├── app_config_type.dart
│       │   ├── app_secure_config.dart
│       │   └── app_secure_config_type.dart
│       ├── data
│       │   ├── api
│       │   │   ├── api_client
│       │   │   │   ├── interceptor
│       │   │   │   │   ├── curl_log.dart
│       │   │   │   │   └── query.dart
│       │   │   │   ├── api_client.dart
│       │   │   │   ├── api_client_type.dart
│       │   │   │   └── api_client_type.g.dart
│       │   │   ├── graphql_client
│       │   │   │   ├── graphql_client.dart
│       │   │   │   └── graphql_client_type.dart
│       │   │   ├── query
│       │   │   │   ├── graphql_query.dart
│       │   │   │   └── sqlite_query.dart
│       │   │   ├── request
│       │   │   │   └── dummy_request.dart
│       │   │   └── response
│       │   │       ├── dummy_response.dart
│       │   │       └── dummy_response.g.dart
│       │   ├── datasource
│       │   │   └── dummy
│       │   │       ├── dummy_datasource.dart
│       │   │       └── dummy_datasource_type.dart
│       │   ├── repositoty
│       │   │   └── dummy_repository.dart
│       │   ├── translator
│       │   │   └── dummy_translator.dart
│       │   └── error_response.dart
│       ├── di
│       │   ├── client_module.dart
│       │   ├── config_module.dart
│       │   ├── datasource_module.dart
│       │   ├── repository_module.dart
│       │   └── usecase_module.dart
│       ├── domain
│       │   ├── model
│       │   │   ├── empty.dart
│       │   │   ├── failure.dart
│       │   │   └── dummy.dart
│       │   ├── repository
│       │   │   └── dummy_repository_type.dart
│       │   └── usecase
│       │       └── dummy
│       │           ├── dummy_usecase.dart
│       │           └── dummy_usecase_type.dart
│       ├── environment
│       │   ├── development
│       │   │   └── development_env.dart
│       │   ├── production
│       │   │   └── production_env.dart
│       │   └── environment.dart
│       ├── presentation
│       │   └── dummy
│       │       ├── dummy_page.dart
│       │       └── dummy_bloc.dart
│       ├── router
│       │   ├── gen_route.dart
│       │   ├── named_route.dart
│       │   ├── navigation_controller.dart
│       │   └── routes.dart
│       ├── util
│       │   ├── assets
│       │   │   ├── app_color.dart
│       │   │   ├── app_icon.dart
│       │   │   ├── app_image.dart
│       │   │   ├── app_locale.dart
│       │   │   └── app_text.dart
│       │   ├── extension
│       │   ├── widget
│       │   ├── app_global.dart
│       │   ├── app_mixin.dart
│       │   ├── app_router.dart
│       │   └── util.dart
│       ├── main.dart
│       ├── main_dev.dart
│       ├── main_prod.dart
│       └── my_app.dart
└── test
    ├── domain
    │   ├── usecase
    │   │   └── dummy
    │   │       ├── dummy_usecase_test.dart
    │   │       └── dummy_usecase_test.mocks.dart
    └── mock
        └── dummy_response_mock.dart
```

### [Unit Testing](#unit-testing)
```
  group('describes what component you are testing', () {
    test('describes the purpose of the test or the current state of an object', () {
    
      // stub a mock method before interacting
      when('mock.doMock()').thenAnswer((_) => 'stub');
      
      // the expected result of the test
      expect('actual', 'matcher');
    });
  });
```
- Run tests `flutter test test/*`

### [Pitfalls](#pitfalls)
- Make sure `flutter pub get` before you run the app.

### [Archive](#archive)
#### iOS
* Development: `flutter build ipa --flavor dev lib/main_dev.dart --export-method [...]`
* Production: `flutter build ipa --flavor prod lib/main_prod.dart --export-method [...]`
* [`--export-method`](https://docs.flutter.dev/deployment/ios#create-an-app-bundle)
#### Android
* Development: `flutter build [appbundle/apk] --flavor dev lib/main_dev.dart`
* Production: `flutter build [appbundle/apk] --flavor prod lib/main_prod.dart`

### [Practice](#practice)
- [`Flutter x Magic Sliver Widgets`](https://github.com/dubydu/magic-sliver)
