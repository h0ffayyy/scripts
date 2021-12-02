# get hash values for all files in a directory

$TargetDir = "C:\users\aaron\Desktop\"
$OutputDir = "C:\users\aaron\Desktop\"

# initialize csv file
Out-File -FilePath $OutputDir\hashes.csv

# add -Recurse to recursively search directories
get-ChildItem $TargetDir |
Get-FileHash -Algorithm Sha256 |
Export-Csv -Path $OutputDir\hashes.csv -NoTypeInformation |
Import-Csv -Path $OutputDir\hashes.csv
