-- Check user options and one of the is isolation level
DBCC USEROPTIONS;

/*
Change isolation level in the session to REPEATABLE READ which prevents
to update or delete data that is read in the current transaction by other transaction.
Moreover, it prevents non repeatable read problem.
 NON REPEATABLE READ:
 1- first query return Stock 10
 2- second query return Stock 1 (in the same trasaction) because a modification in another trasaction

*/
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

UPDATE
	Miscellaneous.dbo.ProductStock 
SET
	Stock = 10
WHERE 
	Id = 1

SELECT * FROM ProductStock


BEGIN TRY
	DECLARE @Stock INT = 0;

	BEGIN TRANSACTION
		
		SELECT
			@Stock = Stock
		FROM
			Miscellaneous.dbo.ProductStock
		WHERE 
			Id = 1

		PRINT 'previous stock ' + CAST(@Stock AS VARCHAR)

		SET @Stock = @Stock - 2;

	    WAITFOR DELAY '00:00:20';

		UPDATE
			Miscellaneous.dbo.ProductStock 
		SET
			Stock = @Stock
		WHERE 
			Id = 1

		PRINT @Stock

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	PRINT 'ROLLBACK'
	ROLLBACK TRANSACTION
END CATCH

-- 

BEGIN TRY
	
	DECLARE @Stock INT = 0;

	BEGIN TRANSACTION
		
		SELECT
			@Stock = Stock
		FROM
			Miscellaneous.dbo.ProductStock
		WHERE 
			Id = 1

		PRINT 'previous stock ' + CAST(@Stock AS VARCHAR)

		SET @Stock = @Stock - 1;

		UPDATE
			Miscellaneous.dbo.ProductStock 
		SET
			Stock = @Stock
		WHERE 
			Id = 1

		PRINT @Stock

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION

	PRINT 'ROLLBACK'
END CATCH
