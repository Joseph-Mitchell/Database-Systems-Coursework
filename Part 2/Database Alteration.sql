-- Table Creation

CREATE TABLE cam(
	employee_no VARCHAR(7) PRIMARY KEY,
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	ni_no VARCHAR(13),
	telephone VARCHAR(20),
	mobile VARCHAR(20)
);

CREATE TABLE enquiry(
	enquiry_id INT PRIMARY KEY,
	customer_reference INT NOT NULL,
	cam_employee_no VARCHAR(7) NOT NULL,
	enquiry_type VARCHAR(20),
	date_created DATE,
	enquiry_content VARCHAR(255),
	closed VARCHAR(1),
	FOREIGN KEY (customer_reference)
	REFERENCES customer(reference),
	FOREIGN KEY (cam_employee_no)
	REFERENCES cam(employee_no)
);

CREATE TABLE cam_response(
	response_id INT PRIMARY KEY,
	enquiry_id INT,
	date_created DATE,
	response_content VARCHAR(255),
	FOREIGN KEY (enquiry_id) 
	REFERENCES enquiry(enquiry_id)
);

-- Table Alteration

ALTER TABLE customer
	ADD cam_employee_no VARCHAR(7);
ALTER TABLE customer
	ADD CONSTRAINT customer_ibfk_1 FOREIGN KEY (cam_employee_no) REFERENCES cam(employee_no);
		
ALTER TABLE trip
	ADD cam_employee_no VARCHAR(7);
ALTER TABLE trip
	ADD CONSTRAINT trip_ibfk_4 FOREIGN KEY (cam_employee_no) REFERENCES cam(employee_no);
		
-- Row Insertion

INSERT INTO cam(employee_no, first_name, last_name, ni_no, telephone, mobile)
	VALUES
	("0123673", "John", "Smith", "AA123456B", "01314 960160", "07700 900856"),
	("0125153", "James", "McSmith", "BB654321C", "01314 960658", "07700 900945"),
	("0132361", "Joel", "MacSmith", "CC321654C", "01314 960836", "07700 900764");
		
INSERT INTO enquiry(enquiry_id, customer_reference, cam_employee_no, enquiry_type, date_created, enquiry_content, closed)
	VALUES
	(1, 300, "0123673", "Type1", "2013-10-20", "Hello", "N"),
	(2, 299, "0125153", "Type4", "2013-11-05", "Hi", "Y"),
	(3, 300, "0123673", "Type1", "2013-12-15", "Hello?", "N"),
	(4, 298, "0132361", "Type3", "2013-12-27", ">:(", "Y"),
	(5, 300, "0123673", "Type3", "2014-02-22", "Answer Me!", "Y");

INSERT INTO cam_response(response_id, enquiry_id, date_created, response_content)
	VALUES
	(1, 2, "2013-11-12", "Yes, Hello"),
	(2, 4, "2014-01-03", ":("),
	(3, 5, "2014-02-23", "No :)");

-- Row Updating

UPDATE customer
	SET cam_employee_no = "0123673"
WHERE reference = 300;
UPDATE customer
	SET cam_employee_no = "0125153"
WHERE reference = 299;
UPDATE customer
	SET cam_employee_no = "0132361"
WHERE reference = 298;

UPDATE trip
JOIN manifest ON trip.trip_id = manifest.trip_id 
	SET cam_employee_no = "0123673"
WHERE manifest.delivery_customer_ref = 300;
UPDATE trip
JOIN manifest ON trip.trip_id = manifest.trip_id 
	SET cam_employee_no = "0125153"
WHERE manifest.delivery_customer_ref = 299;
UPDATE trip
JOIN manifest ON trip.trip_id = manifest.trip_id 
	SET cam_employee_no = "0132361"
WHERE manifest.delivery_customer_ref = 298;
		
-- Queries

SELECT * FROM cam;

SELECT reference, contact_fname, contact_sname, cam_employee_no AS 'Cam Employee Number', 
	first_name AS 'Cam First Name', last_name AS 'Cam Last Name'
FROM customer JOIN cam ON cam_employee_no = employee_no;

SELECT trip.trip_id, trip.cam_employee_no AS 'Cam Employee Number',
	cam.first_name AS 'Cam First Name', cam.last_name AS 'Cam Last Name'
FROM trip JOIN cam ON trip.cam_employee_no = cam.employee_no;

SELECT * FROM enquiry;

SELECT * FROM cam_response;