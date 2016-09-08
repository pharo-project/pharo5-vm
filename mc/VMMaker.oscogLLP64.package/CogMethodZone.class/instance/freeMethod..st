compaction
freeMethod: cogMethod
	<api>
	<var: #cogMethod type: #'CogMethod *'>
	<inline: false>
	self assert: cogMethod cmType ~= CMFree.
	self assert: ((cogit cogMethodDoesntLookKosher: cogMethod) = 0
				 or: [(cogit cogMethodDoesntLookKosher: cogMethod) = 23
					 and: [(cogit cCoerceSimple: cogMethod methodObject to: #'CogMethod *') cmType = CMFree]]).
	cogMethod cmType = CMMethod ifTrue:
		["For non-Newspeak there should ne a one-to-one mapping between bytecoded and
		  cog methods.  For Newspeak not necessarily, but only for anonymous accessors."
		"Only reset the original method's header if it is referring to this CogMethod."
		 (coInterpreter rawHeaderOf: cogMethod methodObject) asInteger = cogMethod asInteger
			ifTrue:
				[coInterpreter rawHeaderOf: cogMethod methodObject put: cogMethod methodHeader.
				 NewspeakVM ifTrue:
					[(objectRepresentation canPinObjects and: [cogMethod nextMethodOrIRCs ~= 0]) ifTrue:
						[objectRepresentation freeIRCs: cogMethod nextMethodOrIRCs]]]
			ifFalse:
				[self cCode: [self assert: (cogit noAssertMethodClassAssociationOf: cogMethod methodObject) = objectMemory nilObject]
					inSmalltalk: [self assert: ((cogit noAssertMethodClassAssociationOf: cogMethod methodObject) = objectMemory nilObject
											or: [coInterpreter isKindOf: CurrentImageCoInterpreterFacade])].
				 NewspeakVM ifTrue:
					[self removeFromUnpairedMethodList: cogMethod]].
		 cogit maybeFreeCountersOf: cogMethod].
	cogMethod cmType = CMOpenPIC ifTrue:
		[self removeFromOpenPICList: cogMethod].
	cogMethod cmRefersToYoung: false.
	cogMethod cmType: CMFree.
	methodBytesFreedSinceLastCompaction := methodBytesFreedSinceLastCompaction
												+ cogMethod blockSize