method introspection support
picDataFor: cogMethod
	<var: #cogMethod type: #'CogMethod *'>
	| cm nSlots nEntries data |
	cm := cogMethod methodObject.
	nSlots := (objectMemory byteSizeOf: cm) - (self startPCOfMethod: cm) + objectMemory minSlotsForShortening.
	data := objectMemory instantiateClass: (objectMemory splObj: ClassArray) indexableSize: nSlots.
	data ifNil: [^-1].
	nEntries := cogit picDataFor: cogMethod into: data.
	nEntries = 0 ifTrue:
		[^0].
	nEntries < nSlots ifTrue:
		[objectMemory shorten: data toIndexableSize: nEntries].
	^data