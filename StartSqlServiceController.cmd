@echo off
rem #****************************************
rem #*** Start the app as Administrator   ***
rem #****************************************
PowerShell -Command "Start-Process PowerShell -ArgumentList 'C:\Users\Public\Documents\SqlServerServicesController.ps1' -Verb RunAs"
rem******************************************
rem #* SQL Server Services Controller © 2024 by Jim Calano is licensed under CC BY-NC-SA 4.0 
