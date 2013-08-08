exported functions
secCanGetFileType: fileName OfSize: fileNameSize
	<export: true>
	<var: #fileName type: 'char *'>
	^self cCode: 'ioCanGetFileTypeOfSize(fileName, fileNameSize)'