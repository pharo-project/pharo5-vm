generate machine code
fillInMethodHeader: method size: size selector: selector
	<returnTypeC: #'CogMethod *'>
	<var: #method type: #'CogMethod *'>
	| originalMethod rawHeader |
	<var: #originalMethod type: #'CogMethod *'>
	method cmType: CMMethod.
	method objectHeader: objectMemory nullHeaderForMachineCodeMethod.
	method blockSize: size.
	method methodObject: methodObj.
	rawHeader := coInterpreter rawHeaderOf: methodObj.
	"If the method has already been cogged (e.g. Newspeak accessors) then
	 leave the original method attached to its cog method, but get the right header."
	(coInterpreter isCogMethodReference: rawHeader)
		ifTrue:
			[originalMethod := self cCoerceSimple: rawHeader to: #'CogMethod *'.
			self assert: originalMethod blockSize = size.
			self assert: methodHeader = originalMethod methodHeader.
			NewspeakVM ifTrue:
				[methodZone addToUnpairedMethodList: method]]
		ifFalse:
			[coInterpreter rawHeaderOf: methodObj put: method asInteger.
			 NewspeakVM ifTrue:
				[method nextMethodOrIRCs: theIRCs]].
	method methodHeader: methodHeader.
	method selector: selector.
	method cmNumArgs: (coInterpreter argumentCountOfMethodHeader: methodHeader).
	(method cmRefersToYoung: hasYoungReferent) ifTrue:
		[methodZone addToYoungReferrers: method].
	method cmUsageCount: self initialMethodUsageCount.
	method cpicHasMNUCase: false.
	method cmUsesPenultimateLit: maxLitIndex >= ((objectMemory literalCountOfMethodHeader: methodHeader) - 2).
	method blockEntryOffset: (blockEntryLabel notNil
								ifTrue: [blockEntryLabel address - method asInteger]
								ifFalse: [0]).
	"This can be an error check since a large stackCheckOffset is caused by compiling
	 a machine-code primitive, and hence depends on the Cogit, not the input method."
	needsFrame ifTrue:
		[stackCheckLabel address - method asInteger <= MaxStackCheckOffset ifFalse:
			[self error: 'too much code for stack check offset']].
	method stackCheckOffset: (needsFrame
								ifTrue: [stackCheckLabel address - method asInteger]
								ifFalse: [0]).
	self assert: (backEnd callTargetFromReturnAddress: method asInteger + missOffset)
				= (self methodAbortTrampolineFor: method cmNumArgs).
	self assert: size = (methodZone roundUpLength: size).
	processor flushICacheFrom: method asUnsignedInteger to: method asUnsignedInteger + size.
	self maybeEnableSingleStep.
	^method