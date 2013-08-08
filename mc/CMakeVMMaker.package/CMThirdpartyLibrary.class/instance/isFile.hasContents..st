generating cmake file
isFile: aFileName hasContents: aString

	| newContents old |
	
	newContents := false.
	
	old := FileStream oldFileOrNoneNamed: aFileName.
	
	old ifNil: [ ^ false ].
	
	^ [ old contents = aString ] ensure: [ old close ]