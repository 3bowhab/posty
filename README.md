# Posty

A production-ready, highly responsive Flutter application for seamless post and comment management.
Built on top of the JSONPlaceholder REST API with a strong focus on scalability, offline-first behavior, and polished UI/UX.

---

## ✨ Overview

Posty demonstrates modern Flutter engineering practices through:

* Feature-Based Modular Architecture
* MVVM Pattern with Provider
* Offline-First Data Handling
* Pagination & Local Search
* Firebase Authentication
* Google Sign-In
* Dark/Light Theme Support
* Arabic & English Localization
* Responsive UI Across Devices

---

## 🚀 Live Demo & Download

You can download and test the latest production-ready APK directly on your Android device via Firebase App Distribution:

👉 **[Download Posty App (Firebase Distribution)](https://appdistribution.firebase.dev/i/a491030c38786a2b)**

> 💡 **Note:** Clicking the link will invite you to the testers group. You will just need to sign in with your Google account to access the direct download.

---

### 🎬 Application Demo

Watch the complete walkthrough of the application showcasing the user flow, authentication, offline behavior, and UI interactions:

📺 **[Watch the Demo Video on Google Drive](https://drive.google.com/file/d/1_sUy6LVgTtWVV1hcQfzyeQbe2Bf26yRS/view?usp=drive_link)**

---

## 📱 Application Preview

### Main Functionalities

* Native Splash Screen
* Firebase Authentication
* Google Sign-In
* Posts Feed with Pagination
* Post Details & Comments
* Create New Post
* Offline Cache Recovery
* Local Search Filtering
* Theme Switching
* Localization (EN / AR)

---

# 🏗️ Architecture

The project follows a **Feature-Based Modular Architecture** with a strict separation between UI, business logic, and data layers.

```text
lib
│
├── core
├── data
├── features
├── providers
└── main.dart
```

---

## 📦 Layer Breakdown

### 🔹 Core

Contains shared global resources and reusable utilities:

* App themes
* Responsive utilities
* Validators
* Shared widgets
* Constants
* Design tokens

---

### 🔹 Data

Responsible for all data-related operations:

* Dio API services
* Hive local storage
* JSON serialization
* Firebase integrations
* Offline caching logic

---

### 🔹 Features

Each feature is fully isolated and self-contained.

#### Current Features:

* Auth
* Main Posts Module

Each feature contains:

* Views
* ViewModels
* Widgets
* Models
* Services

---

### 🔹 Providers

Global state management layer using `Provider` and `ChangeNotifier`.

Handles:

* Theme mode
* Localization
* App-wide reactive states

---

# 🧠 State Management

The app follows the **MVVM Architecture Pattern** using:

* `Provider`
* `ChangeNotifier`

### Advantages

* Clean separation of concerns
* Reactive UI updates
* Testable business logic
* Scalable codebase structure

---

# 🌐 Offline-First Architecture

The application is designed to continue functioning even during network failures.

## Features

### ✅ Smart Local Caching

* Powered by Hive
* Stores posts locally
* Automatically restores cached content during connection failures

### ✅ Optimized Networking

* Built using Dio
* Timeout handling
* Request interceptors
* Error handling

### ✅ Infinite Pagination

* Prevents unnecessary memory usage
* Improves loading performance

### ✅ Local Search Engine

* In-memory filtering
* Searches through titles & bodies instantly
* No additional API requests

---

# 🎨 UI & UX Features

## 🌙 Dynamic Theme Support

* Light Mode
* Dark Mode
* Persistent theme preference

---

## 🌍 Localization

Supports:

* English 🇺🇸
* Arabic 🇪🇬

Implemented using Flutter localization with ARB files.

---

## 📱 Responsive Design

Adaptive sizing system for:

* Small devices
* Tablets
* Different screen resolutions

---

# 🔐 Authentication

Integrated with Firebase services:

* Firebase Authentication
* Cloud Firestore
* Google Sign-In

---

# 📚 Packages Used

| Package                  | Purpose                  |
| ------------------------ | ------------------------ |
| `provider`               | State management         |
| `dio`                    | API communication        |
| `hive` & `hive_flutter`  | Local caching            |
| `shared_preferences`     | Persisting app settings  |
| `firebase_core`          | Firebase initialization  |
| `firebase_auth`          | Authentication           |
| `cloud_firestore`        | Cloud database           |
| `google_sign_in`         | OAuth login              |
| `google_fonts`           | Dynamic typography       |
| `toastification`         | Toast notifications      |
| `flutter_native_splash`  | Native splash generation |
| `flutter_launcher_icons` | App icon generation      |

---

# 🔌 REST API Endpoints

Base API: `https://jsonplaceholder.typicode.com`

| Method | Endpoint | Description |
|---|---|---|
| GET | `/posts?_page={page}&_limit={limit}` | Retrieves paginated posts |
| GET | `/comments?postId={id}` | Retrieves comments for a specific post |
| POST | `/posts` | Creates a new post |

---

### Query Parameters

| Endpoint | Parameter | Type | Description |
|---|---|---|---|
| `/posts` | `_page` | int | Page number |
| `/posts` | `_limit` | int | Number of records per page |
| `/comments` | `postId` | int | Target post identifier |

---

### POST Request Body

| Field | Type | Description |
|---|---|---|
| `title` | String | Post title |
| `body` | String | Post content |
| `userId` | int | Author identifier |

---

### Example Requests

| Endpoint | Example Request |
|---|---|
| `GET /posts` | `https://jsonplaceholder.typicode.com/posts?_page=1&_limit=2` |
| `GET /comments` | `https://jsonplaceholder.typicode.com/comments?postId=1` |
| `POST /posts` | `https://jsonplaceholder.typicode.com/posts` |

---

### Example Responses

| Endpoint | Example Response |
|---|---|
| `GET /posts` | `[ { "id": 1, "title": "...", "body": "...", "userId": 1 } ]` |
| `GET /comments` | `[ { "postId": 1, "id": 1, "name": "...", "email": "...", "body": "..." } ]` |
| `POST /posts` | `{ "id": 101, "title": "foo", "body": "bar", "userId": 1 }` |

---

# 🚀 Getting Started

## Prerequisites

Make sure you have installed:

* Flutter SDK `^3.11.5`
* Dart SDK compatible with Flutter version

---

# ⚙️ Installation

## 1️⃣ Clone Repository

```bash
git clone <repository-public-url>
cd posty
```

---

## 2️⃣ Install Dependencies

```bash
flutter pub get
```

---

## 3️⃣ Generate Localization Files

```bash
flutter gen-l10n
```

---

## 4️⃣ Run Application

```bash
flutter run
```

---

# 📦 Build Release APK

```bash
flutter build apk --release
```

Generated APK path:

```text
build/app/outputs/flutter-apk/app-release.apk
```

---

# 🛠️ Technical Highlights

* Clean Architecture Principles
* Feature Modularization
* Offline-First Strategy
* Responsive UI System
* Scalable MVVM Structure
* Firebase Integration
* Efficient Pagination
* Local Data Persistence
* Modern Flutter Best Practices

---

# 👨‍💻 Author

## Ali Ibrahim Abdelwahab
Flutter Developer

- GitHub: [3bowhab](https://github.com/3bowhab)
- LinkedIn: [Ali Abdelwahab](https://www.linkedin.com/in/aliabdelwahab/)

