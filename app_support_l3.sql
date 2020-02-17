Declare @command as varchar(500);
Declare @WindowsAccount as varchar(100);
Set @WindowsAccount='GLS\ss'  -- Configure the Windows Account
-- Create SQL Server logins for a give windows account

Select @command =  'IF SUSER_ID (N''' + @WindowsAccount +  ''') IS NULL CREATE LOGIN [' + @WindowsAccount + '] From Windows';
Print @command

--Uncomments when you want to run the command 
--EXEC @command;

--Create the database user for a given windows account and for all the databases on a server 
--and assign read only permissions for the account on all databases of the server
Select @command = 'use [?];IF SUSER_ID (N'''+@WindowsAccount+''') IS NULL CREATE USER [' +@WindowsAccount+'] FOR LOGIN [' + @WindowsAccount + '];IF DATABASE_PRINCIPAL_ID(''app_support_l3'') IS NULL CREATE ROLE app_support_l3; GRANT EXECUTE TO app_support_l3;'
Select @command = @command +  'ALTER ROLE [app_support_l3] ADD MEMBER [' +  @WindowsAccount + ']; ALTER ROLE [db_datareader] ADD MEMBER [' + @WindowsAccount + ']';
print @command

--Careful Uncomment's only When to run the script on all databases
--EXEC sp_MSforeachdb @command;







