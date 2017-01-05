in-line cacheing
cogPICSelector: selector numArgs: numArgs Case0Method: case0CogMethod Case1Method: case1MethodOrNil tag: case1Tag isMNUCase: isMNUCase
	"Attempt to create a two-case PIC for case0CogMethod and  case1Method,case1Tag.
	 The tag for case0CogMethod is at the send site and so doesn't need to be generated.
	 case1Method may be any of
		- a Cog method; link to its unchecked entry-point
		- a CompiledMethod; link to ceInterpretMethodFromPIC:
		- a CompiledMethod; link to ceMNUFromPICMNUMethod:receiver:"
	<var: #case0CogMethod type: #'CogMethod *'>
	<returnTypeC: #'CogMethod *'>
	| startAddress |
	(objectMemory isYoung: selector) ifTrue:
		[^self cCoerceSimple: YoungSelectorInPIC to: #'CogMethod *'].
	coInterpreter
		compilationBreak: selector
		point: (objectMemory numBytesOf: selector)
		isMNUCase: isMNUCase.
	
	"get memory in the code zone for the CPIC; if that fails we return an error code for the sender to use to work out how to blow up"
	startAddress := methodZone allocate: closedPICSize.
	startAddress = 0 ifTrue:
		[^self cCoerceSimple: InsufficientCodeSpace to: #'CogMethod *'].

	"memcpy the prototype across to our allocated space; because anything else would be silly"
	objectMemory
		mem: (self cCoerceSimple: startAddress to: #'CogMethod *')
		cp: (self cCoerceSimple: cPICPrototype to: #'CogMethod *')
		y: closedPICSize.
	
	self configureCPIC: (self cCoerceSimple: startAddress to: #'CogMethod *')
		Case0: case0CogMethod
		Case1Method: case1MethodOrNil
		tag: case1Tag
		isMNUCase: isMNUCase
		numArgs: numArgs
		delta: startAddress - cPICPrototype .

	^self
		fillInCPICHeader: (self cCoerceSimple: startAddress to: #'CogMethod *')
		numArgs: numArgs
		numCases: 2
		hasMNUCase: isMNUCase
		selector: selector 