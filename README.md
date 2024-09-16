NOTE:  I am not a programmer.  What you see here is a list of some of the things I have had a need for in some of my latest jobs.  
                            Use at your own risk.

This is also my first foray into storing my stuff on Github, so don't expect much at this time.
Who knows, maybe someday....

For now I am just throwing stuff here but will sort it out as I learn more about Github, which is why it looks like it does.  Hang in there, it'll look better...eventually.

There are three files here that are related. They are SqlServerServicesControllerl.ps1, StartSQLServerController.ps1, and StartSqlServiceController.cmd.

*** SqlServerServicesControllerl.ps1 ***

Main script that searches all services for SQL Server and SQL Server Agent instances and will start and stop those services.
The Powershell script creates a form that will list services in a list box format with Start Services, Stop Services, and an Exit button at the bottom.
The button functions are self explanatory but affect both SQL Server and SQL Server Agent instances.
The list is multi-selectable by holding the "ctrl" key while clicking the services.
A notification will present itself for the status after the action for each item selected.

*** StartSQLServerController.ps1 ***
This is the Powershell script that hides the Powershell window behind the form.
It then calls the *** SqlServerServicesControllerl.ps1 *** to get things started.

*** StartSqlServiceController.cmd ***
This can be labled as a .bat file as well.  All this does is call the *** StartSQLServerController.ps1 *** script.
I use it as the launcher to copy to the desktop so the other two files can be located in the same folder.

 SQL Server Services Controller © 2024 by Jim Calano is licensed under CC BY-NC-SA 4.0 

