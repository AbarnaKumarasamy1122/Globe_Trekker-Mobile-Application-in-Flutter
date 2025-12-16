# Globe Trekker 🌍

A Flutter application for exploring countries around the world. Browse through 250+ countries, view detailed information, filter by region, search, and maintain a personal bucket list of places to visit.

## Project Description

Globe Trekker is a cross-platform mobile and web application that allows users to:
- Browse all countries worldwide with flags and basic information
- Filter countries by region (Africa, Americas, Asia, Europe, Oceania)
- Search countries by name or capital
- View detailed country information (population, currency, phone code, capital)
- Add countries to a personal bucket list
- Add notes for each country
- Toggle between light and dark themes

## Instructions to Run

### Prerequisites
- Flutter SDK (3.0 or higher)
- Chrome browser (for web), Android Studio/Xcode (for mobile)

### Installation & Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd globe_trekker
```

2. Install dependencies:
```bash
flutter pub get
```

3. Generate required files (Hive adapters):
```bash
dart run build_runner build --delete-conflicting-outputs
```

4. Run the application:
```bash
# For web
flutter run -d chrome

# For Android
flutter run -d <device-id>

# For iOS
flutter run -d <device-id>
```

## State Management

The app uses **Provider** pattern for state management:

- **CountryController**: Manages country data, search, filtering, and sorting
  - Handles API calls to fetch country data
  - Applies filters (region-based filtering)
  - Implements search functionality
  - Manages sorting options

- **BucketListController**: Manages user's bucket list
  - Adds/removes countries from bucket list
  - Persists data using Hive local database
  - Provides real-time updates to UI

- **ThemeController**: Manages app theme
  - Toggles between light and dark mode
  - Persists theme preference

All controllers extend `ChangeNotifier` and notify listeners when state changes, triggering UI updates automatically.

## Architecture Overview

The project follows a **clean architecture** pattern with clear separation of concerns:

```
lib/
├── main.dart                 # App entry point
├── app.dart                  # MaterialApp configuration
├── models/                   # Data models
│   ├── country_model.dart    # Country entity with region detection
│   └── bucket_list_item.dart # Bucket list entity
├── controllers/              # State management (Provider)
│   ├── country_controller.dart
│   ├── bucket_list_controller.dart
│   └── theme_controller.dart
├── api/                      # Network layer
│   ├── api_client.dart       # HTTP client wrapper
│   ├── api_service.dart      # Country API service
│   └── api_exceptions.dart   # Custom exceptions
├── db/                       # Local storage
│   ├── hive_service.dart     # Hive database service
│   └── repositories/         # Data repositories
├── screens/                  # UI screens
│   ├── home_screen.dart      # Country list view
│   ├── country_detail_screen.dart
│   ├── bucket_list_screen.dart
│   └── splash_screen.dart
├── widgets/                  # Reusable UI components
│   ├── country_card.dart     # Country list item
│   ├── filter_dialog.dart    # Region filter dialog
│   └── search_bar.dart       # Search input
├── navigation/               # Routing
│   └── app_router.dart       # Route definitions
└── utils/                    # Utilities
    ├── constants.dart        # App constants
    ├── helpers.dart          # Helper functions
    └── theme.dart            # Theme definitions
```

### Key Features

- **Region Detection**: Countries are automatically assigned regions based on ISO country codes
- **Image URL Validation**: Filters out malformed image URLs from API
- **Offline Storage**: Uses Hive for local data persistence
- **Responsive Design**: Adapts to different screen sizes
- **Error Handling**: Graceful error handling with user-friendly messages

### Data Flow

1. User interacts with UI (screens/widgets)
2. UI calls methods on controllers
3. Controllers fetch data from API or local database
4. Controllers update state and notify listeners
5. UI rebuilds automatically with new data

### External Dependencies

- `http`: API requests
- `provider`: State management
- `hive`: Local database
- `cached_network_image`: Image caching (optional)

## Screenshots

| Home Screen                | Country Detail              | Filter Dialog               |
|---------------------------|-----------------------------|-----------------------------|
| ![Home](lib/screenshots/2 homescreen.png) | ![Detail](lib/screenshots/3 countrydetailsscreen.png) | ![Filter](lib/screenshots/filter.png) |

You can add more screenshots by placing them in the `lib/screenshots` folder and referencing them here.

---

**API Source**: [SampleAPIs Countries API](https://api.sampleapis.com/countries/countries)
