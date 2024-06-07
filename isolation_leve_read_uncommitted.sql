-- Check user options and one of the is isolation level
DBCC USEROPTIONS;

BEGIN TRY
	BEGIN TRANSACTION
		UPDATE
			Miscellaneous.dbo.ProductStock 
		SET
			Stock = 8

		WAITFOR DELAY '00:00:10';
		THROW 50000, 'ERROR COMMIT', 1;
END TRY
BEGIN CATCH
	PRINT 'ROLLBACK'
	ROLLBACK
END CATCH

-- Change isolation level in the session
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SELECT 
	*
FROM 
	Miscellaneous.dbo.ProductStock 

