
Declare @command as varchar(500), @WindowsAccount as varchar(100);

Set @WindowsAccount='GLS\ss'  -- Configure the Windows Account
-- Create SQL Server logins for a give windows account

Select @command =  'IF SUSER_ID (N''' + @WindowsAccount +  ''') IS NULL CREATE LOGIN [' + @WindowsAccount + '] From Windows';
Print @command

--Exec @command
 
Select @command = 'use msdb;IF SUSER_ID (N'''+@WindowsAccount+''') IS NULL CREATE USER [' +@WindowsAccount+'] FOR LOGIN [' + @WindowsAccount + '];IF DATABASE_PRINCIPAL_ID(''app_support_l2'') IS NULL CREATE ROLE app_support_l2; GRANT EXECUTE TO app_support_l2;'
Select @command = @command +  'ALTER ROLE [app_support_l2] ADD MEMBER [' +  @WindowsAccount + ']';
Select @command = @command +  '; ALTER ROLE [db_datareader] ADD MEMBER [' +  @WindowsAccount + ']';
Select @command = @command +  '; ALTER ROLE [db_datawriter] ADD MEMBER [' +  @WindowsAccount + ']';
Select @command = @command +  '; ALTER ROLE [SQLAgentOperatorRole] ADD MEMBER [' +  @WindowsAccount + ']';
Select @command = @command +  '; ALTER ROLE [db_ssisoperator] ADD MEMBER [' +  @WindowsAccount + ']';

print @command

--- UnComment when you want to run the script
--exec (@command)



--Alterately you can add the member to fixed server role using the sp_addreolemember. But the store proc is going be depreciate
--Use msdb
--Go;

--IF DATABASE_PRINCIPAL_ID('role') IS NULL Create Role app_support_l2;
--EXEC sp_addrolemember 'db_datareader', @WindowsAccount;
--EXEC sp_addrolemember 'db_datawriter', @WindowsAccount;
--EXEC sp_addrolemember 'SQLAgentOperatorRole', @WindowsAccount;
--EXEC sp_addrolemember 'db_ssisoperator', @WindowsAccount;

--Create login Test33 with password='TempPW@1234',
--CHECK_POLICY = OFF;
--Go
