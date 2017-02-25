debug printing
printOopsFrom: startAddress to: endAddress
	<api>
	| oop limit firstNonEntity inEmptySpace lastNonEntity |
	oop := self objectBefore: startAddress.
	limit := endAddress asUnsignedIntegerPtr min: endOfMemory.
	oop := oop
				ifNil: [startAddress]
				ifNotNil: [(self objectAfter: oop) = startAddress
							ifTrue: [startAddress]
							ifFalse: [oop]].
	inEmptySpace := false.
	[self oop: oop isLessThan: limit] whileTrue:
		[self printEntity: oop.
		 [oop := self objectAfter: oop.
		  (self long64At: oop) = 0] whileTrue:
			[inEmptySpace ifFalse:
				[inEmptySpace := true.
				 firstNonEntity := oop].
			 lastNonEntity := oop].
		 inEmptySpace ifTrue:
			[inEmptySpace := false.
			 coInterpreter
				print: 'skipped empty space from '; printHexPtrnp: firstNonEntity;
				print:' to '; printHexPtrnp: lastNonEntity; cr.
			 oop := self objectStartingAt: oop]]