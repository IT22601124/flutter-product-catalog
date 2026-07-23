# Product Catalogue Application

A polished Flutter application that displays a product catalogue fetched from the Fake Store API. This project demonstrates Flutter fundamentals, state management using Provider, API integration, and clean architecture.

## Project Overview
The application allows users to:
- Browse a grid of products with images, names, prices, and categories.
- Search for products by name with real-time updates.
- View detailed information for each product.
- Mark products as favorites, with status synced across screens and persisted locally.
- Switch between Light and Dark themes with preference persistence.
- Handle loading, error (with retry), and empty states gracefully.

## Setup Instructions

### Prerequisites
- Flutter SDK (stable channel)
- Android Studio / VS Code with Flutter extension
- An Android/iOS emulator or physical device

### Installation
1. Clone the repository.
2. Navigate to the project directory:
   ```bash
   cd product_catalog
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```

### Running the Project
To run the app in debug mode:
```bash
flutter run
```

### Building APK
To build a release APK:
```bash
flutter build apk --release
```
The APK will be located at `build/app/outputs/flutter-apk/app-release.apk`.

## Architecture
The project follows a layered architecture to ensure separation of concerns and maintainability:

- **Models**: Data classes (e.g., `Product`) with JSON serialization.
- **Repositories**:
  - `ApiService`: Handles API communication logic using Dio.
  - `ProductRepository`: Acts as a single source of truth for data.
- **HTTP Client**:
  - `httpClient/DioClient`: Centralized configuration for the Dio network client.
- **Constants**:
  - `AppConstants`: Centralized storage for API URLs and preference keys.
- **State Management (Providers)**:
  - `ProductProvider`: Manages product list, search filtering, and loading/error states.
  - `FavoriteProvider`: Manages user favorites and handles persistence via `shared_preferences`.
  - `ThemeProvider`: Manages theme switching and persistence.
- **UI Layer**:
  - **Screens**: High-level pages (`ProductListScreen`, `ProductDetailScreen`).
  - **Widgets**: Reusable UI components (`ProductCard`, `FavoriteButton`).
  - **Theme**: Centralized theme definitions using Material 3 and Google Fonts (Poppins).

## Assumptions
- The Fake Store API is stable and accessible.
- A simple `Set<int>` is sufficient for managing favorites since we only store IDs.
- `shared_preferences` is used for persistence as per the "simple local backend" suggestion.

## Challenges & Solutions
- **Image Loading**: Used `cached_network_image` to provide a better UX with placeholders and caching, preventing flickering on scroll.
- **Search Logic**: Implemented substring matching in the `ProductProvider` to keep the UI responsive while typing.
- **UI Polishing**: Used `Hero` animations for smooth transitions between list and detail views.

## Future Improvements
- Implement pagination or infinite scroll for larger datasets.
- Add unit and widget tests for better code coverage.
- Implement a more robust offline mode using a local database like Hive or Sqflite.
- Add localized support for multiple languages.
