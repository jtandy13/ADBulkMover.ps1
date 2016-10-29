<#
# Active Directory function library v.1
#>

<#
.Synopsis
   Adds multiple AD user accounts to an AD group
.DESCRIPTION
   Adds multiple AD user accounts to an AD group by using an Organizational Unit as the source of the users to move.
.EXAMPLE
   BulkAdd-ADMembership -GroupName "Test Group" -SourceOU "OU=Users,OU=Test,DC=contoso,DC=com" -DomainController "dc01@contoso.com"
#>
function BulkAdd-ADMembership
{
    Param
    (
        # Target group name supplied by user
        [Parameter(Mandatory=$true)]
        [string]
        $GroupName,

        # Source OU of the users
        [Parameter (Mandatory=$true)]
        [string]
        $SourceOU,

        # Domain controller selected by the user
        [Parameter (Mandatory=$true)]
        [string]
        $DomainController
    )

    Process
    {
        try{
            #Convert the $GroupName string into the corresponding AD group object
            $TargetGroup = Get-ADGroup -Server $DomainController -Filter {name -eq $GroupName}

            #Create an array to hold all of the user objects in the source OU
            $Users = @();
            #Populate the array
            $Users = Get-ADUser -Filter * -SearchBase $SourceOU -Server $DomainController

            # For loop to add users to the AD group
            Foreach($User in $Users){
                try{
                    Add-ADGroupMember $TargetGroup -Members $User -Server $DomainController
                }
                catch{
                    Write-Warning "$_"
                    continue;
                }
            }
        }
        catch{
            Write-Warning "$_"
        }
    }
}

<#
.Synopsis
   Removes multiple AD user accounts from an AD group
.DESCRIPTION
   Removes multiple AD user accounts from an AD group by using an Organizational Unit as the source of the users to remove.
.EXAMPLE
   BulkRemove-ADMembership -GroupName "Test Group" -SourceOU "OU=Users,OU=Test,DC=contoso,DC=com" -DomainController "dc01@contoso.com"
#>
function BulkRemove-ADMembership
{
    Param
    (
        # Target group name supplied by user
        [Parameter(Mandatory=$true)]
        [string]
        $GroupName,

        # Source OU of the users
        [Parameter (Mandatory=$true)]
        [string]
        $SourceOU,

        # Domain controller selected by the user
        [Parameter (Mandatory=$true)]
        [string]
        $DomainController
    )

    Process
    {
        try{
            #Convert the $GroupName string into the corresponding AD group object
            $TargetGroup = Get-ADGroup -Server $DomainController -Filter {name -eq $GroupName}

            #Create an array to hold all of the user objects in the source OU
            $Users = @();
            #Populate the array
            $Users = Get-ADUser -Filter * -SearchBase $SourceOU -Server $DomainController

            # For loop to add users to the AD group
            Foreach($User in $Users){
                try{
                    Remove-ADGroupMember $TargetGroup -Members $User -Server $DomainController -Confirm:$false
                }
                catch{
                    Write-Warning "$_"
                    continue;
                }
            }
        }
        catch{
            Write-Warning "$_"
        }
    }
}


<#
.Synopsis
   Displays the members of an AD group
.EXAMPLE
   Display-GroupMembers -GroupName "Test Group" -DomainController "dc01@contoso"
#>
function Display-GroupMembers
{
    Param
    (
        # Target group name supplied by user
        [Parameter(Mandatory=$true)]
        [string]
        $GroupName,

        # Domain controller selected by the user
        [Parameter (Mandatory=$true)]
        [string]
        $DomainController
    )
    Process
    {
        try{
            Get-ADGroupMember -Identity $GroupName -Server $DomainController | Select -ExpandProperty name | Sort-Object
        }
        catch{
            Write-Warning "$_"
        }
        
    }
}


<#
.Synopsis
   Function to return the distinguished name of the user's OU
.EXAMPLE
   Get-UserOU jtan dc01@contoso
#>
function Get-UserOU ($userName, $DomainController)
{
	try{
		$user = Get-ADUser -Identity $userName -Server $DomainController
		($user.DistinguishedName -split “,”, 2)[1]
	}
	catch{
		Write-Warning "$_"
	}
    
}