exported functions
secCanCreatePath: dirName OfSize: dirNameSize
	<export: true>
	<var: #dirName type: 'char *'>
	^self cCode: 'ioCanCreatePathOfSize(dirName, dirNameSize)'