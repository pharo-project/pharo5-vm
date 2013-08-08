private - SQFile access
fileHandleFrom: sqFileStructByteArray
	"Answer a file handle from a SQFile structure. On most platforms, this
	will be a (FILE *). On Win32, it is a HANDLE."

	| sqFile |
	<returnTypeC: 'FILEHANDLETYPE'>
	<var: 'sqFile' declareC: 'SQFile *sqFile'>
	sqFile := interpreterProxy arrayValueOf: sqFileStructByteArray.
	^ self cCode: 'sqFile->file' inSmalltalk: [0]
