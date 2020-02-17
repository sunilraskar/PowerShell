--bi_admin Database Role
--Read, Write and Execute Permissions

Declare @command as varchar(500),@WindowsAccount as varchar(255)='GLS\bi_admingroup'
Set @WindowsAccount='GLS\bi_admingroup'  -- Configure the Windows Account / Security Group
--Create SQL Server logins for a give windows account

Select @command =  'IF SUSER_ID (N''' + @WindowsAccount +  ''') IS NULL CREATE LOGIN [' + @WindowsAccount + '] From Windows';
Print @command
EXEC (@command);

--Create the database user for a given windows account and for all the databases on a server 
--and assign read only permissions for the account on all databases of the server

Select @command = 'use [?]; IF NOT EXISTS (SELECT [name] FROM [sys].[database_principals] WHERE [name] = N'''+@WindowsAccount+''')  CREATE USER [' +@WindowsAccount+'] FOR LOGIN [' + @WindowsAccount + '];IF DATABASE_PRINCIPAL_ID(''bi_admin'') IS NULL CREATE ROLE bi_admin; GRANT EXECUTE TO bi_admin;'
Select @command = @command +  'ALTER ROLE [bi_admin] ADD MEMBER [' +  @WindowsAccount + ']';
Select @command = @command +  '; ALTER ROLE [db_datareader] ADD MEMBER [' +  @WindowsAccount + ']';
Select @command = @command +  '; ALTER ROLE [db_datawriter] ADD MEMBER [' +  @WindowsAccount + ']';

print @command

--EXEC sp_MSforeachdb @command;

-- Select @command = 'sp_addrolemember ' + '''bi_admin''' + ', [' +  @WindowsAccount + ']';

 --print @command
 --EXEC (@command);
 
 --Select @command = 'sp_addrolemember ' + '''db_datareader''' + ', [' +  @WindowsAccount + ']';
 
 --print @command
 --EXEC (@command);


 --Select @command = 'sp_addrolemember ' + '''db_datawriter''' + ', [' +  @WindowsAccount + ']';
 
 --print @command
 --EXEC (@command);



 use TempTestDB5; IF NOT EXISTS (SELECT [name] FROM [sys].[database_principals] WHERE [name] = N'GLS\bi_admingroup')  CREATE USER [GLS\bi_admingroup] FOR LOGIN [GLS\bi_admingroup];IF DATABASE_PRINCIPAL_ID('bi_admin') IS NULL CREATE ROLE bi_admin; GRANT EXECUTE TO bi_admin;ALTER ROLE [bi_admin] ADD MEMBER [GLS\bi_admingroup]; ALTER ROLE [db_datareader] ADD MEMBER [GLS\bi_admingroup]; ALTER ROLE [db_datawriter] ADD MEMBER [GLS\bi_admingroup]



 


IF SUSER_ID (N'GLS\bi_admingroup') IS NULL CREATE LOGIN [GLS\bi_admingroup] From Windows


IF NOT EXISTS (SELECT [name] FROM [sys].[database_principals] WHERE [name] = N'GLS\bi_admingroup')  CREATE USER [GLS\bi_admingroup] FOR LOGIN [GLS\bi_admingroup];IF DATABASE_PRINCIPAL_ID('bi_admin') IS NULL CREATE ROLE bi_admin; GRANT EXECUTE TO bi_admin;ALTER ROLE [bi_admin] ADD MEMBER [GLS\bi_admingroup]; ALTER ROLE [db_datareader] ADD MEMBER [GLS\bi_admingroup]; ALTER ROLE [db_datawriter] ADD MEMBER [GLS\bi_admingroup]