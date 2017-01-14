garbage collection
mapObjectReferencesInMachineCodeForFullGC
	"Update all references to objects in machine code for a full gc.  Since
	 the current (New)ObjectMemory GC makes everything old in a full GC
	 a method not referring to young will not refer to young afterwards"
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	codeModified := false.
	self mapObjectReferencesInGeneratedRuntime.
	cogMethod := self cCoerceSimple: methodZoneBase to: #'CogMethod *'.
	[cogMethod < methodZone limitZony] whileTrue:
		[cogMethod cmType ~= CMFree ifTrue:
			[self assert: (self cogMethodDoesntLookKosher: cogMethod) = 0.
			 cogMethod selector: (objectRepresentation remapOop: cogMethod selector).
			 cogMethod cmType = CMClosedPIC
				ifTrue:
					[self assert: cogMethod cmRefersToYoung not.
					 self mapObjectReferencesInClosedPIC: cogMethod]
				ifFalse:
					[cogMethod cmType = CMMethod ifTrue:
						[self assert: cogMethod objectHeader = objectMemory nullHeaderForMachineCodeMethod.
						 cogMethod methodObject: (objectRepresentation remapOop: cogMethod methodObject)].
					 self mapFor: cogMethod
						 performUntil: #remapIfObjectRef:pc:hasYoung:
						 arg: 0.
					 (cogMethod cmRefersToYoung
					  and: [objectRepresentation allYoungObjectsAgeInFullGC]) ifTrue:
						[cogMethod cmRefersToYoung: false]]].
		cogMethod := methodZone methodAfter: cogMethod].
	methodZone pruneYoungReferrers.
	codeModified ifTrue: "After updating oops in inline caches we need to flush the icache."
		[processor flushICacheFrom: codeBase asUnsignedInteger to: methodZone limitZony asUnsignedInteger]