interpreting
doScript: aString in: contextOSAID mode: anInteger
	"Answer text result of executing Applescript aString in context contexOSAID in mode: anInteger"

	^self do: aString in: contextOSAID mode: anInteger