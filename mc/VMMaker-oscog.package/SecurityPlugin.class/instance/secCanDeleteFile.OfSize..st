exported functions
secCanDeleteFile: fileName OfSize: fileNameSize
	<export: true>
	<var: #fileName type: 'char *'>
	^self cCode: 'ioCanDeleteFileOfSize(fileName, fileNameSize)'