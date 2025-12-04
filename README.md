# FindMinds

A comprehensive Flutter application connecting individuals and companies, featuring a robust portal for managing professional profiles, job opportunities, and commercial registrations.

## Features

- **Authentication**: Secure user login and registration using Supabase.
- **Individuals Portal**: 
  - Manage personal profiles.
  - Showcase work experience and education.
  - Upload and manage certifications.
- **Company Portal**: 
  - Manage company profiles.
  - Post and manage job opportunities.
- **Commercial Registration (CR) Info**: Integration for verifying and displaying business details.
- **Payments**: Secure payment processing integration.

## Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **Language**: [Dart](https://dart.dev/)
- **State Management**: [Flutter Bloc](https://pub.dev/packages/flutter_bloc)
- **Backend**: [Supabase](https://supabase.com/)
- **Navigation**: [GoRouter](https://pub.dev/packages/go_router)
- **Dependency Injection**: [GetIt](https://pub.dev/packages/get_it) & [Injectable](https://pub.dev/packages/injectable)
- **Code Generation**: [Freezed](https://pub.dev/packages/freezed) & [JSON Serializable](https://pub.dev/packages/json_serializable)
- **UI/UX**: 
  - [Flutter ScreenUtil](https://pub.dev/packages/flutter_screenutil) for responsiveness.
  - [Google Fonts](https://pub.dev/packages/google_fonts).

## Folder Structure

```
lib/
├── core/           # Core utilities, theme, router, and DI setup
├── features/       # Feature-based modules
│   ├── auth/            # Authentication logic and UI
│   ├── company_portal/  # Company-specific features
│   ├── individuals/     # Individual user features
│   ├── payment/         # Payment integration
│   └── CRinfo/          # Commercial Registration info
└── main.dart       # Application entry point
```

## Preview 

this project is currently a work in progress..

<img width="490" height="912" alt="image" src="https://github.com/user-attachments/assets/db0d8c2e-9362-49db-99d0-4a1a375781a1" />
<img width="494" height="914" alt="image" src="https://github.com/user-attachments/assets/5ed3935a-f9e7-49ac-82ca-d973c1307ca0" />

