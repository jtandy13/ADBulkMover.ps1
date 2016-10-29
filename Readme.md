# ADBulkMover.ps1

ADBulkMover.ps1 is a utility designed to facilitate moving Active Directory user accounts into and out of groups quickly. I wrote this utility to help with a software rollout where I was spending large amounts of time moving users one at a time between groups in AD Users and Computers. The ADBulkMover menu is listed below:

Menu
--------------------------------
1. Add multiple users to an existing group
2. Remove mulitple users from group
3. Display members of a group
4. Display the OU of a user account
5. Export group membership list to a file
6. Change domain controller
7. Exit ADBulkMover.ps1

Selections 1 and 2 are the core functions of the utiltiy. Selections 3, 4, 5, and 6 just make using the utility easier. You can check your work with option 3. You can grab the OU or your users to add or remove by using option 4. You'll be asked for the OU when using selection 1 or 2.

Option 5 is great for when you have large quantities of users in AD groups and you want to do some analysis on group membership. You'll be asked to supply the group name and the target path for the file export. You can export as either csv or txt then do your analysis in Excel.

Configuration
---------------------------------------------
To run the utility, you'll need to have all files in the same directory. Start the utility by running the CallADBulkMover.bat with an account that has permissions to read and write to Active Directory. 
