exported functions
secCanOpenAsyncFile: fileName OfSize: fileNameSize Writable: writeFlag
	<export: true>
	<var: #fileName type: 'char *'>
	^self cCode: 'ioCanOpenAsyncFileOfSizeWritable(fileName, fileNameSize, writeFlag)'