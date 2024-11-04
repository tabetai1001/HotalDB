-- 1. Trigger to update total service usage after inserting or deleting services in service_usage

-- 1.1. Create the function to update total service usage
CREATE OR REPLACE FUNCTION update_total_service_usage()
RETURNS TRIGGER AS
$$
BEGIN
    UPDATE bookings
    SET total_service_usage = (
        SELECT COALESCE(SUM(quantity), 0) 
        FROM service_usage 
        WHERE booking_id = NEW.booking_id
    )
    WHERE booking_id = NEW.booking_id;
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

-- 1.2. Create the trigger for updating service usage
CREATE TRIGGER update_service_usage_trigger
AFTER INSERT OR DELETE ON service_usage
FOR EACH ROW
EXECUTE FUNCTION update_total_service_usage();

-- 1.3. Make sure to insert data into service_usage
-- (Add sample data for testing)
INSERT INTO service_usage (booking_id, service_id, quantity, total_price) VALUES
(1, 1, 2, 100.00),
(1, 2, 1, 50.00),
(2, 1, 1, 50.00);

-- After inserting, check the bookings table for updated total_service_usage
SELECT booking_id, total_service_usage FROM bookings;

-- 2. Trigger to calculate and update employee salary based on bookings

-- 2.1. Create the function to update employee salary
CREATE OR REPLACE FUNCTION update_employee_salary()
RETURNS TRIGGER AS
$$
BEGIN
    UPDATE employees
    SET salary = base_salary + (SELECT COUNT(*) * bonus_per_booking 
                                FROM employee_booking 
                                WHERE employee_id = NEW.employee_id)
    WHERE employee_id = NEW.employee_id;
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

-- 2.2. Create the trigger for updating employee salary
CREATE TRIGGER update_salary_trigger
AFTER INSERT OR DELETE ON employee_booking
FOR EACH ROW
EXECUTE FUNCTION update_employee_salary();

-- 2.3. Clear the employee_booking table
TRUNCATE TABLE employee_booking;

-- 2.4. Insert data into employee_booking to test the trigger
INSERT INTO employee_booking (employee_id, booking_id) VALUES
(1, 1),
(1, 2),
(2, 1);

-- After inserting, check the employees table for updated salaries
SELECT employee_id, salary FROM employees;
