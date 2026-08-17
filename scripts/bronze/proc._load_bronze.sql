/*
===================================
	BRONZE: TRUNCATE AND INSERT
===================================
Purpose:
		This is to truncate the data if exist. Full load using bulk insert.
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN TRY
	BEGIN TRAN
		DECLARE @startdate DATE, @enddate DATE, @batchstartdate DATE, @batchenddate DATE;

		PRINT '==================='
		PRINT 'LOADING BRONZE LAYER'
		PRINT '==================='

		SET @batchstartdate = GETDATE()
		SET @startdate = GETDATE()
		PRINT '>>>>>TRUNCATE table bronze.data_dictionary'
		TRUNCATE TABLE bronze.data_dictionary;
		PRINT '>>>>>INSERT table bronze.data_dictionary'
		BULK INSERT bronze.data_dictionary
		FROM 'C:\DATA WAREHOUSE\MEDALLION ARCHITECTURE\Maven+Fuzzy+Factory\data_dictionary.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @enddate = GETDATE()
		PRINT '>>>>>Duration: ' + CAST(DATEDIFF(SECOND ,@startdate, @enddate) as NVARCHAR) + ' seconds';
		PRINT '=========================================================='

		/*
		===================
		bronze.order_item_refunds
		===================
		*/
		SET @startdate = GETDATE()
		PRINT '>>>>>TRUNCATE table bronze.order_item_refunds'
		TRUNCATE TABLE bronze.order_item_refunds;
		PRINT '>>>>>INSERT table bronze.order_item_refunds'
		BULK INSERT bronze.order_item_refunds
		FROM 'C:\DATA WAREHOUSE\MEDALLION ARCHITECTURE\Maven+Fuzzy+Factory\order_item_refunds.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @enddate = GETDATE()
		PRINT '>>>>>Duration: ' + CAST(DATEDIFF(SECOND ,@startdate, @enddate) as NVARCHAR) + ' seconds';
		PRINT '=========================================================='

		/*
		===================
		bronze.order_items
		===================
		*/
		SET @startdate = GETDATE()
		PRINT '>>>>>TRUNCATE table bronze.order_items'
		TRUNCATE TABLE bronze.order_items;
		PRINT '>>>>>INSERT table bronze.order_items'
		BULK INSERT bronze.order_items
		FROM 'C:\DATA WAREHOUSE\MEDALLION ARCHITECTURE\Maven+Fuzzy+Factory\order_items.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @enddate = GETDATE()
		PRINT '>>>>>Duration: ' + CAST(DATEDIFF(SECOND ,@startdate, @enddate) as NVARCHAR) + ' seconds';
		PRINT '=========================================================='


		/*
		===================
		bronze.orders
		===================
		*/
		SET @startdate = GETDATE()
		PRINT '>>>>>TRUNCATE table bronze.orders'
		TRUNCATE TABLE bronze.orders;
		PRINT '>>>>>INSERT table bronze.orders'
		BULK INSERT bronze.orders
		FROM 'C:\DATA WAREHOUSE\MEDALLION ARCHITECTURE\Maven+Fuzzy+Factory\orders.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @enddate = GETDATE()
		PRINT '>>>>>Duration: ' + CAST(DATEDIFF(SECOND ,@startdate, @enddate) as NVARCHAR) + ' seconds';
		PRINT '=========================================================='


		/*
		===================
		bronze.products
		===================
		*/
		SET @startdate = GETDATE()
		PRINT '>>>>>TRUNCATE table bronze.products'
		TRUNCATE TABLE bronze.products;
		PRINT '>>>>>INSERT table bronze.products'
		BULK INSERT bronze.products
		FROM 'C:\DATA WAREHOUSE\MEDALLION ARCHITECTURE\Maven+Fuzzy+Factory\products.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @enddate = GETDATE()
		PRINT '>>>>>Duration: ' + CAST(DATEDIFF(SECOND ,@startdate, @enddate) as NVARCHAR) + ' seconds';
		PRINT '=========================================================='


		/*
		===================
		bronze.website_pageviews
		===================
		*/
		SET @startdate = GETDATE()
		PRINT '>>>>>TRUNCATE table bronze.website_pageviews'
		TRUNCATE TABLE bronze.website_pageviews;
		PRINT '>>>>>INSERT table bronze.website_pageviews'
		BULK INSERT bronze.website_pageviews
		FROM 'C:\DATA WAREHOUSE\MEDALLION ARCHITECTURE\Maven+Fuzzy+Factory\website_pageviews.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @enddate = GETDATE()
		PRINT '>>>>>Duration: ' + CAST(DATEDIFF(SECOND ,@startdate, @enddate) as NVARCHAR) + ' seconds';
		PRINT '=========================================================='


		/*
		===================
		bronze.website_sessions
		===================
		*/
		SET @startdate = GETDATE()
		PRINT '>>>>>TRUNCATE table bronze.website_sessions'
		TRUNCATE TABLE bronze.website_sessions;
		PRINT '>>>>>INSERT table bronze.website_sessions'
		BULK INSERT bronze.website_sessions
		FROM 'C:\DATA WAREHOUSE\MEDALLION ARCHITECTURE\Maven+Fuzzy+Factory\website_sessions.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @enddate = GETDATE()
		PRINT '>>>>>Duration: ' + CAST(DATEDIFF(SECOND ,@startdate, @enddate) as NVARCHAR) + ' seconds';
		PRINT '=========================================================='

		PRINT '====================='
		PRINT 'Loading Bronze layer is Completed';
		PRINT 'Total Load Duration: ' + CAST(DATEDIFF(second, @startdate, @enddate) as NVARCHAR) + ' seconds';
		PRINT '====================='


	COMMIT TRAN
END TRY
BEGIN CATCH
		PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	IF XACT_STATE() <> 0 ROLLBACK TRAN;
    THROW;
END CATCH
