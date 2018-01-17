initialize-release
setFormat: aString
	| formatStream |
	"copy actual formatstrings to format"
	"copy any nonformating text to string"
	outputStream := (String new: 20) writeStream.
	formatStream := ((aString copyReplaceAll: '\n' with: (String with: Character cr))
		copyReplaceAll: '\t'
		with: (String with: Character tab)) readStream.
	self collectFormatDescriptorsAndStrings: formatStream