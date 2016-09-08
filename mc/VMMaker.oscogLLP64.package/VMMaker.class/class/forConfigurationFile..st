initialisation
forConfigurationFile: aFileName
	| config fileStream vmMaker |

	fileStream := FileStream oldFileNamed: aFileName.
	config := ('#(' includes: fileStream peek) "for storeOn: format"
				ifTrue: [Object readFrom: fileStream]
				ifFalse: [fileStream fileInObjectAndCode].
	vmMaker := self forPlatform: (config at: 5).
	vmMaker loadConfiguration: config.
	^vmMaker