converting
ioFilename: aCharBuffer fromString: aFilenameString ofLength: filenameLength resolveAliases: aBoolean
	<var: #aCharBuffer type: #'char *'>
	<var: #aFilenameString type: #'char *'>
	"the vm has to convert aFilenameString via any canonicalization and char-mapping and put the result in aCharBuffer. This doesn't translate well in Smalltalk since we know how long strings are rather than considering them terminated by a 0 char. Do the best we can.
Note the resolveAliases flag - this is an awful artefact of OSX and Apples demented alias handling. When opening a file, the flag must be  true, when closing or renaming it must be false. Sigh."
	aCharBuffer replaceFrom:1 to: filenameLength with: aFilenameString