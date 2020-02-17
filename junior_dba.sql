-- This Create Define the Junior DBA role 
-- 


Declare @command as varchar(500);
Declare @WindowsAccount as varchar(100);
Set @WindowsAccount='GLS\dba_junioradmin'  -- Configure the Windows Account

--Create SQL Server logins for a give windows account

Select @command =  'Use master; IF SUSER_ID (N''' + @WindowsAccount +  ''') IS NULL CREATE LOGIN [' + @WindowsAccount + '] From Windows';

Print @command

Exec (@command)



-- create the Role if it does not exist.
Select @command =  'Use master ; IF NOT EXISTS(SELECT name FROM sys.server_principals WHERE type = ''R'' AND name=''svr_juniorDBA'')  CREATE SERVER ROLE svr_juniorDBA'

Print @command

Exec (@command)

-- Add Member to the Server Role

--Select @command = 'ALTER SERVER ROLE svr_juniorDBA ADD MEMBER ' + @WindowsAccount
--Exec (@command)

-- Add the Windows account to the role member list.
 Select @command ='sp_addsrvrolemember ''' + @WindowsAccount + ''''+ ',' + 'svr_juniorDBA';
 Exec (@command)


---create a dba_junioradmin Role at all database level with limited access.

 
Select @command = 'use [?];  IF NOT EXISTS (SELECT [name] FROM [sys].[database_principals] WHERE [name] = N'''+@WindowsAccount+''') CREATE USER [' +@WindowsAccount+'] FOR LOGIN [' + @WindowsAccount + '];IF DATABASE_PRINCIPAL_ID(''db_junioradmin'') IS NULL CREATE ROLE db_junioradmin; DENY UPDATE TO db_junioradmin; DENY DELETE TO db_junioradmin; DENY ALTER TO db_junioradmin; DENY EXECUTE TO db_junioradmin;'
Select @command = @command +  '; ALTER ROLE [db_junioradmin] ADD MEMBER [' +  @WindowsAccount + ']';
print @command
--Careful Uncomment's only When to run the script on all database
--EXEC sp_MSforeachdb @command;



----- Test Script
/* Use master
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


Use TestTempDB1
go

CREATE USER [juniordbaUser1] FOR LOGIN juniordbalgoin
GO

 

ALTER ROLE db_junioradmin ADD MEMBER [juniordbaUser1]
GO
*/



--Use master
--Execute As Login= 'GLS\WindowsUser3'






  