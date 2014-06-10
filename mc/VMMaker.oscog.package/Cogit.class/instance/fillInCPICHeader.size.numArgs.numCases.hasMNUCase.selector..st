generate machine code
fillInCPICHeader: pic size: size numArgs: numArgs numCases: numCases hasMNUCase: hasMNUCase selector: selector
	<returnTypeC: #'CogMethod *'>
	<var: #pic type: #'CogMethod *'>
	self assert: (objectMemory isYoung: selector) not.
	pic cmType: CMClosedPIC.
	pic objectHeader: 0.
	pic blockSize: size.
	pic methodObject: 0.
	pic methodHeader: 0.
	pic selector: selector.
	pic cmNumArgs: numArgs.
	pic cmRefersToYoung: false.
	pic cmUsageCount: self initialClosedPICUsageCount.
	pic cpicHasMNUCase: hasMNUCase.
	pic cPICNumCases: numCases.
	pic blockEntryOffset: 0.
	self assert: pic cmType = CMClosedPIC.
	self assert: pic selector = selector.
	self assert: pic cmNumArgs = numArgs.
	self assert: pic cPICNumCases = numCases.
	self assert: (backEnd callTargetFromReturnAddress: pic asInteger + missOffset) = (self picAbortTrampolineFor: numArgs).
	self assert: size = (methodZone roundUpLength: size).
	^pic