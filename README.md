# Selera Kampung - A Restaurant Menu Package Booking App

Welcome to the Restaurant Menu Package Booking App! This application allows users to book restaurant menu packages for their events seamlessly. Both new and existing users can navigate through the app to register, book packages, and manage their bookings efficiently.

## Features

- **Front Page:** View the front page and menu packages.
- **Registration:** New users can register by providing a username and password.
- **Login:** Registered users can log in using their username and password.
- **User Profile:** Users can update their profile details (Name, email, phone, password).
- **Booking Form:** Fill in the booking form with details such as date, time, menu package, and number of guests.
- **View Bookings:** View booking details including date, time, menu package, and total price.
- **Manage Bookings:** Update or delete booking details.
- **Administrator Panel:** Admins can log in to view, update, and delete registered users and their bookings.

## Database Structure

### Database: restaurantpack

#### Table 1: users

| Column   | Type    |
|----------|---------|
| userid   | INTEGER |
| name     | TEXT    |
| email    | TEXT    |
| phone    | INTEGER |
| username | TEXT    |
| password | TEXT    |

#### Table 2: menubook

| Column       | Type    |
|--------------|---------|
| bookid       | INTEGER |
| userid       | INTEGER |
| bookdate     | DATE    |
| booktime     | TIME    |
| eventdate    | DATE    |
| eventtime    | TIME    |
| menupackage  | TEXT    |
| numguest     | INTEGER |
| packageprice | DOUBLE  |

#### Table 3: administrator

| Column   | Type    |
|----------|---------|
| adminid  | INTEGER |
| username | TEXT    |
| password | TEXT    |

## Requirements

### Users

#### Page 1 (Non-registered user)
1. Display the front page of the app.
2. View the menu packages.
3. Users are required to register (username and password).

#### Page 2 (Registered user)
1. Login (username and password).
2. Update the user's profile (Name, email, phone, password).

#### Page 3 (Registered user)
1. Fill in the booking form (Can choose more than one menu package).

#### Page 4 (Registered user)
1. View booking date and time.
2. View the event date, event time, menu package, number of guests, and total price.
3. Update and delete the booking date, event date/event time, menu package, and number of guests.

### Administrator
1. Login (username and password).
2. View all registered users (Name, menu package, book date/time, event date/time).
3. Update and delete registered users.
4. Logout.

## Validation Messages

- **Empty Field Alert:** Please fill in all required fields.
- **Booking Confirmation:** Your booking has been confirmed!
- **Total Price Display:** The total price for the selected package is $XXX.XX.

## How to Run the Application

1. Clone the repository from GitHub.
2. Set up the database using the provided structure.
3. Run the application on your local server.
4. Navigate through the app as a user or administrator to explore all features.

## Contributing

We welcome contributions! Please fork the repository and submit pull requests for any improvements or bug fixes.

## License

This project is licensed under the MIT License.

## Screenshots

Include screenshots of different pages of the application here.

| Front Page | Menu Package |
| ------------- | ------------- |
| <img src="https://i.imgur.com/ha2v8DU.png" width="300">  | <img src="https://i.imgur.com/WroAmwh.png" width="300">   |

| User Registration | User Login |
| ------------- | ------------- |
| <img src="https://i.imgur.com/PYZBGYN.png" width="300">  | <img src="https://i.imgur.com/RLQvouq.png" width="300">   |

| User Profile | Booking Form | User View Bookings |
| ------------- | ------------- | ------------- |
| <img src="https://i.imgur.com/FpGa7ap.png" width="300">  | <img src="https://i.imgur.com/0Qw4LL8.png" width="300">   | <img src="https://i.imgur.com/c32t1w5.png" width="300">  |

| Admin Dashboard | Admin View All Users | Admin View All Bookings |
| ------------- | ------------- | ------------- |
| <img src="https://i.imgur.com/iU3YlBG.png" width="300">  | <img src="https://i.imgur.com/bCL4pnL.png" width="300">   | <img src="https://i.imgur.com/kUXx3bQ.png" width="300">  | <img src="https://i.imgur.com/W4PMvfI.png" width="300"> |
