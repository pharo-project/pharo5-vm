garbage collection
mapObjectReferencesInMachineCodeForYoungGC
	"Update all references to objects in machine code for either a Spur scavenging gc
	 or a Squeak V3 incremental GC.  Avoid scanning all code by using the youngReferrers
	 list.  In a young gc a method referring to young may no longer refer to young, but a
	 method not referring to young cannot and will not refer to young afterwards."
	| pointer cogMethod hasYoungObj hasYoungObjPtr |
	<var: #cogMethod type: #'CogMethod *'>
	hasYoungObj := false.
	hasYoungObjPtr := (self addressOf: hasYoungObj put: [:val| hasYoungObj := val]) asInteger.
	codeModified := false.
	pointer := methodZone youngReferrers.
	[pointer < methodZone zoneEnd] whileTrue:
		[self assert: hasYoungObj not.
		 cogMethod := coInterpreter cCoerceSimple: (objectMemory longAt: pointer) to: #'CogMethod *'.
		 cogMethod cmType = CMFree
			ifTrue: [self assert: cogMethod cmRefersToYoung not]
			ifFalse:
				[self assert: (self cogMethodDoesntLookKosher: cogMethod) = 0.
				 cogMethod cmRefersToYoung ifTrue:
					[self assert: (cogMethod cmType = CMMethod
								or: [cogMethod cmType = CMOpenPIC]).
					 cogMethod selector: (objectRepresentation remapOop: cogMethod selector).
					 (objectMemory isYoung: cogMethod selector) ifTrue:
						[hasYoungObj := true].
					 cogMethod cmType = CMMethod ifTrue:
						[self assert: cogMethod objectHeader = objectMemory nullHeaderForMachineCodeMethod.
						 cogMethod methodObject: (objectRepresentation remapOop: cogMethod methodObject).
						 (objectMemory isYoung: cogMethod methodObject) ifTrue:
							[hasYoungObj := true]].
					 self mapFor: cogMethod
						 performUntil: #remapIfObjectRef:pc:hasYoung:
						 arg: hasYoungObjPtr.
					 hasYoungObj
						ifTrue: [hasYoungObj := false]
						ifFalse: [cogMethod cmRefersToYoung: false]]].
		 pointer := pointer + objectMemory wordSize].
	methodZone pruneYoungReferrers.
	codeModified ifTrue: "After updating oops in inline caches we need to flush the icache."
		[processor flushICacheFrom: methodZoneBase asUnsignedInteger to: methodZone limitZony asUnsignedInteger]