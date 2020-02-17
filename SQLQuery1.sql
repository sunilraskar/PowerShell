---Use this simple script to create a dba_junioradmin.
---As per the DCS Security polices all dba_junioradmin team members 
-- will have limi 

Use master
CREATE SERVER ROLE svr_juniorDBA
GO

GRANT CONTROL SERVER TO svr_juniorDBA --- The member of this server Role will have the sysadmin rights until you explictly deny specific permissions. 
GO 


Create Database TestTempDB1

--Create database role and deny permssion to the junor DBA
 
 Use TestTempDB1

CREATE ROLE db_junioradmin
GO

DENY UPDATE TO db_junioradmin
GO

DENY DELETE TO db_junioradmin
GO 

DENY ALTER TO db_junioradmin
GO

DENY EXECUTE TO db_junioradmin
GO 
 

CREATE LOGIN juniordbalgoin WITH PASSWORD=N'Temp@1234', DEFAULT_DATABASE=TestTempDB1, CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO




ALTER SERVER ROLE svr_juniorDBA ADD MEMBER juniordbalgoin
GO

 
CREATE USER [juniordbaUser1] FOR LOGIN juniordbalgoin
GO

 

ALTER ROLE db_junioradmin ADD MEMBER [juniordbaUser1]
GO


-- Create the db_junioradmin Database Roles for all databases on a server.

Declare @command as varchar(500);
Declare @WindowsAccount as varchar(100);
Set @WindowsAccount='GLS\WindowsUser3'  -- Configure the Windows Account
-- Create SQL Server logins for a give windows account

Select @command =  'IF SUSER_ID (N''' + @WindowsAccount +  ''') IS NULL CREATE LOGIN [' + @WindowsAccount + '] From Windows';
Print @command

--Uncomments when you want to run the command 
--EXEC @command;

--Create the database user for a given windows account and for all the databases on a server 
--and assign read only permissions for the account on all databases of the server
--Select @command = 'use [?];CREATE USER IF NOT EXISTS ' + @WindowsAccount + ' FOR LOGIN ' + @WindowsAccount + ';ALTER ROLE [db_junioradmin] ADD MEMBER ''' + @WindowsAccount + '''';
Select @command = 'use [?];IF SUSER_ID (N'''+@WindowsAccount+''') IS NULL CREATE USER [' +@WindowsAccount+'] FOR LOGIN [' + @WindowsAccount + '];ALTER ROLE [db_junioradmin] ADD MEMBER [' + @WindowsAccount + ']';
print @command

--Careful Uncomment's only When to run the script on all database
EXEC sp_MSforeachdb @command;