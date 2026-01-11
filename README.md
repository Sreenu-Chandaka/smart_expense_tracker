# Smart Expense Tracker 💰

A beautiful and intuitive Flutter application for tracking personal expenses with advanced features like favorites, pull-to-refresh, and comprehensive financial insights.

## 📱 Project Overview

Smart Expense Tracker is a feature-rich mobile application designed to help users manage their daily expenses efficiently. The app provides real-time insights into spending patterns, categorized expense tracking, and a clean, modern user interface.

### Key Features

- ✅ **Add/Edit/Delete Expenses** - Complete CRUD operations for expense management
- ✅ **Category-Based Tracking** - Organize expenses into 8 predefined categories
- ✅ **Favorites System** - Mark important expenses for quick access
- ✅ **Pull-to-Refresh** - Seamlessly refresh your expense list
- ✅ **Daily & Monthly Summaries** - Real-time calculation of spending totals
- ✅ **Category Breakdown** - Visual breakdown of spending by category
- ✅ **Persistent Storage** - Local data storage using Hive database
- ✅ **Modern UI/UX** - Clean, intuitive interface with smooth animations
- ✅ **Date Selection** - Pick custom dates for expense entries
- ✅ **Notes Support** - Add optional notes to expenses for context

### Categories Supported

- 🍔 Food
- 🚗 Transport
- 🛍️ Shopping
- 🎬 Entertainment
- 📄 Bills
- 🏥 Health
- 📚 Education
- 📦 Other

## 🏗️ Architecture and State Management

### Architecture Pattern: BLoC (Business Logic Component)

The application follows the **BLoC pattern** for state management, ensuring:
- Clear separation of business logic from UI
- Predictable state changes
- Easy testability
- Scalable codebase

### Project Structure

```
lib/
├── models/
│   ├── expense.dart              # Expense data model with Hive annotations
│   └── expense.g.dart            # Generated Hive adapter
├── bloc/
│   ├── expense_bloc.dart         # BLoC implementation
│   ├── expense_event.dart        # Event definitions
│   └── expense_state.dart        # State definitions
├── screens/
│   ├── home_screen.dart          # Main expense list screen
│   └── add_expense_screen.dart   # Add/Edit expense form
├── widgets/
│   └── expense_item.dart         # Individual expense card widget
└── main.dart                     # App entry point
```

### State Management Flow

```
UI (User Action) 
    ↓
Event (AddExpense, UpdateExpense, etc.)
    ↓
BLoC (Business Logic)
    ↓
Hive Database (Persistent Storage)
    ↓
State (ExpenseLoaded, ExpenseError, etc.)
    ↓
UI Update (Rebuild with new data)
```

### Key Technologies

- **Flutter SDK** - Cross-platform UI framework
- **flutter_bloc** - State management library
- **Hive** - Lightweight, fast NoSQL database
- **Equatable** - Value equality for BLoC events and states
- **intl** - Internationalization and date formatting

### Data Persistence

The app uses **Hive** for local data storage:
- Type-safe storage with generated adapters
- Fast read/write operations
- No SQL required
- Encrypted storage support (can be added)
- Automatic data serialization

## 🚀 Steps to Run the Project

### Prerequisites

1. **Flutter SDK** (3.0.0 or higher)
   ```bash
   flutter --version
   ```

2. **Dart SDK** (3.0.0 or higher)

3. **Android Studio / VS Code** with Flutter plugins

4. **Android Emulator / iOS Simulator / Physical Device**

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd smart_expense_tracker
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate Hive adapters**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
   This generates the `expense.g.dart` file needed for Hive serialization.

4. **Fix the generated adapter (Important!)**
   
   Open `lib/models/expense.g.dart` and modify line 25:
   
   **Change from:**
   ```dart
   isFavorite: fields[5] as bool,
   ```
   
   **To:**
   ```dart
   isFavorite: fields[5] as bool? ?? false,
   ```
   
   This ensures backward compatibility with existing data.

5. **Run the app**
   ```bash
   flutter run
   ```

### Build for Production

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle:**
```bash
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

## 🔧 Configuration

### Initialize Hive

The app automatically initializes Hive on startup. If you need to customize the storage location or add encryption:

```dart
// In main.dart
await Hive.initFlutter();
Hive.registerAdapter(ExpenseAdapter());
```

### Clear Data (Optional)

To reset all data during development:
```dart
await Hive.deleteBoxFromDisk('expenses');
```

## 📋 Assumptions

1. **Single User**: The app is designed for personal use by a single user
2. **Local Storage Only**: All data is stored locally on the device
3. **INR Currency**: Expenses are tracked in Indian Rupees (₹)
4. **Predefined Categories**: Categories are fixed and cannot be customized by users
5. **Date Range**: Expenses can only be added for dates from 2020 onwards up to today
6. **No Authentication**: No login/signup required as data is local
7. **No Cloud Sync**: Data is not synced across devices

## 🚧 Future Improvements

### High Priority

1. **Export Functionality**
   - Export expenses to CSV/PDF
   - Email/share expense reports
   - Generate monthly statements

2. **Budget Management**
   - Set monthly/category budgets
   - Budget alerts and notifications
   - Budget vs. actual spending charts

3. **Advanced Analytics**
   - Interactive charts (pie charts, line graphs, bar charts)
   - Spending trends over time
   - Year-over-year comparisons
   - Expense forecasting

4. **Search & Filter**
   - Search expenses by note/amount
   - Filter by date range
   - Filter by multiple categories
   - Sort options (date, amount, category)

### Medium Priority

5. **Custom Categories**
   - User-defined categories
   - Category icons and colors
   - Category management screen

6. **Recurring Expenses**
   - Set up recurring transactions
   - Auto-add monthly bills
   - Subscription tracking

7. **Multi-Currency Support**
   - Support for multiple currencies
   - Currency conversion
   - Exchange rate updates

8. **Dark Mode**
   - System-based theme switching
   - Manual theme selection
   - AMOLED dark mode option

### Low Priority

9. **Cloud Backup & Sync**
   - Firebase/Supabase integration
   - Cross-device synchronization
   - Automatic cloud backups

10. **Biometric Security**
    - Fingerprint/Face ID lock
    - PIN protection
    - Encrypted storage

11. **Receipt Scanning**
    - OCR for receipt scanning
    - Auto-populate expense details
    - Attach receipt images

12. **Widgets**
    - Home screen widgets
    - Quick add expense widget
    - Spending summary widget

13. **Localization**
    - Multi-language support
    - Regional date/number formats
    - Currency symbols

14. **Social Features**
    - Share expenses with family
    - Split bills with friends
    - Group expense tracking

## 🐛 Known Issues

1. **Migration Handling**: When adding the `isFavorite` field, existing data requires manual adapter fix (documented in setup steps)
2. **No Undo**: Deleted expenses cannot be recovered (planned for future)

## 🚀 Publishing to GitHub

If you want to publish this project to your own GitHub repository:

1. **Create a new repository on GitHub** (don't initialize with README)

2. **Initialize local git repository**
   ```bash
   git init
   git add .
   git commit -m "Initial commit: Smart Expense Tracker"
   ```

3. **Connect to your GitHub repository**
   ```bash
   git remote add origin https://github.com/your-username/your-repo-name.git
   git branch -M main
   git push -u origin main
   ```

4. **Future updates**
   ```bash
   git add .
   git commit -m "Your commit message"
   git push
   ```

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Developer

Built with ❤️ using Flutter

---

**Version**: 1.0.0  
**Last Updated**: January 2026  
**Flutter Version**: 3.x  
**Minimum SDK**: Android 21+ / iOS 12+