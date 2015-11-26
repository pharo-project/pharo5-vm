accessing
actualClass 
	^self environment at: classSymbol ifPresent: [ :actualClass |
		classIsMeta
			ifTrue: [ actualClass classSide ]
			ifFalse: [ actualClass ] ]

