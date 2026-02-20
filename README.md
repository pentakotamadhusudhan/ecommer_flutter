# 📱 Local Baba

**Empowering local communities, one tap at a time.**

Local Baba is a mobile-only platform designed to connect users with local vendors, artisans, and service providers. Built with a mobile-first philosophy, it ensures that neighborhood commerce is fast, accessible, and community-driven.

---

## ✨ Key Features

* **Hyper-Local Search:** Discover hidden gems and essential services within your immediate vicinity.
* **Vendor Profiles:** View portfolios, price lists, and operating hours for local businesses.
* **Seamless Communication:** In-app messaging to chat directly with "Babas" (local experts/vendors).
* **Live Tracking:** Keep track of service deliveries or find the exact street location of mobile vendors.
* **Offline Mode:** Cache local directory data for use in areas with poor connectivity.

---

## 🛠 Tech Stack

| Component | Technology |
| :--- | :--- |
| **Framework** | Flutter  |
| **Language** | Python,Dart |
| **Backend** | Django |
| **Database** | MySql |
| **Maps** | Google Maps SDK |

---

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:
* [e.g., Flutter SDK / Node.js]
* Android Studio (for Android Emulator) or Xcode (for iOS Simulator)
* A valid API Key for Google Maps

### Installation

1.  **Clone the Repository**
    ```bash
    git clone [https://github.com/yourusername/local_baba.git](https://github.com/yourusername/local_baba.git)
    cd local_baba
    ```

2.  **Install Dependencies**
    ```bash
    # For Flutter
    flutter pub get

    # For React Native
    npm install
    ```

3.  **Configure Environment**
    Create a `.env` file in the root directory:
    ```env
    API_KEY=your_google_maps_key
    BASE_URL=[https://api.localbaba.com](https://api.localbaba.com)
    ```

4.  **Run the Application**
    ```bash
    # For Android
    flutter run / npx react-native run-android

    # For iOS
    flutter run / npx react-native run-ios
    ```

---

## 📱 UI Preview

| Onboarding | Discovery | Vendor Chat |
| :---: | :---: | :---: |
| ![Screen 1](https://via.placeholder.com/150x300?text=Welcome) | ![Screen 2](https://via.placeholder.com/150x300?text=Map+View) | ![Screen 3](https://via.placeholder.com/150x300?text=Messenger) |


---

## 📜 License

Distributed under the MIT License. See `LICENSE` for more information.

---

> **Note:** This repository is strictly for the mobile client. For the admin dashboard or backend API, please refer to the `local_baba_backend` repository.
