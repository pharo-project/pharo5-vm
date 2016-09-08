jit - api
mapObjectReferencesInMachineCode: gcMode
	<api>
	"Update all references to objects in machine code."
	gcMode caseOf: {
		[GCModeNewSpace]	-> [self mapObjectReferencesInMachineCodeForYoungGC].
		[GCModeFull]			-> [self mapObjectReferencesInMachineCodeForFullGC].
		[GCModeBecome]		-> [self mapObjectReferencesInMachineCodeForBecome] }.

	(self asserta: methodZone freeStart <= methodZone youngReferrers) ifFalse:
		[self error: 'youngReferrers list overflowed']