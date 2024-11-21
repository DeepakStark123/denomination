
# Denomination App

A Flutter application designed to simplify cash denomination calculations and manage transaction records with ease. The app is offline-capable and uses `sqflite` for local data storage.

## Features

### 1. **Currency Denomination Calculator**
- Enter the count of various currency denominations (₹2000, ₹500, ₹200, ₹100, etc.).
- Automatically calculates the total value for each denomination and the grand total.
- Provides a clear and easy-to-use layout for quick calculations.

### 2. **History Management**
- Save your calculated denominations with remarks and category tags.
- View previously saved entries in a structured history section.
- Perform actions on history items:
  - **Edit**: Modify the saved entries as needed.
  - **Delete**: Remove specific entries from history.
  - **Share**: Share the denomination breakdown with others via supported apps.

### 3. **Save and Organize Data**
- Categorize denominations into different groups (e.g., General, Personal, Business).
- Add remarks for context or additional notes before saving.
- Uses the `sqflite` database for efficient offline data storage.

### 4. **Dynamic Controls**
- Quickly clear all input fields with the **Clear** button.
- Use the **Save** button to securely store calculations.
- Access saved records via the floating **History** button for easy navigation.

### 5. **Dark-Themed User Interface**
- Minimalistic and professional dark theme for enhanced usability.
- Floating action buttons for quick access to frequently used features.

### 6. **Media Player Integration**
- Embedded media player, potentially for voice notes or other transaction-related instructions.
- Play, pause, and navigate through recordings seamlessly.

---

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/your-username/denomination_app.git
   ```
2. Navigate to the project directory:
   ```bash
   cd denomination_app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

---

## Technology Stack

- **Framework:** Flutter
- **Database:** `sqflite` for local data storage
- **State Management:** GetX (if applicable)
- **Programming Language:** Dart

---

## Future Enhancements

- **Cloud Backup and Sync:** Add cloud storage to sync data across devices.
- **Search and Filter in History:** Enable quick lookup of saved records based on date, category, or amount.
- **Multi-Language Support:** Support for multiple languages to cater to diverse users.
- **Export Feature:** Export transaction records as CSV or PDF files.
- **Custom Denominations:** Allow users to add custom currency denominations.

---

## Contributing

Contributions are welcome! Follow these steps to contribute:
1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add feature-name"
   ```
4. Push to the branch:
   ```bash
   git push origin feature-name
   ```
5. Create a Pull Request.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
