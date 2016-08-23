debug printing
printHeaderTypeOf: objOop
	coInterpreter
		print: ((self numSlotsOfAny: objOop) >= self numSlotsMask
					ifTrue: [' hdr16 ']
					ifFalse: [' hdr8 ']);
		printChar: ((self isImmutable: objOop) ifTrue: [$i] ifFalse: [$.]);
		printChar: ((self isRemembered: objOop) ifTrue: [$r] ifFalse: [$.]);
		printChar: ((self isPinned: objOop) ifTrue: [$p] ifFalse: [$.]);
		printChar: ((self isMarked: objOop) ifTrue: [$m] ifFalse: [$.]);
		printChar: ((self isGrey: objOop) ifTrue: [$g] ifFalse: [$.])