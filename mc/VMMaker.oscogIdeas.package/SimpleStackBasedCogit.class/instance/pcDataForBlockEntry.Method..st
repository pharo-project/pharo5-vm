method introspection
pcDataForBlockEntry: blockEntryMcpc Method: cogMethod
	"Collect the branch and send data for the block method starting at blockEntryMcpc, storing it into picData."
	<returnTypeC: #usqInt>
	objectMemory
		storePointerUnchecked: introspectionDataIndex + 0 ofObject: introspectionData withValue: objectMemory nilObject;
		storePointerUnchecked: introspectionDataIndex + 1 ofObject: introspectionData withValue: (objectMemory integerObjectOf: blockEntryMcpc - blockNoContextSwitchOffset);
		storePointerUnchecked: introspectionDataIndex + 2 ofObject: introspectionData withValue: objectMemory nilObject;
		storePointerUnchecked: introspectionDataIndex + 3 ofObject: introspectionData withValue: (objectMemory integerObjectOf: blockEntryMcpc).
	introspectionDataIndex := introspectionDataIndex + 4.
	^0