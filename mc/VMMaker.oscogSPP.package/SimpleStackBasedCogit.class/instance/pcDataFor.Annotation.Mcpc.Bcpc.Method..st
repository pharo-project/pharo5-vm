method introspection
pcDataFor: descriptor Annotation: isBackwardBranchAndAnnotation Mcpc: mcpc Bcpc: bcpc Method: cogMethodArg
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<var: #mcpc type: #'char *'>
	<var: #cogMethodArg type: #'void *'>

	descriptor ifNil: "this is the stackCheck offset"
		[self assert: introspectionDataIndex = 0.
		 (self cCoerceSimple: cogMethodArg to: #'CogMethod *') cmIsFullBlock
			ifTrue:
				[objectMemory
					storePointerUnchecked: introspectionDataIndex + 0 ofObject: introspectionData withValue: objectMemory nilObject;
					storePointerUnchecked: introspectionDataIndex + 1 ofObject: introspectionData withValue: (objectMemory integerObjectOf: cbNoSwitchEntryOffset);
					storePointerUnchecked: introspectionDataIndex + 2 ofObject: introspectionData withValue: objectMemory nilObject;
					storePointerUnchecked: introspectionDataIndex + 3 ofObject: introspectionData withValue: (objectMemory integerObjectOf: cbEntryOffset)]
			ifFalse:
				[objectMemory
					storePointerUnchecked: introspectionDataIndex + 0 ofObject: introspectionData withValue: objectMemory nilObject;
					storePointerUnchecked: introspectionDataIndex + 1 ofObject: introspectionData withValue: (objectMemory integerObjectOf: cmEntryOffset);
					storePointerUnchecked: introspectionDataIndex + 2 ofObject: introspectionData withValue: objectMemory nilObject;
					storePointerUnchecked: introspectionDataIndex + 3 ofObject: introspectionData withValue: (objectMemory integerObjectOf: cmNoCheckEntryOffset)].
		 objectMemory
			storePointerUnchecked: introspectionDataIndex + 4 ofObject: introspectionData withValue: (objectMemory integerObjectOf: bcpc + 1);
			storePointerUnchecked: introspectionDataIndex + 5 ofObject: introspectionData withValue: (objectMemory integerObjectOf: (self cCoerceSimple: cogMethodArg to: #'CogMethod *') stackCheckOffset).
		 introspectionDataIndex := introspectionDataIndex + 6.
		 ^0].

	(self isPCMappedAnnotation: isBackwardBranchAndAnnotation >> 1) ifTrue:
		[| actualBcpc actualMcpc |
		 actualBcpc := (isBackwardBranchAndAnnotation anyMask: 1)
							ifTrue: [bcpc + 1]
							ifFalse: [bcpc + descriptor numBytes + 1].
		 actualMcpc := mcpc asUnsignedInteger - cogMethodArg asUnsignedInteger.
		 objectMemory
			storePointerUnchecked: introspectionDataIndex + 0 ofObject: introspectionData withValue: (objectMemory integerObjectOf: actualBcpc);
			storePointerUnchecked: introspectionDataIndex + 1 ofObject: introspectionData withValue: (objectMemory integerObjectOf: actualMcpc).
		 introspectionDataIndex := introspectionDataIndex + 2].

	^0