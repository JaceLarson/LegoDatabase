/*
CS3550
Lego Database Scripts
Jace Larson
*/

IF (OBJECT_ID('dbo.FK_GROUP7_Sets_ThemeID', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE GROUP7_Sets DROP CONSTRAINT FK_GROUP7_Sets_ThemeID
END


IF (OBJECT_ID('dbo.FK_GROUP7_Sets_PurchaseID', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE GROUP7_Sets DROP CONSTRAINT FK_GROUP7_Sets_PurchaseID
END

IF (OBJECT_ID('dbo.FK_GROUP7_Purchases_SetID', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE GROUP7_Purchases DROP CONSTRAINT FK_GROUP7_Purchases_SetID
END

IF (OBJECT_ID('dbo.FK_GROUP7_Purchases_VendorID', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE GROUP7_Purchases DROP CONSTRAINT FK_GROUP7_Purchases_VendorID
END

IF (OBJECT_ID('dbo.FK_GROUP7_SetPieces_SetID', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE GROUP7_SetPieces DROP CONSTRAINT FK_GROUP7_SetPieces_SetID
END

IF (OBJECT_ID('dbo.FK_GROUP7_SetPieces_PieceID', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE GROUP7_SetPieces DROP CONSTRAINT FK_GROUP7_SetPieces_PieceID
END

IF (OBJECT_ID('dbo.FK_GROUP7_Pieces_ColorID', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE GROUP7_Pieces DROP CONSTRAINT FK_GROUP7_Pieces_ColorID
END

IF (OBJECT_ID('dbo.FK_GROUP7_Pieces_ShapeID', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE GROUP7_Pieces DROP CONSTRAINT FK_GROUP7_Pieces_ShapeID
END


IF (OBJECT_ID('dbo.FK_GROUP7_FigurePieces_FigureID', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE GROUP7_FiguresPieces DROP CONSTRAINT FK_GROUP7_FigurePieces_FigureID
END


IF (OBJECT_ID('dbo.FK_GROUP7_FigurePieces_PieceID', 'F') IS NOT NULL)
BEGIN
    ALTER TABLE GROUP7_FiguresPieces DROP CONSTRAINT FK_GROUP7_FigurePieces_PieceID
END

DROP TABLE IF EXISTS GROUP7_Themes;
DROP TABLE IF EXISTS GROUP7_Sets;
DROP TABLE IF EXISTS GROUP7_Purchases;
DROP TABLE IF EXISTS GROUP7_Vendors;
DROP TABLE IF EXISTS GROUP7_Pieces;
DROP TABLE IF EXISTS GROUP7_SetPieces;
DROP TABLE IF EXISTS GROUP7_Colors;
DROP TABLE IF EXISTS GROUP7_Shapes;
DROP TABLE IF EXISTS GROUP7_MiniFigures;
DROP TABLE IF EXISTS GROUP7_FiguresPieces;



CREATE TABLE GROUP7_Themes
(
    ThemeID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    ThemeName varchar(255) NOT NULL
);

CREATE TABLE GROUP7_Sets
(
    SetID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    SetName varchar(255) NOT NULL,
	Instructions varchar(2000) NULL,
	ThemeID int NULL
);


CREATE TABLE GROUP7_Purchases
(
    PurchaseID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	DateOfPurchase date NOT NULL,
	MethodOfPayment varchar(50) Null,
	VendorID int NULL,
	Customer varchar(255) Null,
    PurchasePrice money NULL,
	SetID int NULL,
);



CREATE TABLE GROUP7_Vendors
(
    VendorID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    VendorName varchar(255) NULL,
	WebAddress varchar(2000) NULL,
	PhoneNumber varchar(15) Null
);

CREATE TABLE GROUP7_Pieces
(
    PieceID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    ShapeID int NOT NULL,
	ColorID int NOT NULL,
	Part	varchar(12) UNIQUE NOT NULL
);

CREATE TABLE GROUP7_SetPieces
(
    SetPieceID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    SetID int NOT NULL,
	PieceID int NOT NULL, 
    Quantity int NOT NULL
);

CREATE TABLE GROUP7_Colors
(
    ColorID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    HexCode varchar(6) NOT NULL,
	RGBCode varchar(11) NOT NULL,
	ColorName varchar(50) NOT NULL
);

CREATE TABLE GROUP7_Shapes
(
    ShapeID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    ShapeName varchar(50) NOT NULL,
	SLength int,
	SWidth int,
	SHeight int
);

CREATE TABLE GROUP7_MiniFigures
(
    FigureID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    FigureName varchar(100) NOT NULL
);

CREATE TABLE GROUP7_FiguresPieces
(
    FigurePieceID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    FigureID int NOT NULL,
    PieceID int NOT NULL
);

/*
Tables are created now create constraints.
*/

ALTER TABLE GROUP7_Sets
   ADD CONSTRAINT FK_GROUP7_Sets_ThemeID FOREIGN KEY (ThemeID)
      REFERENCES GROUP7_Themes (ThemeID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE GROUP7_Purchases
   ADD CONSTRAINT FK_GROUP7_Purchases_SetID FOREIGN KEY (SetID)
      REFERENCES GROUP7_Sets (SetID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE GROUP7_Purchases
   ADD CONSTRAINT FK_GROUP7_Purchases_VendorID FOREIGN KEY (VendorID)
      REFERENCES GROUP7_Vendors (VendorID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;


ALTER TABLE GROUP7_SetPieces
   ADD CONSTRAINT FK_GROUP7_SetPieces_SetID FOREIGN KEY (SetID)
      REFERENCES GROUP7_Sets (SetID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE GROUP7_SetPieces
   ADD CONSTRAINT FK_GROUP7_SetPieces_PieceID FOREIGN KEY (PieceID)
      REFERENCES GROUP7_Pieces (PieceID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE GROUP7_Pieces
   ADD CONSTRAINT FK_GROUP7_Pieces_ColorID FOREIGN KEY (ColorID)
      REFERENCES GROUP7_Colors (ColorID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE GROUP7_Pieces
   ADD CONSTRAINT FK_GROUP7_Pieces_ShapeID FOREIGN KEY (ShapeID)
      REFERENCES GROUP7_Shapes (ShapeID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE GROUP7_FiguresPieces
   ADD CONSTRAINT FK_GROUP7_FigurePieces_FigureID FOREIGN KEY (FigureID)
      REFERENCES GROUP7_MiniFigures (FigureID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE GROUP7_FiguresPieces
   ADD CONSTRAINT FK_GROUP7_FigurePieces_PieceID FOREIGN KEY (PieceID)
      REFERENCES GROUP7_Pieces (PieceID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

BEGIN TRANSACTION

INSERT INTO GROUP7_Themes(ThemeName)
VALUES ('Star Wars')

INSERT INTO GROUP7_Themes(ThemeName)
VALUES ('City')
 
COMMIT;

BEGIN TRANSACTION

INSERT INTO GROUP7_Sets (SetName,Instructions,ThemeID)
    VALUES 
        (
            'Rebel Scout Speeder',
            'https://www.lego.com/biassets/bi/4535028.pdf',
            (SELECT ThemeID FROM GROUP7_Themes WHERE ThemeName = 'Star Wars')
            --,(SELECT PurchaseID FROM GROUP7_Purchases WHERE MethodOfPayment = 'Credit Card')
        )

INSERT INTO GROUP7_Sets (SetName,Instructions,ThemeID)
    VALUES 
        (
            'Street Sweeper',
            'https://www.lego.com/biassets/bi/6305219.pdf',
            (SELECT ThemeID FROM GROUP7_Themes WHERE ThemeName = 'City')
            --,(SELECT PurchaseID FROM GROUP7_Purchases WHERE MethodOfPayment = 'Cash')
        )

INSERT INTO GROUP7_Vendors(VendorName,WebAddress,PhoneNumber)
    VALUES ('Amazon','Amazon.com','8882804331')

INSERT INTO GROUP7_Vendors(VendorName,WebAddress,PhoneNumber)
    VALUES ('Walmart','Walmart.com','8009666546')


 
COMMIT;

BEGIN TRANSACTION

INSERT INTO GROUP7_Purchases (DateOfPurchase,MethodOfPayment,VendorID,Customer,PurchasePrice, SetID)
    VALUES
        ( '12/25/2019','Credit Card',
        (SELECT VendorID FROM GROUP7_Vendors WHERE VendorName = 'Walmart'),
        'Andrew Hammon', '59.88',
		(SELECT SetID FROM GROUP7_Sets WHERE SetName='Rebel Scout Speeder'))

INSERT INTO GROUP7_Purchases (DateOfPurchase,MethodOfPayment,VendorID,Customer,PurchasePrice, SetID)
    VALUES
        ( '11/25/2019','Cash',
        (SELECT VendorID FROM GROUP7_Vendors WHERE VendorName = 'Amazon'),
        'Andrew Hammon', '9.84',
		(SELECT SetID FROM GROUP7_Sets WHERE SetName='Street Sweeper'))

COMMIT;

/*
SELECT *
FROM GROUP7_Sets s, GROUP7_Themes t, GROUP7_Purchases p, GROUP7_Vendors v

WHERE 
    s.ThemeID = t.ThemeID 
    AND 
    s.PurchaseID = p.PurchaseID 
    AND 
    p.VendorID = v.VendorID
    
SELECT *
FROM GROUP7_Sets
*/

BEGIN TRANSACTION
INSERT INTO  GROUP7_Colors (HexCode, RGBCode, ColorName)  VALUES  ('000000', '0,0,0', 'Black')
INSERT INTO  GROUP7_Colors (HexCode, RGBCode, ColorName)  VALUES  ('009933', '0,153,51', 'Fun Green')
INSERT INTO  GROUP7_Colors (HexCode, RGBCode, ColorName)  VALUES  ('004D99', '0,77,153', 'Congress Blue')
INSERT INTO  GROUP7_Colors (HexCode, RGBCode, ColorName)  VALUES  ('4D0000', '77,0,0', 'Temptress')
INSERT INTO  GROUP7_Colors (HexCode, RGBCode, ColorName)  VALUES  ('A6A6A6', '166166166', 'Silver Chalice')
INSERT INTO  GROUP7_Colors (HexCode, RGBCode, ColorName)  VALUES  ('D1D1e0', '209209224', 'Mischka')
INSERT INTO  GROUP7_Colors (HexCode, RGBCode, ColorName)  VALUES  ('E6CCB3', '230204179', 'Bone')
INSERT INTO  GROUP7_Colors (HexCode, RGBCode, ColorName)  VALUES  ('FF3333', '255,51,51', 'Red Orange')
INSERT INTO  GROUP7_Colors (HexCode, RGBCode, ColorName)  VALUES  ('FF9900', '255,153,0', 'Orange Peel')
INSERT INTO  GROUP7_Colors (HexCode, RGBCode, ColorName)  VALUES  ('FFFFCC', '255255204', 'Cream')
INSERT INTO  GROUP7_Colors (HexCode, RGBCode, ColorName)  VALUES  ('FFFFFF', '255255255', 'White')


INSERT INTO  GROUP7_Colors (HexCode, RGBCode, ColorName)  VALUES  ('223E4A', '34,62,74' , 'Green Vogue')
INSERT INTO  GROUP7_Colors (HexCode, RGBCode, ColorName)  VALUES  ('FFCC99', '255204154', 'Peach-Orange')
INSERT INTO  GROUP7_Colors (HexCode, RGBCode, ColorName)  VALUES  ('DDFFCC', '221255204', 'Honeydew')
--INSERT INTO  GROUP7_Colors (HexCode, RGBCode, ColorName)  VALUES  ('A6A6A6', '166166166', 'Dark-Gray')



COMMIT;

BEGIN TRANSACTION
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Banana', null, null)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block', 10, 2)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block', 1, 1)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block', 2, 1)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block', 4, 1)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block', 4, 2)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block', 4, 4)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block', 8, 4)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Slanted', null, null)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Broom', null, null)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Can', null, null)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Curved Block', 4, 1)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Dot', 1, 1)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Hat', null, null)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Head', null, null)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Pants', null, null)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Peg', 1, 1)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Ramp', null, null)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Rod', null, null)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Shovel', null, null)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Steering Wheel', null, null)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Sweeper', null, null)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Torso', null, null)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Wheel', null, null)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Window Shield', null, null)



INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Disk ', 1, 1)
--INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block ', 2, 1)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block ', 3, 2)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Helmut', null, null)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Curved Block ', 2, 1)
--INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block ', 4, 1)
--INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Head', null, null)
--INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Peg ', 1, 1)
--INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block ', 2, 1)
--INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block ', 1, 1)
--INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Peg ', 1, 1)
--INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block ', 2, 1)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Visor', null, null)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Gun', null, null)
--INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Gun', null, null)
--INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block ', 4, 2)
--INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Torso', null, null)
--INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block ', 2, 1)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block ', 2, 2)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block ', 10, 5)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Circle ', 4, 2)
--INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block ', 1, 1)
--INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block ', 4, 1)
--INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Torso', null, null)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Cylinder', null, null)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Circle ', 4, 4)
--INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block ', 1, 1)
--INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block ', 2, 2)
--INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block ', 2, 2)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block ', 7, 1)
--INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Peg ', 1, 1)
--INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block ', 1, 1)
--INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Circle ', 4, 2)
--INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block ', 2, 1)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block ', 3, 1)
--INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block ', 4, 1)
--INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block ', 4, 2)
INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block ', 6, 3)
--INSERT INTO  GROUP7_Shapes (ShapeName, SLength, SWidth)  VALUES  ( 'Block ', 2, 2)



COMMIT;

BEGIN TRANSACTION

INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Slanted'),--Block (
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'A6A6A6'),
 '4567887')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 2 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'A6A6A6'),
 '4543086')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 2 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'A6A6A6'),
 '6273715')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Banana'),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FFFFCC'),
 '4114584')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 2 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'A6A6A6'),
 '4210978')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 10 AND SWidth = 2),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'A6A6A6'),
 '4210678')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 4 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = '009933'),
 '371028')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 4 AND SWidth = 2),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = '009933'),
 '302028')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 4 AND SWidth = 4),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = '009933'),
 '4243821')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 8 AND SWidth = 4),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = '009933'),
 '4277361')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 1 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = '009933'),
 '300528')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 2 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = '009933'),
 '6206248')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 2 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = '009933'),
 '6023083')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 1 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FFFFFF'),
 '307001')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 2 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FFFFFF'),
 '300401')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 2 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FFFFFF'),
 '366001')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 2 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FFFFFF'),
 '6176240')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 2 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FFFFFF'),
 '4533763')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 1 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FFFFFF'),
 '6287776')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 4 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FFFFFF'),
 '4599983')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 4 AND SWidth = 2),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FFFFFF'),
 '6110019')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 4 AND SWidth = 2),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FFFFFF'),
 '4193068')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 1 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FFFFFF'),
 '6245250')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 1 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'E6CCB3'),
 '6252042')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 2 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FFFFCC'),
 '243224')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 2 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FFFFCC'),
 '4501232')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 2 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'D1D1e0'),
 '4494475')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 2 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'D1D1e0'),
 '4509915')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 2 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'E6CCB3'),
 '6092587')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 2 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'E6CCB3'),
 '6251306')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 2 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = '000000'),
 '3023266')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 2 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = '000000'),
 '3200026')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 2 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = '000000'),
 '6020193')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 4 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'D1D1e0'),
 '6071299')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 4 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FF3333'),
 '243121')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block' AND SLength = 4 AND SWidth = 4),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'D1D1e0'),
 '4211569')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Dot' AND SLength = 1 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'E6CCB3'),
 '6240227')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Peg' AND SLength = 1 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'D1D1e0'),
 '6011375')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Peg' AND SLength = 1 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'D1D1e0'),
 '4211807')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Peg' AND SLength = 1 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = '000000'),
 '4508215')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Curved Block' AND SLength = 4 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FFFFFF'),
 '4568156')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Broom'),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = '4D0000'),
 '4211157')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Can'),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = '009933'),
 '6171069')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Hat'),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = '004D99'),
 '6056241')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Head'),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FFFFCC'),
 '6283875')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Pants'),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FF9900'),
 '4120158')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Ramp'),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FFFFFF'),
 '6179658')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Rod'),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'A6A6A6'),
 '6083620')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Rod'),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'E6CCB3'),
 '4666579')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Shovel'),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'A6A6A6'),
 '4211006')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Steering Wheel'),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FFFFCC'),
 '9553')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Sweeper'),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = '004D99'),
 '6270144')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Torso'),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FF9900'),
 '6102597')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Wheel'),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = '004D99'),
 '6224999')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Window Shield'),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'D1D1e0'),
 '6244759')

 INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Disk ' AND SLength = 1 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FFFFFF'),
 '474001')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block ' AND SLength = 2 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FFFFFF'),
 '379401')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block ' AND SLength = 3 AND SWidth = 2),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FFFFFF'),
 '302101')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Helmut'),-- AND SLength = null AND SWidth = null),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FFFFFF'),
 '4520262')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Curved Block ' AND SLength = 2 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FFFFFF'),
 '4160387')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block ' AND SLength = 4 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = '223E4A'),
 '4206667')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Head'),-- AND SLength = null AND SWidth = null),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FFCC99'),
 '4520588')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Peg ' AND SLength = 1 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'DDFFCC'),
 '4183544')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block ' AND SLength = 2 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FFCC99'),
 '4124456')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block ' AND SLength = 1 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'FFCC99'),
 '4121972')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Peg ' AND SLength = 1 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = '000000'),
 '73587')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block ' AND SLength = 2 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = '000000'),
 '306962')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Visor'),-- AND SLength = null AND SWidth = null),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = '000000'),
 '244726')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Gun'),-- AND SLength = null AND SWidth = null),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = '000000'),
 '4498713')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Gun'),-- AND SLength = null AND SWidth = null),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = '000000'),
 '4498712')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block ' AND SLength = 4 AND SWidth = 2),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = '000000'),
 '368026')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Torso'),-- AND SLength = null AND SWidth = null),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = '000000'),
 '4520576')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block ' AND SLength = 2 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = '000000'),
 '4113027')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block ' AND SLength = 2 AND SWidth = 2),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = '000000'),
 '4164067')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block ' AND SLength = 10 AND SWidth = 5),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = '000000'),
 '303626')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Circle ' AND SLength = 4 AND SWidth = 2),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'A6A6A6'),
 '4211439')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block ' AND SLength = 1 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'A6A6A6'),
 '4216250')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block ' AND SLength = 4 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'A6A6A6'),
 '4211356')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Pants'),-- AND SLength = null AND SWidth = null), 
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'A6A6A6'),
 '4227657')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Cylinder'),-- AND SLength = null AND SWidth = null),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'A6A6A6'),
 '4299119')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Circle ' AND SLength = 4 AND SWidth = 4),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'A6A6A6'),
 '4515351')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block ' AND SLength = 1 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'A6A6A6'),
 '4211494')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block ' AND SLength = 2 AND SWidth = 2),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'A6A6A6'),
 '4212008')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block ' AND SLength = 2 AND SWidth = 2),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'A6A6A6'),
 '4212007')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block ' AND SLength = 7 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'A6A6A6'),
 '4509914')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Peg ' AND SLength = 1 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'A6A6A6'),
 '4210633')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block ' AND SLength = 1 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'A6A6A6'),
 '4210632')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Circle ' AND SLength = 4 AND SWidth = 2),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'A6A6A6'),
 '4278274')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block ' AND SLength = 2 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'A6A6A6'),
 '4211087')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block ' AND SLength = 3 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'A6A6A6'),
 '4211133')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block ' AND SLength = 4 AND SWidth = 1),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'A6A6A6'),
 '4211001')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block ' AND SLength = 4 AND SWidth = 2),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'A6A6A6'),
 '4211065')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block ' AND SLength = 6 AND SWidth = 3),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'A6A6A6'),
 '4210984')
INSERT INTO GROUP7_Pieces (ShapeID, ColorID, Part)
VALUES (
(SELECT ShapeID FROM GROUP7_Shapes WHERE ShapeName = 'Block ' AND SLength = 2 AND SWidth = 2),
(SELECT ColorID FROM GROUP7_Colors WHERE HexCode = 'A6A6A6'),
 '4210873')


COMMIT;


BEGIN TRANSACTION



INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4567887'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4543086'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '6273715'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4114584'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4210978'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4210678'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '371028'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '302028'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4243821'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4277361'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '300528'),
 '4')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '6206248'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '6023083'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '307001'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '300401'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '366001'),
 '4')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '6176240'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4533763'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '6287776'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4599983'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '6110019'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4193068'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '6245250'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '6252042'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '243224'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4501232'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4494475'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4509915'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '6092587'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '6251306'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '3023266'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '3200026'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '6020193'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '6071299'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '243121'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4211569'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '6240227'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '6011375'),
 '4')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4211807'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4508215'),
 '4')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4568156'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4211157'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '6171069'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '6056241'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '6283875'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4120158'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '6179658'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '6083620'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4666579'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4211006'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '9553'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '6270144'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '6102597'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '6224999'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '6244759'),
 '1')


INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '474001'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '379401'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '302101'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4520262'),
 '4')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4160387'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4206667'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4520588'),
 '4')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4183544'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4124456'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4121972'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '73587'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),

(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '306962'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '244726'),
 '4')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4498713'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4498712'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '368026'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4520576'),
 '4')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4113027'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4164067'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '303626'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4211439'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4216250'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4211356'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4227657'),
 '4')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4299119'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4515351'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4211494'),
 '4')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4212008'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4212007'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4509914'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4210633'),
 '4')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4210632'),
 '4')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4278274'),
 '4')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4211087'),
 '1')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4211133'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4211001'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4211065'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4210984'),
 '2')
INSERT INTO GROUP7_SetPieces (SetID,PieceID,Quantity)
VALUES (
(SELECT SetID FROM GROUP7_Sets WHERE SetName = 'Rebel Scout Speeder'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4210873'),
 '1')





COMMIT;

BEGIN TRANSACTION

INSERT INTO GROUP7_MiniFigures (FigureName)
VALUES('Street Sweeper');

INSERT INTO GROUP7_MiniFigures (FigureName)
VALUES('Rebel Scout');

COMMIT;



/*

CREATE TABLE GROUP7_FiguresPieces
(
    FigurePieceID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    FigureID int NOT NULL,
    PieceID int NOT NULL
);
*/
BEGIN TRANSACTION

INSERT INTO GROUP7_FiguresPieces (FigureID, PieceID)
VALUES((SELECT FigureID FROM GROUP7_MiniFigures WHERE FigureName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '6283875')) --HEAD


INSERT INTO GROUP7_FiguresPieces (FigureID, PieceID)
VALUES((SELECT FigureID FROM GROUP7_MiniFigures WHERE FigureName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '6102597')) --body


INSERT INTO GROUP7_FiguresPieces (FigureID, PieceID)
VALUES((SELECT FigureID FROM GROUP7_MiniFigures WHERE FigureName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4120158')) --legs


INSERT INTO GROUP7_FiguresPieces (FigureID, PieceID)
VALUES((SELECT FigureID FROM GROUP7_MiniFigures WHERE FigureName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '6056241')) --hat


INSERT INTO GROUP7_FiguresPieces (FigureID, PieceID)
VALUES((SELECT FigureID FROM GROUP7_MiniFigures WHERE FigureName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4211157')) --broom


INSERT INTO GROUP7_FiguresPieces (FigureID, PieceID)
VALUES((SELECT FigureID FROM GROUP7_MiniFigures WHERE FigureName = 'Street Sweeper'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4211006')) --shovel
/*
4211006 --shovel
4211157 --broom
6056241 --hat
6283875 --head
6102597 --body
4120158 --legs
*/

/*

4520262 -- hat
244726 -- visor
4498713 -- gun1
4498712 -- gun2
4520588 -- head
4520576 -- body
4227657 -- legs
*/
INSERT INTO GROUP7_FiguresPieces (FigureID, PieceID)
VALUES((SELECT FigureID FROM GROUP7_MiniFigures WHERE FigureName = 'Rebel Scout'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4520262')); --hat

INSERT INTO GROUP7_FiguresPieces (FigureID, PieceID)
VALUES((SELECT FigureID FROM GROUP7_MiniFigures WHERE FigureName = 'Rebel Scout'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '244726')); --visor

INSERT INTO GROUP7_FiguresPieces (FigureID, PieceID)
VALUES((SELECT FigureID FROM GROUP7_MiniFigures WHERE FigureName = 'Rebel Scout'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4498713')); --gun1

INSERT INTO GROUP7_FiguresPieces (FigureID, PieceID)
VALUES((SELECT FigureID FROM GROUP7_MiniFigures WHERE FigureName = 'Rebel Scout'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4498712')); --gun2

INSERT INTO GROUP7_FiguresPieces (FigureID, PieceID)
VALUES((SELECT FigureID FROM GROUP7_MiniFigures WHERE FigureName = 'Rebel Scout'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4520588')); --head

INSERT INTO GROUP7_FiguresPieces (FigureID, PieceID)
VALUES((SELECT FigureID FROM GROUP7_MiniFigures WHERE FigureName = 'Rebel Scout'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4520576')); --body

INSERT INTO GROUP7_FiguresPieces (FigureID, PieceID)
VALUES((SELECT FigureID FROM GROUP7_MiniFigures WHERE FigureName = 'Rebel Scout'),
(SELECT PieceID FROM GROUP7_Pieces WHERE Part = '4227657')); --legs


COMMIT;
/*
 SELECT *
 FROM GROUP7_SetPieces
 */
