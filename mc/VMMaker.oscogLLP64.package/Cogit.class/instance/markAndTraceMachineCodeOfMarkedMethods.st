jit - api
markAndTraceMachineCodeOfMarkedMethods
	"Mark objects in machine-code of marked methods (or open PICs with marked selectors)."
	<api>
	<option: #SpurObjectMemory>
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	objectMemory leakCheckFullGC ifTrue:
		[self asserta: self allMachineCodeObjectReferencesValid].
	codeModified := false.
	self markAndTraceObjectReferencesInGeneratedRuntime.
	cogMethod := self cCoerceSimple: methodZoneBase to: #'CogMethod *'.
	[cogMethod < methodZone limitZony] whileTrue:
		[(cogMethod cmType = CMMethod
		  and: [objectMemory isMarked: cogMethod methodObject]) ifTrue:
			[self markAndTraceLiteralsIn: cogMethod].
		 (cogMethod cmType = CMOpenPIC
		  and: [(objectMemory isImmediate: cogMethod selector)
				or: [objectMemory isMarked: cogMethod selector]]) ifTrue:
			[self markAndTraceLiteralsIn: cogMethod].
		 cogMethod := methodZone methodAfter: cogMethod].
	objectMemory leakCheckFullGC ifTrue:
		[self asserta: self allMachineCodeObjectReferencesValid].
	codeModified ifTrue: "After updating oops in inline caches we need to flush the icache."
		[processor flushICacheFrom: methodZoneBase asUnsignedInteger to: methodZone limitZony asUnsignedInteger]