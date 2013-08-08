method introspection support
picDataFor: cogMethod
	<var: #cogMethod type: #'CogMethod *'>
	| cm nSlots nEntries data |
	cm := cogMethod methodObject.
	nSlots := (objectMemory byteSizeOf: cm) - (self startPCOfMethod: cm) + objectMemory minSlotsForShortening.
	data := objectMemory instantiateClass: (objectMemory splObj: ClassArray) indexableSize: nSlots.
	nEntries := cogit picDataFor: cogMethod into: data.
	nEntries = 0 ifTrue:
		[^nil].
	nEntries < nSlots ifTrue:
		[objectMemory shorten: data toIndexableSize: nEntries].
	^data