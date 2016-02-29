jit - api
markAndTraceOrFreeMachineCodeForFullGC
	"Free any methods that refer to unmarked objects, unlinking sends to freed methods."
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	objectMemory leakCheckFullGC ifTrue:
		[self asserta: self allMachineCodeObjectReferencesValid].
	codeModified := false.
	self markAndTraceObjectReferencesInGeneratedRuntime.
	cogMethod := self cCoerceSimple: methodZoneBase to: #'CogMethod *'.
	[cogMethod < methodZone limitZony] whileTrue:
		[self markAndTraceOrFreeCogMethod: cogMethod firstVisit: true.
		 cogMethod := methodZone methodAfter: cogMethod].
	objectMemory leakCheckFullGC ifTrue:
		[self asserta: self allMachineCodeObjectReferencesValid].
	codeModified ifTrue: "After updating oops in inline caches we need to flush the icache."
		[processor flushICacheFrom: methodZoneBase asUnsignedInteger to: methodZone limitZony asUnsignedInteger]