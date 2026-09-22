# RaceDay API Endpoint Plan

| HTTP Method | Route | Description | Role Required | Request Body | Expected Response |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **POST** | `/api/auth/register` | Register a new user | None (Public) | `{ fullName, email, password, role }` | 201 Created, User object |
| **POST** | `/api/auth/login` | Authenticate user, return JWT | None (Public) | `{ email, password }` | 200 OK, `{ token, user }` |
| **GET** | `/api/users/profile` | Get current user profile | Any (Logged in) | None | 200 OK, User object |
| **PUT** | `/api/users/profile` | Update current profile | Any (Logged in) | `{ fullName, email }` | 200 OK, Updated User |
| **GET** | `/api/events` | Browse all upcoming events | None (Public) | None | 200 OK, Array of Events |
| **GET** | `/api/events/{id}` | Get specific event details | None (Public) | None | 200 OK, Event object |
| **POST** | `/api/events` | Create a new event | Organiser | `{ eventName, description, eventDate, location }` | 201 Created, Event |
| **PUT** | `/api/events/{id}` | Update an event | Organiser | `{ eventName, description, eventDate, location }` | 200 OK, Updated Event |
| **DELETE** | `/api/events/{id}` | Delete an event | Organiser | None | 204 No Content |
| **GET** | `/api/events/{id}/categories` | Get categories for an event | None (Public) | None | 200 OK, Array of Categories |
| **POST** | `/api/events/{id}/categories` | Add category to event | Organiser | `{ categoryName, distanceKm, entryFee, maxParticipants }` | 201 Created, Category |
| **POST** | `/api/enrolments` | Enter an event | Participant | `{ categoryId }` | 201 Created, Enrolment |
| **GET** | `/api/enrolments/my` | View own enrolments | Participant | None | 200 OK, Array of Enrolments |
| **GET** | `/api/events/{id}/enrolments` | View event enrolments | Organiser | None | 200 OK, Array of Enrolments |
| **POST** | `/api/results` | Capture participant results | Organiser | `{ enrolmentId, finishTime, position }` | 201 Created, Result |
| **GET** | `/api/results/my` | Track personal results | Participant | None | 200 OK, Array of Results |
| **GET** | `/api/events/{id}/results` | View all event results | Organiser | None | 200 OK, Array of Results |
| **GET** | `/api/categories/{id}/route` | Get route and weather info | None (Public) | None | 200 OK, Route object |