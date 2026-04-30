CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time  DATETIME , @batch_start_time DATETIME , @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		-- load cust_info table
		PRINT '=========================';
		PRINT 'LOADING BRONZE LAYER';
		PRINT '=========================';
		PRINT 'LOADING DATA OF SOURCE CRM';
		PRINT 'LOADING.. CUST_INFO';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_cust_info;
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\yogesh singh\Downloads\SQL Learning\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'LOADED COMPLETELY CUST_INFO'; 
		PRINT '>> LOAD DURATION:' + CAST( DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) +' SECONDS';
		PRINT 'LOADING.. PRD_INFO';
		-- load prd_info table
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\yogesh singh\Downloads\SQL Learning\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION:' + CAST( DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) +' SECONDS';
		PRINT 'LOADED COMPLETELY PRD_INFO';

		PRINT 'LOADING.. SALES_DETAILS';
		-- load sales_details table
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details;
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\yogesh singh\Downloads\SQL Learning\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION:' + CAST( DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) +' SECONDS';

		PRINT 'LOADED COMPLETELY SALES_DETAILS';


		PRINT 'LOADING DATA OF SOURCE ERP';
		PRINT 'LOADING.. CUST_AZ12';
		-- load cust_az12 table
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_cust_az12;
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\yogesh singh\Downloads\SQL Learning\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION:' + CAST( DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) +' SECONDS';
		PRINT 'LOADED COMPLETELY CUST_AZ12';

		PRINT 'LOADING.. LOC_A101';
		-- load loc_a101 table
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101;
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\yogesh singh\Downloads\SQL Learning\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION:' + CAST( DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) +' SECONDS';
		PRINT 'LOADED COMPLETELY LOC_A101';

		PRINT 'LOADING.. PX_CAT_G1V2';
		-- load px_cat_g1v2
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_px_cat_g1v2
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\yogesh singh\Downloads\SQL Learning\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION:' + CAST( DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) +' SECONDS';
		PRINT 'LOADED COMPLETELY PX_CAT_G1V2';

		PRINT '==========================';
		PRINT 'COMPLETE DATA IS LOADED';
		PRINT '==========================';
		SET @batch_end_time = GETDATE();

		print 'load whole bronze layer '+ cast( datediff(second,@batch_start_time,@batch_end_time) as nvarchar)+' seconds';
	END TRY
	BEGIN CATCH
		PRINT '============================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'ERROR MESSAGE :'+ ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE :'+ CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR MESSAGE :'+ CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '============================';

	END CATCH
END
