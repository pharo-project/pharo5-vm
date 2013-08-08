private - SQFile access
isValidFileSession: objectPointer
	"Answer true if the file session matches the current interpreter session identifier."

	 ^ self getThisSessionIdentifier =
		(self sessionIdentifierFromSqFile: (interpreterProxy arrayValueOf: objectPointer))
