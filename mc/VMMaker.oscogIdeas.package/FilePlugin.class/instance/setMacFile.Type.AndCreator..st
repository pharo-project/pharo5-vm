file primitives
setMacFile: fileName Type: typeString AndCreator: creatorString
	"Exported entry point for the VM. Needed for image saving only and no-op on anything but Macs."
	<export: true>
	<var: #fileName type: 'char *'>
	<var: #typeString type: 'char *'>
	<var: #creatorString type: 'char *'>
	^self cCode: 'dir_SetMacFileTypeAndCreator(fileName, strlen(fileName), typeString, creatorString)'.