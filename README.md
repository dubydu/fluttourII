[![Build Status](https://app.bitrise.io/app/38259925b6bfe2bd/status.svg?token=7Q0InN8BEzmzxC0GPoddUg&branch=develop)](https://app.bitrise.io/app/38259925b6bfe2bd)

A Flutter project template, an upgrade version of [`fluttour`](https://github.com/dubydu/fluttour)

### [Getting Started](#getting-started)

* Flutter (Channel stable, 3.0.2)
* Dart 2.17.3
* Cocoapods 1.11.3

### [Article](#article)
* [`Flutter x Clean Architecture`](https://dubydu.medium.com/b53ce9e19d5a)

### [Main Packages](#main-packages)
* [`flutter_bloc`](https://pub.dev/packages/flutter_bloc): State management package.
* [`dio`](https://pub.dev/packages/dio): A powerful Http client for Dart.
* [`get_it`](https://pub.dev/packages/get_it): A Service Locator for Dart and Flutter projects.
* [`mockito`](https://pub.dev/packages/mockito): A mock framework with APIs for Fakes, Mocks, behavior verification, and stubbing.

### [Usage](#usage)

#### Run App with a specific environment.
* Development: `flutter run -t lib/main_dev.dart`
* Production: `flutter run -t lib/main_prod.dart`


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
│       │   └── app_config.dart
│       ├── data
│       │   ├── api
│       │   │   ├── api_client
│       │   │   │   ├── error
│       │   │   │   │   └── error.dart 
│       │   │   │   ├── interceptor
│       │   │   │   │   ├── curl_log.dart
│       │   │   │   │   └── query.dart
│       │   │   │   ├── api_client.dart
│       │   │   │   ├── api_client.g.dart
│       │   │   │   └── api_client_type.dart 
│       │   │   ├── request
│       │   │   │   ├── dummy_request.dart
│       │   │   │   └── dummy_request.g.dart
│       │   │   └── response
│       │   │       ├── dummy_response.dart
│       │   │       └── dummy_response.g.dart
│       │   ├── datasource
│       │   │   └── dummy
│       │   │       ├── dummy_datasource.dart
│       │   │       └── dummy_datasource_type.dart
│       │   └── repository
│       │   │   └── dummy
│       │   │       ├── dummy_repository.dart
│       │   │       └── dummy_repository_type.dart
│       ├── di
│       │   └── service_locator.dart
│       ├── domain
│       │   ├── model
│       │   │   ├── empty.dart
│       │   │   └── dummy.dart
│       │   ├── translator
│       │   │   └── dummy_translator.dart
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
│       │   ├── dummy
│       │   │   ├── dummy_page.dart
│       │   │   └── dummy_bloc.dart
│       ├── router
│       │   ├── gen_route.dart
│       │   ├── named_route.dart
│       │   ├── navigation_controller.dart
│       │   ├── navigation_observer.dart
│       │   └── routes.dart
│       ├── util
│       │   ├── assets
│       │   │   ├── app_color.dart
│       │   │   ├── app_icon.dart
│       │   │   ├── app_image.dart
│       │   │   ├── app_locale.dart
│       │   │   └── app_text.dart
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
    │   └── usecase
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

### [Pitfalls](#pitfalls)
- Make sure `flutter pub get` before you run the app.