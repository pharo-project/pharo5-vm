printf
f: aStream printf: arguments
	"inst var string holds all text contained in the formatstring. %f blabla %d"
	| position savedStream |
	"inst var format is a stream of FormatDescriptors"
	self reset.
	savedStream := outputStream.
	outputStream := aStream.
	position := aStream position.
	[self process: arguments]
		ensure: [outputStream := savedStream].
	aStream flush.
	^aStream position - position