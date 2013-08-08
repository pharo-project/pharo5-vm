sample scripts
lsFolder
	"list directory
		|bs| bs := Applescript lsFolder.
		bs inspect
	"
	^self doIt: '
	set f to (choose folder with prompt "Hi guys!") as Unicode text
	set p to POSIX path of f
	set til to ASCII character 39
	do shell script "ls " & til & p & til
	'
