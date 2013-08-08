sample scripts
selectFile
	"Harness Apple's select file dialog for Squeak
		Applescript selectFile
	"
	^self doIt: '(choose file with prompt "Hi guys!" of type "TEXT") as string'
