simulation
createDirectory: aString
	^[FileDirectory default primCreateDirectory: aString.
	   true]
		on: Error
		do: [:ex| false]
	