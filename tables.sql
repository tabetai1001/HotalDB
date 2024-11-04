-- Create the customers table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    address VARCHAR(255),
    date_of_birth DATE
);

-- Create the rooms table
CREATE TABLE rooms (
    room_id SERIAL PRIMARY KEY,
    room_number VARCHAR(10) UNIQUE NOT NULL,
    room_type VARCHAR(50) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL
);

-- Create the bookings table
CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    room_id INTEGER REFERENCES rooms(room_id),
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    total_price NUMERIC(10, 2) NOT NULL
);

-- Create the employees table
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    position VARCHAR(50),
    salary NUMERIC(10, 2),
    hire_date DATE,
    base_salary NUMERIC(10, 2),
    bonus_per_booking NUMERIC(10, 2)
);

-- Create the services table
CREATE TABLE services (
    service_id SERIAL PRIMARY KEY,
    service_name VARCHAR(50) NOT NULL,
    description TEXT,
    price NUMERIC(10, 2) NOT NULL
);

-- Create the service_usage table
CREATE TABLE service_usage (
    service_usage_id SERIAL PRIMARY KEY,
    booking_id INTEGER REFERENCES bookings(booking_id),
    service_id INTEGER REFERENCES services(service_id),
    quantity INTEGER NOT NULL,
    total_price NUMERIC(10, 2) NOT NULL
);

-- Create the employee_booking table
CREATE TABLE employee_booking (
    id SERIAL PRIMARY KEY,
    employee_id INTEGER REFERENCES employees(employee_id),
    booking_id INTEGER REFERENCES bookings(booking_id)
);

-- Insert sample data into customers
INSERT INTO customers (first_name, last_name, email, phone_number, address, date_of_birth) VALUES
('John', 'Doe', 'john.doe@example.com', '123456789', '123 Elm St', '1990-01-01'),
('Jane', 'Smith', 'jane.smith@example.com', '987654321', '456 Oak St', '1985-02-02'),
('Alice', 'Johnson', 'alice.johnson@example.com', '555555555', '789 Pine St', '1978-03-03'),
('Bob', 'Brown', 'bob.brown@example.com', '111222333', '101 Maple St', '1980-04-04'),
('Charlie', 'Davis', 'charlie.davis@example.com', '444666777', '202 Cedar St', '1992-05-05'),
('Emily', 'Wilson', 'emily.wilson@example.com', '666777888', '303 Birch St', '1987-06-06'),
('Frank', 'Moore', 'frank.moore@example.com', '777888999', '404 Walnut St', '1983-07-07'),
('Grace', 'Taylor', 'grace.taylor@example.com', '888999000', '505 Spruce St', '1988-08-08'),
('Hannah', 'Anderson', 'hannah.anderson@example.com', '999000111', '606 Willow St', '1975-09-09'),
('Ian', 'Thomas', 'ian.thomas@example.com', '000111222', '707 Cherry St', '1992-10-10'),
('Isabella', 'White', 'isabella.white@example.com', '123987456', '808 Elm St', '1988-08-08'),
('Jack', 'Harris', 'jack.harris@example.com', '456789123', '909 Ash St', '1975-09-09'),
('Karen', 'Martin', 'karen.martin@example.com', '789123456', '1010 Fir St', '1992-10-10'),
('Larry', 'Clark', 'larry.clark@example.com', '321654987', '1111 Maple St', '1983-11-11'),
('Mona', 'Lewis', 'mona.lewis@example.com', '654321789', '1212 Oak St', '1996-12-12'),
('Nate', 'Walker', 'nate.walker@example.com', '987456321', '1313 Pine St', '1987-01-13'),
('Olivia', 'Hall', 'olivia.hall@example.com', '147852369', '1414 Birch St', '1991-02-14'),
('Paul', 'Allen', 'paul.allen@example.com', '258963147', '1515 Cedar St', '1979-03-15'),
('Quincy', 'Young', 'quincy.young@example.com', '369852147', '1616 Maple St', '1984-04-16'),
('Rachel', 'King', 'rachel.king@example.com', '951753852', '1717 Walnut St', '1989-05-17');

-- Insert sample data into rooms
INSERT INTO rooms (room_number, room_type, price, status) VALUES
('101', 'Single', 100.00, 'Available'),
('102', 'Double', 150.00, 'Available'),
('103', 'Suite', 350.00, 'Available'),
('104', 'Single', 100.00, 'Booked'),
('105', 'Double', 150.00, 'Booked'),
('106', 'Suite', 350.00, 'Available'),
('107', 'Single', 100.00, 'Available'),
('108', 'Double', 150.00, 'Booked'),
('109', 'Suite', 350.00, 'Booked'),
('110', 'Single', 100.00, 'Available'),
('201', 'Single', 100.00, 'Available'),
('202', 'Double', 150.00, 'Available'),
('203', 'Suite', 350.00, 'Available'),
('204', 'Single', 100.00, 'Booked'),
('205', 'Double', 150.00, 'Booked'),
('206', 'Suite', 350.00, 'Available'),
('207', 'Single', 100.00, 'Available'),
('208', 'Double', 150.00, 'Booked'),
('209', 'Suite', 350.00, 'Booked'),
('210', 'Single', 100.00, 'Available');

-- Insert sample data into employees
INSERT INTO employees (first_name, last_name, email, phone_number, position, base_salary, bonus_per_booking, hire_date) VALUES
('Alice', 'Walker', 'alice.walker@example.com', '1231231234', 'Manager', 5000.00, 150.00, '2015-04-12'),
('Bob', 'Harris', 'bob.harris@example.com', '2342342345', 'Receptionist', 2000.00, 50.00, '2016-05-14'),
('Carol', 'Moore', 'carol.moore@example.com', '3453453456', 'Cleaner', 1500.00, 30.00, '2017-06-18'),
('David', 'Taylor', 'david.taylor@example.com', '4564564567', 'Manager', 5000.00, 200.00, '2018-07-22'),
('Eve', 'Johnson', 'eve.johnson@example.com', '5675675678', 'Receptionist', 2200.00, 60.00, '2019-08-28'),
('Jack', 'Brown', 'jack.brown@example.com', '1122334455', 'Cleaner', 1800.00, 20.00, '2018-06-25'),
('Laura', 'Williams', 'laura.williams@example.com', '2233445566', 'Manager', 3500.00, 140.00, '2021-07-30'),
('Megan', 'Johnson', 'megan.johnson@example.com', '3344556677', 'Receptionist', 2200.00, 80.00, '2020-08-12'),
('Nathan', 'Lee', 'nathan.lee@example.com', '4455667788', 'Cleaner', 1800.00, 25.00, '2019-09-14'),
('Olivia', 'Jones', 'olivia.jones@example.com', '5566778899', 'Receptionist', 2300.00, 90.00, '2017-10-21');

-- Insert sample data into services
INSERT INTO services (service_name, description, price) VALUES
('Room Service', '24/7 Room Service', 50.00),
('Laundry', 'Laundry Service', 30.00),
('Spa', 'Spa and Wellness', 100.00),
('Gym', 'Gym Access', 20.00),
('Breakfast', 'Daily Breakfast', 15.00),
('Mini Bar', 'In-room mini bar', 30.00),
('Airport Shuttle', 'Transport to and from the airport', 40.00),
('Pet Care', 'Care for pets', 50.00),
('Massage', 'In-room massage service', 80.00);
