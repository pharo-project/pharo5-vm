printing
printOn: aStream
	| shortPrint |
	shortPrint := [coInterpreter shortPrint: oop]
				on: Error
				do: [:ex| ^super printOn: aStream].
	super printOn: aStream.
	shortPrint first = $= ifTrue:
		[shortPrint := shortPrint allButFirst].
	aStream nextPutAll: ' for '; nextPutAll: shortPrint