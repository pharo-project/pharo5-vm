inline primitive generators
genMoveAndAdjustSSEntry: ssEntry into: reg
	<var: #ssEntry type: #'SimStackEntry *'>
	<inline: true>
	| adjust |
	adjust := (objectMemory baseHeaderSize >> objectMemory shiftForWord) - 1. "shift by baseHeaderSize and then move from 1 relative to zero relative"
	ssEntry type = SSConstant 
		ifTrue: [self MoveCq: (objectMemory integerValueOf: ssEntry constant) + adjust R: reg.
			      ssEntry spilled ifTrue: [self AddCq: objectMemory wordSize R: SPReg]]
		ifFalse: 
			[ssEntry popToReg: reg.
			 objectRepresentation genConvertSmallIntegerToIntegerInReg: reg.
			 adjust ~= 0 ifTrue: [ self AddCq: adjust R: reg. ]].	