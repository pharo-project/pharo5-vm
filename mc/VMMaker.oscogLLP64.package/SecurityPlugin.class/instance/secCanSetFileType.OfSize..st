exported functions
secCanSetFileType: fileName OfSize: fileNameSize
	<export: true>
	<var: #fileName type: 'char *'>
	^self cCode: 'ioCanSetFileTypeOfSize(fileName, fileNameSize)'