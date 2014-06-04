compaction
freeMethod: cogMethod
	<var: #cogMethod type: #'CogMethod *'>
	<inline: false>
	self assert: cogMethod cmType ~= CMFree.
	self assert: (cogit cogMethodDoesntLookKosher: cogMethod) = 0.
	cogMethod cmType = CMMethod ifTrue:
		["For non-Newspeak there should ne a one-to-one mapping between bytecoded and
		  cog methods.  For Newspeak not necessarily, but only for anonymous accessors."
		"Only reset the original method's header if it is referring to this CogMethod."
		 (coInterpreter rawHeaderOf: cogMethod methodObject) asInteger = cogMethod asInteger
			ifTrue:
				[coInterpreter rawHeaderOf: cogMethod methodObject put: cogMethod methodHeader]
			ifFalse:
				[self assert: (cogit noAssertMethodClassAssociationOf: cogMethod methodObject) = objectMemory nilObject.
				 self cppIf: NewspeakVM ifTrue:
					[self removeFromUnpairedMethodList: cogMethod]].
		 cogMethod cmRefersToYoung: false].
	cogMethod cmType = CMOpenPIC ifTrue:
		[self removeFromOpenPICList: cogMethod.
		 cogMethod cmRefersToYoung: false].
	cogMethod cmType: CMFree.
	methodBytesFreedSinceLastCompaction := methodBytesFreedSinceLastCompaction
												+ cogMethod blockSize