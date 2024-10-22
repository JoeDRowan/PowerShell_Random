Function New-RandomPassword {
<#
.Synopsis
    This will generate a new password in Powershell using Special, Uppercase, Lowercase and Numbers.  The max number of characters are currently set to 79.
    For updated help and examples refer to -Online version.
  
 
.DESCRIPTION
    This will generate a new password in Powershell using Special, Uppercase, Lowercase and Numbers.  The max number of characters are currently set to 79.
    For updated help and examples refer to -Online version.
 
 
.NOTES  
    Name: New-RandomPassword
    Author: the Sysadmin Channel
    Version: 1.0
    DateCreated: 2019-Feb-23
    DateUpdated: 2019-Feb-23
 
 
.LINK
    https://thesysadminchannel.com/generate-strong-random-passwords-using-powershell/ -
 
 
.EXAMPLE
    For updated help and examples refer to -Online version.
 
#>
 
    [CmdletBinding()]
    param(
        [ValidateRange(4,79)]
        [int]    $Length = 16,
        [switch] $ExcludeSpecialCharacters
    )
 
 
    BEGIN {
        $SpecialCharacters = @((33,35) + (36..38) + (42..44) + (60..64) + (91..94))
    }
 
    PROCESS {
        try {
            if (-not $ExcludeSpecialCharacters) {
                    $Password = -join ((48..57) + (65..90) + (97..122) + $SpecialCharacters | Get-Random -Count $Length | foreach {[char]$_})
                } else {
                    $Password = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count $Length | foreach {[char]$_})  
            }
 
        } catch {
            throw $_.Exception.Message
        }
 
    }
 
    END {
        Write-Output "$Password"
    }
 
}