generate machine code
fillInOPICHeader: pic numArgs: numArgs selector: selector
	<returnTypeC: #'CogMethod *'>
	<var: #pic type: #'CogMethod *'>
	<inline: true>
	pic cmType: CMOpenPIC.
	pic objectHeader: 0.
	pic blockSize: openPICSize.
	"pic methodObject: 0.""This is also the nextOpenPIC link so don't initialize it"
	methodZone addToOpenPICList: pic.
	pic methodHeader: 0.
	pic selector: selector.
	pic cmNumArgs: numArgs.
	(pic cmRefersToYoung: (objectMemory isYoung: selector)) ifTrue:
		[methodZone addToYoungReferrers: pic].
	pic cmUsageCount: self initialOpenPICUsageCount.
	pic cpicHasMNUCase: false.
	pic cPICNumCases: 0.
	pic blockEntryOffset: 0.
	self assert: pic cmType = CMOpenPIC.
	self assert: pic selector = selector.
	self assert: pic cmNumArgs = numArgs.
	self assert: (backEnd callTargetFromReturnAddress: pic asInteger + missOffset) = (self picAbortTrampolineFor: numArgs).
	self assert: openPICSize = (methodZone roundUpLength: openPICSize).
	processor flushICacheFrom: pic asUnsignedInteger to: pic asUnsignedInteger + openPICSize.
	self maybeEnableSingleStep.
	^pic