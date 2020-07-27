DROP TABLE IF EXISTS phone;
DROP TABLE IF EXISTS email;
DROP TABLE IF EXISTS person_address;
DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS address;

CREATE TABLE person (
        person_id serial primary key,
        first_name varchar(20) not null,
        last_name varchar(20) not null,
        date_added DATE default now()
);

CREATE TABLE address (
        address_id serial primary key,
        street varchar(30),
        line_two varchar(30),
        city varchar(20),
        postal_code varchar(20),
        district varchar(100),
        address_type varchar(30),
        type_other_description varchar(32),
        
        CONSTRAINT chk_address_type CHECK ( address_type IN ('Work', 'Shipping', 'Home', 'Billing', 'Other') ),
        
        CONSTRAINT chk_address_type_other CHECK ( (address_type = 'Other' AND type_other_description IS NOT NULL) OR 
                ( address_type <> 'Other' AND type_other_description IS NULL)  ) 

);

CREATE TABLE person_address ( 
        person_id int,
        address_id int,
        
        PRIMARY KEY(person_id, address_id),
        CONSTRAINT fk_person_person_id FOREIGN KEY (person_id) REFERENCES person(person_id),
        CONSTRAINT fk_address_address_id FOREIGN KEY (address_id) REFERENCES address(address_id)
);

CREATE TABLE phone (
        phone_id serial primary key,
        person_id int not null,
        phone_number varchar(20) not null,
        extension varchar(10),
        phone_type varchar(10),
        type_other_description varchar(32),
        
        CONSTRAINT fk_phone_person_id FOREIGN KEY (person_id) REFERENCES person(person_id),
        CONSTRAINT chk_phone_type CHECK ( phone_type IN ('Work', 'Home', 'Mobile', 'Other') ),
        
        CONSTRAINT chk_phone_type_other CHECK ( (phone_type = 'Other' AND type_other_description IS NOT NULL) OR 
                ( phone_type <> 'Other' AND type_other_description IS NULL)  ) 

);

CREATE TABLE email (
        email_id serial primary key,
        person_id int not null,
        email varchar(255) not null,
        email_type varchar(10),
        type_other_description varchar(32),
        
        CONSTRAINT fk_email_person_id FOREIGN KEY (person_id) REFERENCES person(person_id),
        CONSTRAINT chk_email_type CHECK ( email_type IN ('Work', 'Home','Other') ),
        
        CONSTRAINT chk_email_type_other CHECK ( (email_type = 'Other' AND type_other_description IS NOT NULL) OR 
                ( email_type <> 'Other' AND type_other_description IS NULL)  ) 

);


-- These INSERTs use the CURRVAL(sequence) function to get the last value used for the sequence
-- without incrementing it.  This allows for the entries to be added using the sequence so it is current
-- the next time it is used.   WARNING: This only works if the order of the INSERTS is maintained.  If the order is 
-- changed, then it will associate the incorrect ids.  CAUTION: This is 1 ways of using sequences in a schema script, but 
-- should only be used when we are sure there are no other users connected to a database that may be INSERTING other records,
-- which may cause CURRVAL() to return their use of the sequence instead of ours.  In this script is is safe to use, because
-- the earlier portion of the schema drops and creates the database when run.  

-- INSERT Dave Warthog
INSERT INTO person (person_id, first_name, last_name) 
        VALUES (DEFAULT, 'Dave', 'Warthog');
INSERT INTO address (address_id, street, line_two, city, postal_code, district, address_type, type_other_description)
        VALUES (DEFAULT, '1245 High Street', 'Apt 51', 'Columbus', '43201', 'OH', 'Home', null);
INSERT INTO person_address (person_id, address_id) 
        VALUES ( CURRVAL('person_person_id_seq'), CURRVAL('address_address_id_seq') );
INSERT INTO phone ( phone_id, person_id, phone_number, extension, phone_type, type_other_description)
        VALUES ( DEFAULT, CURRVAL('person_person_id_seq'), '614-555-1212', null, 'Mobile', null);
INSERT INTO email (email_id, person_id, email, email_type, type_other_description) 
        VALUES ( DEFAULT, CURRVAL('person_person_id_seq'), 'warthog@warthogrules.com', 'Home', null);
        
-- INSERT Rayboy Jones
INSERT INTO person (person_id, first_name, last_name) 
        VALUES (DEFAULT, 'Ratboy', 'Jones');
INSERT INTO address (address_id, street, line_two, city, postal_code, district, address_type, type_other_description)
        VALUES (DEFAULT, 'Under the front street bridge', null, 'Columbus', '43201', 'OH', 'Home', null);
INSERT INTO address (address_id, street, line_two, city, postal_code, district, address_type, type_other_description)
        VALUES (DEFAULT, 'OSU Tunnels', 'North Oval Entrance', 'Columbus', '43201', 'OH', 'Other', 'Winter');
INSERT INTO person_address (person_id, address_id) 
        VALUES ( CURRVAL('person_person_id_seq'), CURRVAL('address_address_id_seq') );
INSERT INTO phone ( phone_id, person_id, phone_number, extension, phone_type, type_other_description)
        VALUES ( DEFAULT, CURRVAL('person_person_id_seq'), '614-555-7892', null, 'Mobile', null);
INSERT INTO phone ( phone_id, person_id, phone_number, extension, phone_type, type_other_description)
        VALUES ( DEFAULT, CURRVAL('person_person_id_seq'), '888-555-8277', null, 'Other', 'Payphone');
INSERT INTO email (email_id, person_id, email, email_type, type_other_description) 
        VALUES ( DEFAULT, CURRVAL('person_person_id_seq'), 'ratboy@aol.com', 'Home', null);
        
        
-- INSERT Tall Bobby
INSERT INTO person (person_id, first_name, last_name) 
        VALUES (DEFAULT, 'Tall', 'Bobby');
INSERT INTO address (address_id, street, line_two, city, postal_code, district, address_type, type_other_description)
        VALUES (DEFAULT, '52A 5th Ave', null, 'Columbus', '43220', 'OH', 'Work', null);
INSERT INTO person_address (person_id, address_id) 
        VALUES ( CURRVAL('person_person_id_seq'), CURRVAL('address_address_id_seq') );
INSERT INTO phone ( phone_id, person_id, phone_number, extension, phone_type, type_other_description)
        VALUES ( DEFAULT, CURRVAL('person_person_id_seq'), '614-555-5782', null, 'Home', null);
INSERT INTO email (email_id, person_id, email, email_type, type_other_description) 
        VALUES ( DEFAULT, CURRVAL('person_person_id_seq'), 'tallguy@bobbyrocks.com', 'Work', null);
 
-- INSERT Jenny Smith
INSERT INTO person (person_id, first_name, last_name) 
        VALUES (DEFAULT, 'Jenny', 'Smith');
INSERT INTO address (address_id, street, line_two, city, postal_code, district, address_type, type_other_description)
        VALUES (DEFAULT, '18 Main St', null, 'Newcomerstown', '43832', 'OH', 'Home', null);
INSERT INTO person_address (person_id, address_id) 
        VALUES ( CURRVAL('person_person_id_seq'), CURRVAL('address_address_id_seq') );
INSERT INTO phone ( phone_id, person_id, phone_number, extension, phone_type, type_other_description)
        VALUES ( DEFAULT, CURRVAL('person_person_id_seq'), '740-867-5209', null, 'Mobile', null);
INSERT INTO email (email_id, person_id, email, email_type, type_other_description) 
        VALUES ( DEFAULT, CURRVAL('person_person_id_seq'), 'jenny@tutone.org', 'Home', null);
        
-- INSERT Jimmy Crooked
INSERT INTO person (person_id, first_name, last_name) 
        VALUES (DEFAULT, 'Jimmy', 'Crooked');
INSERT INTO address (address_id, street, line_two, city, postal_code, district, address_type, type_other_description)
        VALUES (DEFAULT, '1782 South Ave', null, 'Pittsburgh', '15106', 'PA', 'Work', null);
INSERT INTO person_address (person_id, address_id) 
        VALUES ( CURRVAL('person_person_id_seq'), CURRVAL('address_address_id_seq') );
INSERT INTO phone ( phone_id, person_id, phone_number, extension, phone_type, type_other_description)
        VALUES ( DEFAULT, CURRVAL('person_person_id_seq'), '412-555-9632', null, 'Work', null);
INSERT INTO email (email_id, person_id, email, email_type, type_other_description) 
        VALUES ( DEFAULT, CURRVAL('person_person_id_seq'), 'jimmycrooked@cobras.com', 'Work', null);
        
-- INSERT Jung Choi
INSERT INTO person (person_id, first_name, last_name) 
        VALUES (DEFAULT, 'Jung', 'Choi');
INSERT INTO address (address_id, street, line_two, city, postal_code, district, address_type, type_other_description)
        VALUES (DEFAULT, '85-1 Chebu-dong', null, 'Seoul', '100-093', 'Jongro-gu', 'Work', null);
INSERT INTO person_address (person_id, address_id) 
        VALUES ( CURRVAL('person_person_id_seq'), CURRVAL('address_address_id_seq') );
INSERT INTO phone ( phone_id, person_id, phone_number, extension, phone_type, type_other_description)
        VALUES ( DEFAULT, CURRVAL('person_person_id_seq'), '+82-2-312-3456', null, 'Work', null);
INSERT INTO email (email_id, person_id, email, email_type, type_other_description) 
        VALUES ( DEFAULT, CURRVAL('person_person_id_seq'), 'jung.choi@gmailing.com', 'Work', null);
INSERT INTO email (email_id, person_id, email, email_type, type_other_description) 
        VALUES ( DEFAULT, CURRVAL('person_person_id_seq'), 'jung.choi@1123.org', 'Other', 'Teletext');