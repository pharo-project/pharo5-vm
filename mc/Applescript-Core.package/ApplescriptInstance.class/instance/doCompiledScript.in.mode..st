interpreting
doCompiledScript: aCompiledApplescriptData in: contextOSAID mode: anInteger
	"Answer text result of executing Applescript aString in context contexOSAID in mode: anInteger"

	^self valueOf: aCompiledApplescriptData in: contextOSAID mode: anInteger