testing
stringForCString: aCString
	"Answer a ByteString object containing the bytes (possibly UTF-8?) in the null-terminated C string aCString."
	<var: #aCString type: #'char *'>
	self notYetImplemented