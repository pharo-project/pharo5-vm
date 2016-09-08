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
	hasYoungObjPtr := (self addressOf: hasYoungObj put: [:val| hasYoungObj := val]) asInteger.
	codeModified := freedPIC := false.
	self mapObjectReferencesInGeneratedRuntime.
	cogMethod := self cCoerceSimple: methodZoneBase to: #'CogMethod *'.
	[cogMethod < methodZone limitZony] whileTrue:
		[self assert: hasYoungObj not.
		 cogMethod cmType ~= CMFree ifTrue:
			[self assert: (self cogMethodDoesntLookKosher: cogMethod) = 0.
			 cogMethod selector: (objectRepresentation remapOop: cogMethod selector).
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
							 "For non-Newspeak there should ne a one-to-one mapping between bytecoded and
							  cog methods.  For Newspeak not necessarily, but only for anonymous accessors."
							 "Only reset the method object's header if it is referring to this CogMethod."
							 (coInterpreter rawHeaderOf: cogMethod methodObject) = cogMethod asInteger
								ifTrue:
									[coInterpreter
										rawHeaderOf: cogMethod methodObject
										put: cogMethod methodHeader.
									 cogMethod
										methodHeader: (coInterpreter rawHeaderOf: remappedMethod);
										methodObject: remappedMethod.
									 coInterpreter
										rawHeaderOf: remappedMethod
										put: cogMethod asInteger]
								ifFalse:
									[self assert: (self noAssertMethodClassAssociationOf: cogMethod methodObject)
													= objectMemory nilObject.
									 cogMethod
										methodHeader: (coInterpreter rawHeaderOf: remappedMethod);
										methodObject: remappedMethod]].
						 (objectMemory isYoung: cogMethod methodObject) ifTrue:
							[hasYoungObj := true]].
					 self mapFor: cogMethod
						 performUntil: #remapIfObjectRef:pc:hasYoung:
						 arg: hasYoungObjPtr.
					 hasYoungObj
						ifTrue:
							[methodZone ensureInYoungReferrers: cogMethod.
							hasYoungObj := false]
						ifFalse:
							[cogMethod cmRefersToYoung: false]]].
		cogMethod := methodZone methodAfter: cogMethod].
	"we /must/ prune youngReferrers here because a) the [cogMethod cmRefersToYoung: false]
	 block could have removed a method and subsequently it could be added back, and b) we
	 can not tolerate duplicates in the youngReferrers list."  
	methodZone pruneYoungReferrers.
	freedPIC ifTrue:
		[self unlinkSendsToFree].
	codeModified ifTrue: "After updating oops in inline caches we need to flush the icache."
		[processor flushICacheFrom: codeBase asUnsignedInteger to: methodZone limitZony asUnsignedInteger]