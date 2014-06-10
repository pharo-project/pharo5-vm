exported functions
secCanListPath: pathName OfSize: pathNameSize
	<export: true>
	<var: #pathName type: 'char *'>
	^self cCode: 'ioCanListPathOfSize(pathName, pathNameSize)'