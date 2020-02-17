
-- Create Login for A Windows Account
-- Add a Windows Account to Sys Admin 
-- First Configure the Windows Account

Declare @command as varchar(500);
Declare @WindowsAccount as varchar(100);
Set @WindowsAccount='GLS\WindowsUser3'  -- Configure the Windows Account

-- Create SQL Server logins for a give windows account

Select @command =  'IF SUSER_ID (N''' + @WindowsAccount +  ''') IS NULL CREATE LOGIN [' + @WindowsAccount + '] From Windows';
Print @command

--Uncomments when you want to run the command 
EXEC @command;

--Create the database user for a given windows account and for all the databases on a server 
--and assign read only permissions for the account on all databases of the server
--Select @command = 'use [?];CREATE USER IF NOT EXISTS ' + @WindowsAccount + ' FOR LOGIN ' + @WindowsAccount + ';ALTER ROLE [db_junioradmin] ADD MEMBER ''' + @WindowsAccount + '''';
--Select @command = 'use master;ALTER ROLE [sysadmin] ADD MEMBER [' + @WindowsAccount + ']';

 Select @command = 'use master; sp_addrolemember ' + '''sysadmin''' + ', [' +  @WindowsAccount + ']';

print @command
EXEC (@command);

