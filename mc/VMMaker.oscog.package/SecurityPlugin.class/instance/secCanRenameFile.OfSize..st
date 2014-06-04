exported functions
secCanRenameFile: fileName OfSize: fileNameSize
	<export: true>
	<var: #fileName type: 'char *'>
	^self cCode: 'ioCanRenameFileOfSize(fileName, fileNameSize)'