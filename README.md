# TaskFlow (UIKit · MVVM · Clean Architecture)

**TaskFlow** is a mobile application built with UIKit, designed to manage tasks between users using unique, randomly generated user codes. It demonstrates a scalable, professional architecture suitable for MVP development and future expansion.

The app allows users to authenticate, view their assigned tasks, and create new tasks for others by using their unique user identifier. It also implements **Local Notifications** to keep users updated on their tasks.  

Demo de la aplicación: 
- [demo](https://youtu.be/lpxKXeqR7zU)

### Screens Overview

**Login & Authentication**

Login screen:  
<img width="201" height="437" alt="login" src="https://github.com/user-attachments/assets/79813fad-9f23-42f0-beb1-b5e61c0b817a" />

Create account screen:  
<img width="201" height="437" alt="signup" src="https://github.com/user-attachments/assets/82a609b9-ac6d-401c-a138-735c990c27ae" />

Forgot password screen:  
<img width="201" height="437" alt="forgotpassword" src="https://github.com/user-attachments/assets/1d4886c6-4f79-4a2c-85e5-953967508204" />

**Home (Task List)**  
<img width="201" height="437" alt="home" src="https://github.com/user-attachments/assets/afdc2ef8-609e-4fd5-a82b-d7bf896dc2a7" />

**Tasks**  

Create task screen:  
<img width="201" height="437" alt="createTask" src="https://github.com/user-attachments/assets/6aafd666-9817-44ea-bc64-b5ac8e344a72" />

Detail task screen:  
<img width="201" height="437" alt="detailTask" src="https://github.com/user-attachments/assets/15d30105-c5f1-4623-9318-336ac2f8e146" />

---

## Tech Stack 🚀

- **Language:** Swift
- **UI Framework:** UIKit (Programmatic & Storyboards)
- **Architecture:** MVVM + Clean-ish Layers (Domain / Data / Presentation)
- **Navigation:** Coordinators (AppCoordinator, HomeCoordinator, etc.)
- **Local Data:** UserDefaults / CoreData (for MVP persistence)
- **Notifications:** UserNotifications (Local Notifications)
- **Testing:** XCTest (UI Tests)
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
    - Alerts when the request are successfully.
- **Clean Architecture:**
    - Separation of concerns (Data, Domain, Presentation).
    - UseCase-driven logic.

## Project Vision & Goals ✅

- **Clean Architecture:** Clear separation between `Presentation` (VC/VM), `Domain` (UseCases, Entities), and `Data` (Repositories).
- **Scalability:** Ready for new flows of inyection of new screens.
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

- [ ] Create new list where you can see the task and the status of the task that you assign to other user.
- [ ] Implement Push Notifications.
- [ ] Add task filtering and sorting.
- [ ] Unit test, the UI Test is correctly implemented but in this case the Unit test is pending to implement.
- [ ] Functionallity to pick a user code from the list stored in persistence to assign a task to a user. 

---
*Created with ❤️ by IandelaTorre*
