private - file handles
unixFileNumber: fileHandle
	"Answer the integer Unix file number corresponding to a file handle (FILE* )."

	<returnTypeC: 'int'>
	<var: 'fileHandle' type: 'FILEHANDLETYPE'>
	^ self fileno: fileHandle
