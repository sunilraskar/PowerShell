Use TestTempDB1


IF SUSER_ID (N'GLS\WindowsUser3') IS NULL CREATE LOGIN [GLS\WindowsUser3] From Windows

use [TestTempDB1];IF SUSER_ID (N'GLS\WindowsUser3') IS NULL CREATE USER [GLS\WindowsUser3] FOR LOGIN [GLS\WindowsUser3];ALTER ROLE [db_junioradmin] ADD MEMBER [GLS\WindowsUser3]



