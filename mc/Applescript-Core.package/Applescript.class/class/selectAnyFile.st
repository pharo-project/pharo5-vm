sample scripts
selectAnyFile
	"Harness Apple's select file dialog for Squeak
		|bs| bs := Applescript selectAnyFile.
		bs inspect
	"
	^self doIt: '
	set f to (choose file with prompt "Hi guys!") as Unicode text
	POSIX path of file f
	'
