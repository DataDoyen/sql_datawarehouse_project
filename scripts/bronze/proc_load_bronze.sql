/*
========================================================================================
STORED PROCEDURE: Load Bronze Layer (Source -> Bronze)
========================================================================================

Script Purpose:
	This Stored Procedure loads data into the 'bronze' schema from 
	external CSV files.
	It performs the following actions:
	- Truncates the bronze tables before loading data.
	- Uses the 'BULK INSERT' command to load data from csv files to bronze table

Parameters:
	None.
	This stored procedure does not accept any parameters or return any values.

Usage Examples: 
	EXEC_bronze.load_bronze;

=======================================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @bronze_layer_Start_time DATETIME, @bronze_layer_end_time DATETIME;
	BEGIN TRY 
		SET @bronze_layer_Start_time = GETDATE();
		PRINT '====================================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '====================================================================';

		PRINT '--------------------------------------------------------------------';
		PRINT 'Loading Source CRM Tables';
		PRINT '--------------------------------------------------------------------';
	
		------------------ LOADING 'bronze.crm_cust_info' table files
		SET @start_time = GETDATE();
		PRINT '>> Truncating the table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT 'Inserting data into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\BEATRICE\Documents\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>> -----------------------------------------------';


		--------------- LOADING 'bronze.crm_prd_info' table files
		SET @start_time = GETDATE();
		PRINT '>> Truncating the table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT 'Inserting data into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\BEATRICE\Documents\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>> -----------------------------------------------';


		-------------- LOADING 'bronze.crm_sales_details' table files
		SET @start_time = GETDATE();
		PRINT '>> Truncating the table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT 'Inserting data into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\BEATRICE\Documents\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>> -----------------------------------------------';

		PRINT '--------------------------------------------------------------------';
		PRINT 'Loading Source ERP Tables';
		PRINT '--------------------------------------------------------------------';
	
		-------------- LOADING 'bronze.erp_cust_az12' table files
		SET @start_time = GETDATE();
		PRINT '>> Truncating the table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT 'Inserting data into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\BEATRICE\Documents\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>> -----------------------------------------------';


		-------------- LOADING 'bronze.erp_loc_a101' table files
		SET @start_time = GETDATE();
		PRINT '>> Truncating the table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT 'Inserting data into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\BEATRICE\Documents\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>> -----------------------------------------------';


		-------------- LOADING 'bronze.erp_px_cat_g1v2' table files
		SET @start_time = GETDATE();
		PRINT '>> Truncating the table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT 'Inserting data into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\BEATRICE\Documents\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>> -----------------------------------------------';
		
		SET @bronze_layer_end_time = GETDATE();
		PRINT '====================================================================';
		PRINT 'Loading Bronze Layer is complete';
		PRINT 'Whole Batch Load Duration: ' + CAST(DATEDIFF(second, @bronze_layer_start_time, @bronze_layer_end_time) AS NVARCHAR) + ' seconds';
		PRINT '====================================================================';
	END TRY
	BEGIN CATCH
		PRINT '====================================================================';
		PRINT 'ERROR OCCURED DURING LOADING OF BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Number' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error State' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '====================================================================';
	END CATCH
END


EXEC bronze.load_bronze;
