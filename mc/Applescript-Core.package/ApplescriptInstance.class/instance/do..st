interpreting
do: aString
	"Answer text result of compiling script in null context"

	^self doScript: aString in: OSAID new mode: 0