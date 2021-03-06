Clear-Host

#Global variables
$mainFile		= "monochrome"
$executableName = "Monochrome"
$fileExt		= ".asm"

$debug			= $TRUE

$datedFolder	= $TRUE
$copyFiles		= $TRUE
$runProgram		= $TRUE

$linux			= $FALSE



if ($datedFolder -eq $TRUE) {
	#Getting the current date
	$date = [string](Get-Date).year + "_" + [string](Get-Date).month + "_" + [string](Get-Date).day

	#Setting executable location
	if ($debug -eq $TRUE) {
		$executableLocation = "target\debug\" + $date
	} else {
		$executableLocation = "target\release\" + $date
	}

	#Check if there is a build for the current date
	if ((Test-Path $executableLocation) -eq $FALSE) {
		$temp = ".\" + $executableLocation
		"...Creating a new directory..."
		New-Item $temp -ItemType "directory" | Out-Null
	}
} else {
	if ($debug -eq $TRUE) {
		$executableLocation = "target\debug\"
	} else {
		$executableLocation = "target\release\"
	}
}


#Moving data folders
if ($copyFiles -eq $TRUE) {
	"...Moving data..."
	Copy-Item -Path ".\data" -Destination ".\$executableLocation" -Force -Recurse
}

#Backing up src
if ($copyFiles -eq $TRUE) {
	Copy-Item -Path ".\src" -Destination ".\$executableLocation" -Force -Recurse
}


#Setting up stopwatch
$stopwatch =  [system.diagnostics.stopwatch]::StartNew()

if ($fileExt -eq ".asm") {
	#Setting up variables for compilation
	$src = "src\" + $mainFile + $fileExt
	$exe = "" + $executableLocation + "\" + $executableName
	$lib = "-Wall -lraylib -lm -lgcc -lpthread -lgdi32 -lwinmm -mwindows".Split(" ")

	#Compiling
	"...Compiling Program..."
	& "fasm" $src $exe".o"
	if ($LASTEXITCODE -ne 0) { break }
	& "gcc" $exe".o" $lib "-o"$exe".exe"
}

#Stopping the stopwatch
$stopwatch.Stop()


#Test for errors in compilation
if ($LASTEXITCODE -eq 0 -and $runProgram -eq $TRUE) {
	#run program
	"...Compilation Successful in " + [math]::Round($stopwatch.Elapsed.TotalMilliSeconds,0) + " milliseconds..."
	"...Running Program..."
	""
	& (".\" + $executableLocation + "\" + $executableName + $executableExt)
	""
}