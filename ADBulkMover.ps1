Import-Module .\ActiveDirectoryFunctionLibrary.ps1

#Welcome the user to the utility
Write-Host "-------------------------------" -foregroundcolor Green
Write-Host "  Welcome to ADBulkMover.ps1!" -foregroundcolor Green
Write-Host "-------------------------------" -foregroundcolor Green
$DomainController = Read-Host "Please enter the name of the domain controller to use during this session"

#Test the connection to the selected server
if((Test-Connection $DomainController -Quiet) -eq "True"){
    Write-Host ("Connected to domain controller {0}" -f $DomainController) -foregroundcolor "green"
}
else{
    Write-Host ("Could not connect to domain controller {0}!" -f $DomainController) -foregroundcolor "red"
}

$Exit = "false"
while ($Exit -eq "false"){
    Write-Host
    "
    Menu
    --------------------------------
    1. Add multiple users to an existing group
    2. Remove mulitple users from group
    3. Display members of a group
    4. Display the OU of a user account
    5. Export group membership list to a file
    6. Change domain controller
    7. Exit ADBulkMover.ps1
    " 
    #Read the user's menu selection into $UserSelection
    $UserSelection = Read-Host

    if ($UserSelection -eq "1"){
        Write-Host "Adding multiple users to an existing group" -foregroundcolor Green
        Write-Host "------------------------------------------" -foregroundcolor Green

        # Get the source OU and the target group from the user
        $SourceOU = Read-Host "Enter the source OU of the users"
        $GroupName = Read-Host "Enter the target group name"

        # Add users to the group
        BulkAdd-ADMembership -GroupName $GroupName -SourceOU $SourceOU -DomainController $DomainController
    }
    if ($UserSelection -eq "2"){
        Write-Host "Removing multiple users to an existing group" -foregroundcolor Green
        Write-Host "------------------------------------------" -foregroundcolor Green

        # Get the source OU and the target group from the user
        $SourceOU = Read-Host "Enter the source OU of the users to remove"
        $GroupName = Read-Host "Enter the target group name from which to remove the users"

        # Add users to the group
        BulkRemove-ADMembership -GroupName $GroupName -SourceOU $SourceOU -DomainController $DomainController
    }
    if ($UserSelection -eq "3"){
        Write-Host "Display group membership" -foregroundcolor Green
        Write-Host "------------------------------------------" -foregroundcolor Green

        # Get the group name from the user
        $GroupName = Read-Host "Enter the target group name"

        # Display the group members in alphabetical order
        Display-GroupMembers -GroupName $GroupName -DomainController $DomainController
    }
	if ($UserSelection -eq "4"){
        Write-Host "Display the OU of a user account" -foregroundcolor Green
        Write-Host "------------------------------------------" -foregroundcolor Green

        $userName = Read-Host "Enter a username to get their OU"
		Get-UserOU $userName $DomainController
    }
    if ($UserSelection -eq "5"){
        Write-Host "Export group membership list to a file" -foregroundcolor Green
        Write-Host "------------------------------------------" -foregroundcolor Green

        # Get the group name from the user
        $GroupName = Read-Host "Enter the target group name"

        # Enter the path of the export file
        $FilePath = Read-Host "Enter the path of the export file"

        # Display the group members in alphabetical order
        Display-GroupMembers -GroupName $GroupName -DomainController $DomainController | Out-File $FilePath
    }
    if ($UserSelection -eq "6"){
        $DomainController = Read-Host "Please enter the name of the new domain controller for this session"
        #Test the connection to the selected server
        if((Test-Connection $DomainController -Quiet) -eq "True"){
            Write-Host ("Connected to domain controller {0}" -f $DomainController) -foregroundcolor "green"
        }
        else{
            Write-Host ("Could not connect to domain controller {0}!" -f $DomainController) -foregroundcolor "red"
        }
    }
    if ($UserSelection -eq "7"){$Exit = "True"}
}


