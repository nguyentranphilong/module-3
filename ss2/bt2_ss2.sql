create database quanlybanhang;
CREATE TABLE Customer (
    cID INT PRIMARY KEY,          
    cName VARCHAR(100),            
    cPhone VARCHAR(15),            
    cAddress VARCHAR(255)          
);
CREATE TABLE Orderr (
    oID INT PRIMARY KEY,          
    cID INT,                       
    oDate DATE,                   
    FOREIGN KEY (cID) REFERENCES Customer(cID)
);
CREATE TABLE Product (
    pID INT PRIMARY KEY,          
    pName VARCHAR(100),            
    pPrice DECIMAL(10, 2)          
);
CREATE TABLE OrderDetail (
    oID INT,
    pID INT,
    quantity INT,
    price DECIMAL(10 , 2 ),
    PRIMARY KEY (oID , pID),
    FOREIGN KEY (oID)
        REFERENCES Orderr (oID),
    FOREIGN KEY (pID)
        REFERENCES Product (pID)
);

