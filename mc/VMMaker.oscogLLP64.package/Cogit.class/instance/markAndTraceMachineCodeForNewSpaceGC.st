jit - api
markAndTraceMachineCodeForNewSpaceGC
	"Free any methods that refer to unmarked objects, unlinking sends to freed methods."
	| pointer cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	objectMemory leakCheckNewSpaceGC ifTrue:
		[self asserta: self allMachineCodeObjectReferencesValid].
	codeModified := false.
	pointer := methodZone youngReferrers.
	[pointer < methodZone zoneEnd] whileTrue:
		[cogMethod := coInterpreter cCoerceSimple: (objectMemory longAt: pointer) to: #'CogMethod *'.
		 cogMethod cmRefersToYoung ifTrue:
			[self assert: (self cogMethodDoesntLookKosher: cogMethod) = 0.
			 self assert: (cogMethod cmType = CMMethod
						or: [cogMethod cmType = CMOpenPIC]).
			 (objectMemory isYoung: cogMethod selector) ifTrue:
				[objectMemory markAndTrace: cogMethod selector].
			 cogMethod cmType = CMMethod ifTrue:
				[(objectMemory isYoung: cogMethod methodObject) ifTrue:
					[objectMemory markAndTrace: cogMethod methodObject].
				self markYoungObjectsIn: cogMethod]].
		 pointer := pointer + objectMemory wordSize].
	objectMemory leakCheckNewSpaceGC ifTrue:
		[self asserta: self allMachineCodeObjectReferencesValid].
	codeModified ifTrue: "After updating oops in inline caches we need to flush the icache."
		[processor flushICacheFrom: methodZoneBase asUnsignedInteger to: methodZone limitZony asUnsignedInteger]