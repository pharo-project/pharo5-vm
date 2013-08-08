converting
saveAsFileNamed: newFileName compressionType: compressionTypeString
	"Store this sound in a new file with the given name using the given compression type. Useful for converting between compression formats."

	| outFile |
	outFile := (FileStream newFileNamed: newFileName) binary.
	self storeSunAudioOn: outFile compressionType: compressionTypeString.
	outFile close.
