printf
printf: arguments
	"inst var string holds all text contained in the formatstring. %f blabla %d"

	"inst var format is a stream of FormatDescriptors"
	self reset.
	self process: arguments.
	^outputStream position