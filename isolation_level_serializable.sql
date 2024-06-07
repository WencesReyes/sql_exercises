DBCC USEROPTIONS;

/*
Sets isolation level to serializable.
It prevents:
	- Dirty reads.
	- Lost updates.
	- Non repeatable reads (No Updates or deletes allowed in records that current transaction is using).
	- Phantom reads (No inserts allowed in tables that current transaction is using, thus get more rows).
*/
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

BEGIN TRY

	BEGIN TRANSACTION
		
		SELECT 
			* 
		FROM 
			Miscellaneous.dbo.ProductStock
		WHERE 
			Stock BETWEEN 1 AND 20

		WAITFOR DELAY '00:00:15';

		SELECT 
			* 
		FROM 
			Miscellaneous.dbo.ProductStock
		WHERE 
			Stock BETWEEN 1 AND 20

	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION

	PRINT 'ROLLBACK'
END CATCH

INSERT INTO 
	Miscellaneous.dbo.ProductStock
VALUES
	(45)
