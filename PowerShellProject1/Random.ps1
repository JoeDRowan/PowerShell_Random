
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

$Number=Read-Host "Enter number of random numbers to output"
# $StartRange=Read-Host "Enter starting point of range of numbers"
# $EndRange=Read-Host "Enter ending point of range of numbers"
# Get-Random -Minimum $StartRange -Maximum $EndRange
$StartRange="1"
$EndRange="100"

CalculateRandom $Number $StartRange $EndRange

Read-Host