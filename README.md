# TaskFlow (UIKit · MVVM · Clean Architecture)

**TaskFlow** is a mobile application built with UIKit, designed to manage tasks between users using unique, randomly generated user codes. It demonstrates a scalable, professional architecture suitable for MVP development and future expansion.

The app allows users to authenticate, view their assigned tasks, and create new tasks for others by using their unique user identifier. It also implements **Local Notifications** to keep users updated on their tasks.

### Screens Overview

**Login & Authentication**
<!-- Add screenshot here -->
*Secure login flow with account creation and password recovery.*

**Home (Task List)**
<!-- Add screenshot here -->
*Overview of assigned tasks with status badges (Pending/Completed).*

**Create Task**
<!-- Add screenshot here -->
*Interface to assign new tasks to other users via their unique code.*

---

## Tech Stack 🚀

- **Language:** Swift
- **UI Framework:** UIKit (Programmatic & Storyboards)
- **Architecture:** MVVM + Clean-ish Layers (Domain / Data / Presentation)
- **Navigation:** Coordinators (AppCoordinator, HomeCoordinator, etc.)
- **Local Data:** UserDefaults / CoreData (for MVP persistence)
- **Notifications:** UserNotifications (Local Notifications)
- **Testing:** XCTest (Unit and UI Tests)
- **Dependency Injection:** DIContainer

## Features 🧩

- **User System:**
    - Unique 6-digit user code generation upon sign-up.
    - Password recovery flow.
- **Task Management:**
    - Create tasks with title, description, and status.
    - Assign tasks to other users via their User Code.
    - Mark tasks as "Completed".
- **Local Notifications:**
    - Alerts when tasks are assigned or due (MVP implementation).
- **Clean Architecture:**
    - Separation of concerns (Data, Domain, Presentation).
    - UseCase-driven logic.

## Project Vision & Goals ✅

- **Clean Architecture:** Clear separation between `Presentation` (VC/VM), `Domain` (UseCases, Entities), and `Data` (Repositories).
- **Scalability:** Ready for remote API integration without rewriting the UI.
- **Testability:** Decoupled components make writing Unit Tests for ViewModels and UseCases straightforward.
- **User Experience:** Modern, minimalist iOS design with clear typography and hierarchy.

## Project Structure 🗂

```text
TaskFlow/
├── App/                  # AppDelegate, SceneDelegate, AppCoordinator, DIContainer
├── Presentation/         # Modules (MVVM):
│   ├── Login/            # Auth flow (Login, SignUp, Recovery)
│   ├── Home/             # Main flow (TaskList, CreateTask, TaskDetails)
│   └── Shared/           # Reusable UI components & Extensions
├── Domain/               # Business Logic:
│   ├── Entities/         # Core models (User, Task)
│   ├── UseCases/         # Application specific business rules
│   └── Interfaces/       # Repository protocols
├── Data/                 # Data Layer:
│   ├── Repositories/     # Implementations (Mock / Persistance)
│   └── Network/          # API Services (if applicable)
├── Resources/            # Assets, Fonts, LaunchScreen
└── Tests/                # Unit Tests (XCTest)
```

## How to Run 🛠️

1.  **Clone the implementation:**
    ```bash
    git clone https://github.com/IandelaTorre/TaskFlow.git
    ```
2.  **Open in Xcode:**
    - Double click `TaskFlow.xcodeproj`.
3.  **Run:**
    - Select a simulator (e.g., iPhone 15 Pro Max).
    - Press `Cmd + R` or click the Play button.

## Tests Included 🧪

- **TaskFlowTests:** Unit tests for UseCases and ViewModels.
- **TaskFlowUITests:** Basic UI navigation tests.

To run tests, press `Cmd + U` in Xcode.

## Authors ✒️

**Ian Axel de la Torre** - *iOS Developer* - [IandelaTorre](https://github.com/IandelaTorre)

## Next Steps / Improvements 📈

- [ ] Add "My Created Tasks" view to see tasks assigned to others.
- [ ] Implement Push Notifications.
- [ ] Add task filtering and sorting.

---
*Created with ❤️ by IandelaTorre*
