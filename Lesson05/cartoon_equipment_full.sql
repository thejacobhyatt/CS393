########################################
# CS350 2010 - Created from Forta "MySQL Crash Course" scripts
# IT393 2020 - Fixed foreign keys
########################################

DROP DATABASE IF EXISTS cartoon_equipment;
CREATE DATABASE cartoon_equipment;
USE cartoon_equipment;

########################################
# MySQL Crash Course
# http://www.forta.com/books/0672327120/
# Example table creation scripts
########################################

########################
# Create Customer table
########################
CREATE TABLE Customer (
  customerId      int       PRIMARY KEY AUTO_INCREMENT,
  customerName    char(50)  NOT NULL,
  customerAddress char(50)  NULL,
  customerCity    char(50)  NULL,
  customerState   char(5)   NULL,
  customerZip     char(10)  NULL,
  customerCountry char(50)  NULL,
  customerContact char(50)  NULL,
  customerEmail   char(255) NULL
);

#####################
# Create CustomerOrder table
#####################
CREATE TABLE CustomerOrder (
  orderNumber  int      PRIMARY KEY AUTO_INCREMENT,
  orderDate datetime NOT NULL,
  customerId    int      NOT NULL
);

######################
# Create Vendor table
######################
CREATE TABLE Vendor (
  vendorId      int      PRIMARY KEY AUTO_INCREMENT,
  vendorName    char(50) NOT NULL,
  vendorAddress char(50) NULL,
  vendorCity    char(50) NULL,
  vendorState   char(5)  NULL,
  vendorZip     char(10) NULL,
  vendorCountry char(50) NULL
);

#######################
# Create Product table
#######################
CREATE TABLE Product (
  productId    char(10)      PRIMARY KEY,
  vendorId    int           NOT NULL,
  productName  char(255)     NOT NULL,
  productPrice decimal(8,2)  NOT NULL,
  productDescription  text          NULL
);

#########################
# Create OrderItem table
#########################
CREATE TABLE OrderItem
(
  orderNumber  int,
  orderItem int,
  productId    char(10)     NOT NULL,
  quantity   int          NOT NULL,
  itemPrice decimal(8,2) NOT NULL,
  PRIMARY KEY (orderNumber, orderItem)
);

###########################
# Create ProductNote table
###########################
CREATE TABLE ProductNote
(
  noteId    int           PRIMARY KEY AUTO_INCREMENT,
  productId    char(10)      NOT NULL,
  noteDate datetime       NOT NULL,
  noteText  text          NULL,
  FULLTEXT(noteText)
);

########################################
# MySQL Crash Course
# http://www.forta.com/books/0672327120/
# Example table population scripts
########################################

##########################
# Populate Customer table
##########################
INSERT INTO Customer(customerId, customerName, customerAddress, customerCity, customerState, customerZip, customerCountry, customerContact, customerEmail)
VALUES(10001, 'Coyote Inc.', '200 Maple Lane', 'Detroit', 'MI', '44444', 'USA', 'Y Lee', 'ylee@coyote.com');
INSERT INTO Customer(customerId, customerName, customerAddress, customerCity, customerState, customerZip, customerCountry, customerContact)
VALUES(10002, 'Mouse House', '333 Fromage Lane', 'Columbus', 'OH', '43333', 'USA', 'Jerry Mouse');
INSERT INTO Customer(customerId, customerName, customerAddress, customerCity, customerState, customerZip, customerCountry, customerContact, customerEmail)
VALUES(10003, 'Wascals', '1 Sunny Place', 'Muncie', 'IN', '42222', 'USA', 'Jim Jones', 'rabbit@wascally.com');
INSERT INTO Customer(customerId, customerName, customerAddress, customerCity, customerState, customerZip, customerCountry, customerContact, customerEmail)
VALUES(10004, 'Yosemite Place', '829 Riverside Drive', 'Phoenix', 'AZ', '88888', 'USA', 'Y Sam', 'sam@yosemite.com');
INSERT INTO Customer(customerId, customerName, customerAddress, customerCity, customerState, customerZip, customerCountry, customerContact)
VALUES(10005, 'E Fudd', '4545 53rd Street', 'Chicago', 'IL', '54545', 'USA', 'E Fudd');


########################
# Populate Vendor table
########################
INSERT INTO Vendor(vendorId, vendorName, vendorAddress, vendorCity, vendorState, vendorZip, vendorCountry)
VALUES(1001,'Anvils R Us','123 Main Street','Southfield','MI','48075', 'USA');
INSERT INTO Vendor(vendorId, vendorName, vendorAddress, vendorCity, vendorState, vendorZip, vendorCountry)
VALUES(1002,'LT Supplies','500 Park Street','Anytown','OH','44333', 'USA');
INSERT INTO Vendor(vendorId, vendorName, vendorAddress, vendorCity, vendorState, vendorZip, vendorCountry)
VALUES(1003,'ACME','555 High Street','Los Angeles','CA','90046', 'USA');
INSERT INTO Vendor(vendorId, vendorName, vendorAddress, vendorCity, vendorState, vendorZip, vendorCountry)
VALUES(1004,'Furball Inc.','1000 5th Avenue','New York','NY','11111', 'USA');
INSERT INTO Vendor(vendorId, vendorName, vendorAddress, vendorCity, vendorState, vendorZip, vendorCountry)
VALUES(1005,'Jet Set','42 Galaxy Road','London', NULL,'N16 6PS', 'England');
INSERT INTO Vendor(vendorId, vendorName, vendorAddress, vendorCity, vendorState, vendorZip, vendorCountry)
VALUES(1006,'Jouets Et Ours','1 Rue Amusement','Paris', NULL,'45678', 'France');


#########################
# Populate Product table
#########################
INSERT INTO Product(productId, vendorId, productName, productPrice, productDescription)
VALUES('ANV01', 1001, '.5 ton anvil', 5.99, '.5 ton anvil, black, complete with handy hook');
INSERT INTO Product(productId, vendorId, productName, productPrice, productDescription)
VALUES('ANV02', 1001, '1 ton anvil', 9.99, '1 ton anvil, black, complete with handy hook and carrying case');
INSERT INTO Product(productId, vendorId, productName, productPrice, productDescription)
VALUES('ANV03', 1001, '2 ton anvil', 14.99, '2 ton anvil, black, complete with handy hook and carrying case');
INSERT INTO Product(productId, vendorId, productName, productPrice, productDescription)
VALUES('OL1', 1002, 'Oil can', 8.99, 'Oil can, red');
INSERT INTO Product(productId, vendorId, productName, productPrice, productDescription)
VALUES('FU1', 1002, 'Fuses', 3.42, '1 dozen, extra long');
INSERT INTO Product(productId, vendorId, productName, productPrice, productDescription)
VALUES('SLING', 1003, 'Sling', 4.49, 'Sling, one size fits all');
INSERT INTO Product(productId, vendorId, productName, productPrice, productDescription)
VALUES('TNT1', 1003, 'TNT (1 stick)', 2.50, 'TNT, red, single stick');
INSERT INTO Product(productId, vendorId, productName, productPrice, productDescription)
VALUES('TNT2', 1003, 'TNT (5 sticks)', 10, 'TNT, red, pack of 10 sticks');
INSERT INTO Product(productId, vendorId, productName, productPrice, productDescription)
VALUES('FB', 1003, 'Bird seed', 10, 'Large bag (suitable for road runners)');
INSERT INTO Product(productId, vendorId, productName, productPrice, productDescription)
VALUES('FC', 1003, 'Carrots', 2.50, 'Carrots (rabbit hunting season only)');
INSERT INTO Product(productId, vendorId, productName, productPrice, productDescription)
VALUES('SAFE', 1003, 'Safe', 50, 'Safe with combination lock');
INSERT INTO Product(productId, vendorId, productName, productPrice, productDescription)
VALUES('DTNTR', 1003, 'Detonator', 13, 'Detonator (plunger powered), fuses not included');
INSERT INTO Product(productId, vendorId, productName, productPrice, productDescription)
VALUES('JP1000', 1005, 'JetPack 1000', 35, 'JetPack 1000, intended for single use');
INSERT INTO Product(productId, vendorId, productName, productPrice, productDescription)
VALUES('JP2000', 1005, 'JetPack 2000', 55, 'JetPack 2000, multi-use');

#######################
# Populate CustomerOrder table
#######################
INSERT INTO CustomerOrder(orderNumber, orderDate, customerId)
VALUES(20005, '2005-09-01', 10001);
INSERT INTO CustomerOrder(orderNumber, orderDate, customerId)
VALUES(20006, '2005-09-12', 10003);
INSERT INTO CustomerOrder(orderNumber, orderDate, customerId)
VALUES(20007, '2005-09-30', 10004);
INSERT INTO CustomerOrder(orderNumber, orderDate, customerId)
VALUES(20008, '2005-10-03', 10005);
INSERT INTO CustomerOrder(orderNumber, orderDate, customerId)
VALUES(20009, '2005-10-08', 10001);

###########################
# Populate OrderItem table
###########################
INSERT INTO OrderItem(orderNumber, orderItem, productId, quantity, itemPrice)
VALUES(20005, 1, 'ANV01', 10, 5.99);
INSERT INTO OrderItem(orderNumber, orderItem, productId, quantity, itemPrice)
VALUES(20005, 2, 'ANV02', 3, 9.99);
INSERT INTO OrderItem(orderNumber, orderItem, productId, quantity, itemPrice)
VALUES(20005, 3, 'TNT2', 5, 10);
INSERT INTO OrderItem(orderNumber, orderItem, productId, quantity, itemPrice)
VALUES(20005, 4, 'FB', 1, 10);
INSERT INTO OrderItem(orderNumber, orderItem, productId, quantity, itemPrice)
VALUES(20006, 1, 'JP2000', 1, 55);
INSERT INTO OrderItem(orderNumber, orderItem, productId, quantity, itemPrice)
VALUES(20007, 1, 'TNT2', 100, 10);
INSERT INTO OrderItem(orderNumber, orderItem, productId, quantity, itemPrice)
VALUES(20008, 1, 'FC', 50, 2.50);
INSERT INTO OrderItem(orderNumber, orderItem, productId, quantity, itemPrice)
VALUES(20009, 1, 'FB', 1, 10);
INSERT INTO OrderItem(orderNumber, orderItem, productId, quantity, itemPrice)
VALUES(20009, 2, 'OL1', 1, 8.99);
INSERT INTO OrderItem(orderNumber, orderItem, productId, quantity, itemPrice)
VALUES(20009, 3, 'SLING', 1, 4.49);
INSERT INTO OrderItem(orderNumber, orderItem, productId, quantity, itemPrice)
VALUES(20009, 4, 'ANV03', 1, 14.99);

#############################
# Populate ProductNote table
#############################
INSERT INTO ProductNote(noteId, productId, noteDate, noteText)
VALUES(100, 'XRA3', '2004-07-18',
' Customer complaint:
Does not satisfactorily work through walls after one use.'
);
INSERT INTO ProductNote(noteId, productId, noteDate, noteText)
VALUES(101, 'TNT2', '2005-08-17',
'Customer complaint:
Sticks not individually wrapped, too easy to mistakenly detonate all at once.
Recommend individual wrapping.'
);
INSERT INTO ProductNote(noteId, productId, noteDate, noteText)
VALUES(102, 'OL1', '2005-08-18',
'Can shipped full, refills not available.
Need to order new can if refill needed.'
);
INSERT INTO ProductNote(noteId, productId, noteDate, noteText)
VALUES(103, 'SAFE', '2005-08-18',
'Safe is combination locked, combination not provided with safe.
This is rarely a problem as safes are typically blown up or dropped by Customer.'
);
INSERT INTO ProductNote(noteId, productId, noteDate, noteText)
VALUES(104, 'FC', '2005-08-19',
'Quantity varies, sold by the sack load.
All guaranteed to be bright and orange, and suitable for use as rabbit bait.'
);
INSERT INTO ProductNote(noteId, productId, noteDate, noteText)
VALUES(105, 'TNT2', '2005-08-20',
'Included fuses are short and have been known to detonate too quickly for some Customer.
Longer fuses are available (item FU1) and should be recommended.'
);
INSERT INTO ProductNote(noteId, productId, noteDate, noteText)
VALUES(106, 'TNT2', '2005-08-22',
'Matches not included, recommend purchase of matches or detonator (item DTNTR).'
);
INSERT INTO ProductNote(noteId, productId, noteDate, noteText)
VALUES(107, 'SAFE', '2005-08-23',
'Please note that no returns will be accepted if safe opened using explosives.'
);
INSERT INTO ProductNote(noteId, productId, noteDate, noteText)
VALUES(108, 'ANV01', '2005-08-25',
'Multiple customeromer returns, anvils failing to drop fast enough or falling backwards on purchaser. Recommend that customeromer considers using heavier anvils.'
);
INSERT INTO ProductNote(noteId, productId, noteDate, noteText)
VALUES(109, 'ANV03', '2005-09-01',
'Item is extremely heavy. Designed for dropping, not recommended for use with slings, ropes, pulleys, or tightropes.'
);
INSERT INTO ProductNote(noteId, productId, noteDate, noteText)
VALUES(110, 'FC', '2005-09-01',
'Customer complaint: rabbit has been able to detect trap, food apparently less effective now.'
);
INSERT INTO ProductNote(noteId, productId, noteDate, noteText)
VALUES(111, 'SLING', '2005-09-02',
'Shipped unassembled, requires common tools (including oversized hammer).'
);
INSERT INTO ProductNote(noteId, productId, noteDate, noteText)
VALUES(112, 'SAFE', '2005-09-02',
'Customer complaint:
Circular hole in safe floor can apparently be easily cut with handsaw.'
);
INSERT INTO ProductNote(noteId, productId, noteDate, noteText)
VALUES(113, 'ANV01', '2005-09-05',
'Customer complaint:
Not heavy enough to generate flying stars around head of victim. If being purchased for dropping, recommend ANV02 or ANV03 instead.'
);
INSERT INTO ProductNote(noteId, productId, noteDate, noteText)
VALUES(114, 'SAFE', '2005-09-07',
'Call from individual trapped in safe plummeting to the ground, suggests an escape hatch be added.
Comment forwarded to vendor.'
);
INSERT INTO ProductNote(noteId, productId, noteDate, noteText)
VALUES(115, 'NBMB', '2006-01-02',
'Shipping complaint:
Cannot ship internationally due to weapons sanctions.'
);