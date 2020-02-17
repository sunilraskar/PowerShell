---Use this simple script to give a user Read Only Permission  to a Windows Account or Group.
---As per the DCS Security polices all Infra Support Team members 
-- Will have read only permissions on all databases on a Server

-- Instrcution for using the script.
-- Step 1 - Set the @WindowsAccount variable to 
-- individual user account or a windows security group and run the script.

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
Select @command = 'use [?]; CREATE USER IF NOT EXISTS ' + @WindowsAccount + ' FOR LOGIN ' + @WindowsAccount + '; ALTER ROLE [db_datareader] ADD MEMBER [' + @WindowsAccount + ']';
print @command

--Careful Uncomment's only When to run the script on all database
EXEC sp_MSforeachdb @command;

--Print and test the Command 
--Declare @command as varchar(500);
--Declare @WindowsAccount as varchar(100)='GLS\ss' ;
--Select @command = 'use [?];CREATE USER IF NOT EXISTS ' + @WindowsAccount + ' FOR LOGIN ' + @WindowsAccount + ';ALTER ROLE [db_datareader] ADD MEMBER ''' + @WindowsAccount + '''';
--Select @command