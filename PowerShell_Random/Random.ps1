
#region Functions
function CalculateRandom ($Num, $Start, $End)
{
# Feed in $Start and $End but don't use them yet
$Collection=@()
$CollectiontoStore={$Collection}.Invoke()
for ($Counter = 1; $Counter -le $Num; $Counter++) {
$StartingPoint = Get-Date
$Milli=$StartingPoint.get_Millisecond()
$Ticks=$StartingPoint.get_Ticks()
$Divided=[math]::Round($Ticks/$Milli)
$RandomNumber1 = RandomOperator ($Divided)
# Use module % operator to ensure no number greater than $End
$RandomNumber=$RandomNumber1 % $End
$CollectiontoStore.Add($RandomNumber)
Start-Sleep -Milliseconds 2
}
Output $CollectiontoStore $Num $End
}

function RandomOperator($Current)
{
$SeedNumber = Get-Random -Minimum 1 -Maximum 10000
$Operator = Get-Random -Minimum 1 -Maximum 5
# 1 is +, 2 is *, 3 is minus, 4 is divide /
switch ($Operator) 
    { 
		1 {$Result=$Current + $SeedNumber} 
        2 {$Result=$Current * $SeedNumber} 
        3 {$Result=$Current - $SeedNumber}
		4 {$Result=[math]::Round($Current/$SeedNumber)}
		default {$Result=[math]::Round($Current/$SeedNumber)}
    }
return $Result
}

function Log
{
}

function Output ($RandomNumbers, $HowManyNumbers, $HighestNumber)
{
Write-Host "Here are your $HowManyNumbers random numbers smaller than $HighestNumber :" $RandomNumbers
}
#endregion

$Number=Read-Host "Enter number of random numbers to output"
# $StartRange=Read-Host "Enter starting point of range of numbers"
# $EndRange=Read-Host "Enter ending point of range of numbers"
# Get-Random -Minimum $StartRange -Maximum $EndRange
$StartRange="1"
$EndRange="100"

# Generate Random password using .Net
$PWBasic = [System.Web.Security.Membership]::GeneratePassword(10,0)
$PWNonAlphaNumerics = [System.Web.Security.Membership]::GeneratePassword(10,2)
$PWNonAlphaNumerics18 = [System.Web.Security.Membership]::GeneratePassword(18,2)
# Replace protected characters
$PWNonAlphaNumerics18Replace = [System.Web.Security.Membership]::GeneratePassword(18,2) -replace '$|%|&|#'

Write-Host "Random 10 character PW via System.Web.Security.Membership with only alphanumeric characters is `"$PWBasic`"" 
Write-Host "Random 10 character PW via System.Web.Security.Membership including non-alphanumeric characters is `"$PWNonAlphaNumerics`"" 
# Note: Get-Random is not cryptographically secure as it will use the system time as the starting seed probably because it is using the .NET random class


CalculateRandom $Number $StartRange $EndRange
# Ensure Password adheres to complexity limitations
[Reflection.Assembly]::LoadWithPartialName("System.Web") | out-null

do {
    $Password = [System.Web.Security.Membership]::GeneratePassword(18,2)
    $Complexity = 0
    if ( $Password -cmatch "\d") {$Complexity++}
    if ( $Password -cmatch "\W") {$Complexity++}
    if ( $Password -cmatch "[A-Z]") {$Complexity++}
    if ( $Password -cmatch "[a-z]") {$Complexity++}
} while ( $Complexity -lt 3 )

Write-host "Password is: [$password]"

# Roll 1200 dice
1..1200 | ForEach-Object {
    1..6 | Get-Random
} | Group-Object | Select-Object Name,Count
