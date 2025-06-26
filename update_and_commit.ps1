# PowerShell script to commit and push with incrementing update number

$counterFile = ".update_counter"
if (!(Test-Path $counterFile)) {
    Set-Content $counterFile 1
}
$updateNumber = Get-Content $counterFile

# Stage all changes
git add .

# Commit with incrementing message
git commit -m "update $updateNumber"

# Increment and save the counter
$newNumber = [int]$updateNumber + 1
Set-Content $counterFile $newNumber

# Push to the current branch
git push
