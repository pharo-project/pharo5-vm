exported functions
secCanOpenFile: fileName OfSize: fileNameSize Writable: writeFlag
	<export: true>
	<var: #fileName type: 'char *'>
	^self cCode: 'ioCanOpenFileOfSizeWritable(fileName, fileNameSize, writeFlag)'