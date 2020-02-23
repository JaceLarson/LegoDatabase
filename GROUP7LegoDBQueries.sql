/*
	CS3550
GROUP 7 Lego Database Scripts
Andrew Hammon
Jace Larson
Luke Munk
Michael Bradshaw

*/

/*
A query that exports out a list of mini figures and their associated theme, set, and parts
*/
SELECT 
	MF.FigureName AS [Figure Name], 
	T.ThemeName AS Theme, 
	S.SetName AS [Set Name], 
	SH.ShapeName AS [Part Name], 
	P.Part AS [Part Number]

FROM  
	GROUP7_FiguresPieces AS FP
	INNER JOIN GROUP7_MiniFigures AS MF ON FP.FigureID = MF.FigureID 
	INNER JOIN GROUP7_Pieces AS P ON FP.PieceID = P.PieceID 
	INNER JOIN GROUP7_Shapes AS SH ON P.ShapeID = SH.ShapeID 
	INNER JOIN GROUP7_SetPieces AS SP ON P.PieceID = SP.PieceID 
	INNER JOIN GROUP7_Sets AS S ON SP.SetID = S.SetID 
	INNER JOIN GROUP7_Themes AS T ON S.ThemeID = T.ThemeID

GO

/*
A query that generates a list of pieces for a given set
Created stored procedure GROUP7_GetSetPieces which generates a list of pieces for a given set, passed as 'SetName' in
EXEC statement
*/
DROP PROCEDURE IF EXISTS GROUP7_GetSetPieces;

GO

CREATE PROCEDURE GROUP7_GetSetPieces
	@SetName AS VARCHAR(255)
AS
BEGIN
	SELECT 
		S.SetID AS [Set Number],
		S.SetName AS [Set Name],
		P.Part AS [Part Number],
		SH.ShapeName [Shape],
		C.ColorName [Color],
		SP.Quantity [Number of Pieces]

	FROM
		GROUP7_Colors AS C
		INNER JOIN GROUP7_Pieces AS P ON C.ColorID = P.ColorID
		INNER JOIN GROUP7_SetPieces AS SP ON P.PieceID = SP.PieceID
		INNER JOIN GROUP7_Sets AS S ON SP.SetID = S.SetID
		INNER JOIN GROUP7_Shapes AS SH ON P.ShapeID = SH.ShapeID

	WHERE
		S.SetName = @SetName

	ORDER BY
		P.Part
END;

GO

EXEC GROUP7_GetSetPieces 'Street Sweeper'; --returns a list of pieces for the Street Sweeper set

EXEC GROUP7_GetSetPieces 'Rebel Scout Speeder'; --returns a list of pieces for the Rebel Scout Speeder

GO

/*
A list of sets I currently owned (make the details up).  Your query should return the theme, set name, 
set number, how many pieces, and when it was received
*/
SELECT 
	
	T.ThemeName AS Theme, 
	S.SetName AS [Set Name], 
	S.SetID AS [Set Number], 
	Sum(SP.Quantity) AS [Total Pieces], 
	P.DateOfPurchase AS [Date Received]

FROM  
	GROUP7_Purchases AS P
	INNER JOIN GROUP7_Sets AS S ON P.SetID = S.SetID 
	INNER JOIN GROUP7_SetPieces AS SP ON S.SetID = SP.SetID 
	INNER JOIN GROUP7_Themes AS T ON S.ThemeID = T.ThemeID

GROUP BY 
	T.ThemeName, 
	S.SetName, 
	S.SetID, 
	P.DateOfPurchase

ORDER BY
	P.DateOfPurchase;
	

