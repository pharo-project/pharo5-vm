generate machine code
fillInMethodHeader: method size: size selector: selector
	<returnTypeC: #'CogMethod *'>
	<var: #method type: #'CogMethod *'>
	<var: #originalMethod type: #'CogMethod *'>
	| methodHeader originalMethod |
	method cmType: CMMethod.
	method objectHeader: objectMemory nullHeaderForMachineCodeMethod.
	method blockSize: size.
	method methodObject: methodObj.
	methodHeader := coInterpreter rawHeaderOf: methodObj.
	"If the method has already been cogged (e.g. Newspeak accessors) then
	 leave the original method attached to its cog method, but get the right header."
	(coInterpreter isCogMethodReference: methodHeader)
		ifTrue:
			[originalMethod := self cCoerceSimple: methodHeader to: #'CogMethod *'.
			self assert: originalMethod blockSize = size.
			methodHeader := originalMethod methodHeader.
			self cppIf: NewspeakVM ifTrue: [methodZone addToUnpairedMethodList: method]]
		ifFalse:
			[coInterpreter rawHeaderOf: methodObj put: method asInteger].
	method methodHeader: methodHeader.
	method selector: selector.
	method cmNumArgs: (coInterpreter argumentCountOfMethodHeader: methodHeader).
	(method cmRefersToYoung: hasYoungReferent) ifTrue:
		[methodZone addToYoungReferrers: method].
	method cmUsageCount: self initialMethodUsageCount.
	method cpicHasMNUCase: false.
	method cmUsesPenultimateLit: maxLitIndex >= ((coInterpreter literalCountOfHeader: methodHeader) - 2).
	method cmUsesMethodClass: usesMethodClass.
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
	^method