# Selera Kamoung - A Restaurant Menu Package Booking App

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

| Screenshot Description      | Screenshot |
|-----------------------------|------------|
| Front Page                  | ![Front Page](screenshots/front_page.png) |
| Menu Packages               | ![Menu Packages](screenshots/menu_packages.png) |
| User Registration           | ![User Registration](screenshots/user_registration.png) |
| User Login                  | ![User Login](screenshots/user_login.png) |
| User Profile                | ![User Profile](screenshots/user_profile.png) |
| Booking Form                | ![Booking Form](screenshots/booking_form.png) |
| View Bookings               | ![View Bookings](screenshots/view_bookings.png) |
| Administrator Panel         | ![Administrator Panel](screenshots/admin_panel.png) |
| Admin View All Users        | ![Admin View All Users](screenshots/admin_view_all_users.png) |
| Admin View All Bookings     | ![Admin View All Bookings](screenshots/admin_view_all_bookings.png) |
