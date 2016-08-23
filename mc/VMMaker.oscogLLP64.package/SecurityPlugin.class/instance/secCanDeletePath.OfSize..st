exported functions
secCanDeletePath: dirName OfSize: dirNameSize
	<export: true>
	<var: #dirName type: 'char *'>
	^self cCode: 'ioCanDeletePathOfSize(dirName, dirNameSize)'