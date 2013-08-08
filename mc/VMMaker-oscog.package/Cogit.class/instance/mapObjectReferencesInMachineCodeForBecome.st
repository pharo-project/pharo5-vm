garbage collection
mapObjectReferencesInMachineCodeForBecome
	"Update all references to objects in machine code for a become.
	 Unlike incrementalGC or fullGC a method that does not refer to young may
	 refer to young as a result of the become operation.  Unlike incrementalGC
	 or fullGC the reference from a Cog method to its methodObject *must not*
	 change since the two are two halves of the same object."
	| cogMethod hasYoungObj hasYoungObjPtr freedPIC |
	<var: #cogMethod type: #'CogMethod *'>
	hasYoungObj := false.
	hasYoungObjPtr := self cCode: [(self addressOf: hasYoungObj) asInteger]
							inSmalltalk: [CPluggableAccessor new
											setObject: nil;
											atBlock: [:obj :idx| hasYoungObj]
											atPutBlock: [:obj :idx :val| hasYoungObj := val]].
	codeModified := freedPIC := false.
	self mapObjectReferencesInGeneratedRuntime.
	cogMethod := self cCoerceSimple: methodZoneBase to: #'CogMethod *'.
	[cogMethod < methodZone limitZony] whileTrue:
		[self assert: hasYoungObj not.
		 cogMethod cmType ~= CMFree ifTrue:
			[self assert: (self cogMethodDoesntLookKosher: cogMethod) = 0.
			 cogMethod selector: (objectRepresentation remapOop: cogMethod selector)..
			 cogMethod cmType = CMClosedPIC
				ifTrue:
					[((objectMemory isYoung: cogMethod selector)
					   or: [self mapObjectReferencesInClosedPIC: cogMethod]) ifTrue:
						[freedPIC := true.
						 methodZone freeMethod: cogMethod]]
				ifFalse:
					[(objectMemory isYoung: cogMethod selector) ifTrue:
						[hasYoungObj := true].
					 cogMethod cmType = CMMethod ifTrue:
						[| remappedMethod |
						 self assert: cogMethod objectHeader = objectMemory nullHeaderForMachineCodeMethod.
						 self assert: ((coInterpreter rawHeaderOf: cogMethod methodObject) = cogMethod asInteger
									or: [(self noAssertMethodClassAssociationOf: cogMethod methodObject)
											= objectMemory nilObject]).
						 remappedMethod := objectRepresentation remapOop: cogMethod methodObject.
						 remappedMethod ~= cogMethod methodObject ifTrue:
							[(coInterpreter methodHasCogMethod: remappedMethod) ifTrue:
								[self error: 'attempt to become two cogged methods'].
							 (objectMemory
									withoutForwardingOn: cogMethod methodObject
									and: remappedMethod
									with: cogMethod cmUsesPenultimateLit
									sendToCogit: #method:hasSameCodeAs:checkPenultimate:) ifFalse:
								[self error: 'attempt to become cogged method into different method'].
							 coInterpreter
								rawHeaderOf: cogMethod methodObject
								put: cogMethod methodHeader.
							 cogMethod
								methodHeader: (coInterpreter rawHeaderOf: remappedMethod);
								methodObject: remappedMethod.
							 coInterpreter
								rawHeaderOf: remappedMethod
								put: cogMethod asInteger].
						 (objectMemory isYoung: cogMethod methodObject) ifTrue:
							[hasYoungObj := true]].
					 self mapFor: cogMethod
						 performUntil: (self cppIf: NewspeakVM
											ifTrue: [#remapNSIfObjectRef:pc:hasYoung:]
											ifFalse: [#remapIfObjectRef:pc:hasYoung:])
						 arg: hasYoungObjPtr.
					 hasYoungObj
						ifTrue:
							[cogMethod cmRefersToYoung ifFalse:
								[cogMethod cmRefersToYoung: true.
								 methodZone addToYoungReferrers: cogMethod].
							hasYoungObj := false]
						ifFalse: [cogMethod cmRefersToYoung: false]]].
		cogMethod := methodZone methodAfter: cogMethod].
	methodZone pruneYoungReferrers.
	freedPIC ifTrue:
		[self unlinkSendsToFree.
		 codeModified := true].
	codeModified ifTrue: "After updating oops in inline caches we need to flush the icache."
		[processor flushICacheFrom: codeBase to: methodZone limitZony asInteger]