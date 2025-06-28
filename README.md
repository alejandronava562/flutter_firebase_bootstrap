# 🛒 54321 Grocery Planner

A Flutter & Firebase–powered mobile app to plan your weekly groceries using the “5-4-3-2-1” method:  
choose 5 veggies, 4 fruits, 3 proteins, 2 carbs, and 1 treat.

---

## Features

- 🔐 **Email/Password Authentication** with Firebase Auth  
- ☁️ **Cloud Firestore** for per-user grocery lists  
- 📋 Category-based item entry (Veggies, Fruits, Proteins, Carbs, Treat)  
- ✅ Real-time add/delete/update of items  
- 🔄 Review screen to confirm your final list  
- 📱 Responsive UI & smooth navigation flow  

---

## Screens

| Screen         | Description                              |
| -------------- | ---------------------------------------- |
| **Login / Register** | Sign up or sign in with email & password |
| **Home**             | Overview of 5 categories & progress bars |
| **Category**         | Add / remove items for a single food group |
| **Review**           | Display full “5-4-3-2-1” list before saving |
| **AuthGate**         | Routes user to Login or Home based on auth state |

---

## Tech Stack

- **Flutter** (>= 3.0)  
- **Dart**  
- **Firebase Authentication**  
- **Cloud Firestore**  
- State management via `StatefulWidget` + local setState  
- Code organized into `services`, `widgets`, `screens`

---

## Author & Contact
Alejandro Nava Aldana Jr. : 
✉️ navaalejandro562@gmail.com