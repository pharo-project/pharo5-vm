garbage collection
mapObjectReferencesInMachineCodeForIncrementalGC
	"Update all references to objects in machine code for an incremental gc.
	 Avoid scanning all code by using the youngReferrers list.  In an incremental
	 GC a method referring to young may no longer refer to young, but a method
	 not referring to young cannot and will not refer to young afterwards."
	| pointer cogMethod hasYoungObj hasYoungObjPtr |
	<var: #cogMethod type: #'CogMethod *'>
	hasYoungObj := false.
	hasYoungObjPtr := self cCode: [(self addressOf: hasYoungObj) asInteger]
							inSmalltalk: [CPluggableAccessor new
											setObject: nil;
											atBlock: [:obj :idx| hasYoungObj]
											atPutBlock: [:obj :idx :val| hasYoungObj := val]].
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
						 performUntil: (self cppIf: NewspeakVM
											ifTrue: [#remapNSIfObjectRef:pc:hasYoung:]
											ifFalse: [#remapIfObjectRef:pc:hasYoung:])
						 arg: hasYoungObjPtr.
					 hasYoungObj
						ifTrue: [hasYoungObj := false]
						ifFalse: [cogMethod cmRefersToYoung: false]]].
		 pointer := pointer + BytesPerWord].
	methodZone pruneYoungReferrers.
	codeModified ifTrue: "After updating oops in inline caches we need to flush the icache."
		[processor flushICacheFrom: methodZoneBase to: methodZone limitZony asInteger]