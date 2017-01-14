method introspection
mapPCDataFor: cogMethod into: arrayObj
	"Collect the branch and send data for cogMethod, storing it into arrayObj."
	<api>
	<var: #cogMethod type: #'CogMethod *'>
	| errCode |
	introspectionDataIndex := 0.
	introspectionData := arrayObj.
	cogMethod stackCheckOffset = 0 ifTrue:
		[self assert: introspectionDataIndex = 0.
		 cogMethod cmIsFullBlock
			ifTrue:
				[objectMemory
					storePointerUnchecked: 0 ofObject: introspectionData withValue: objectMemory nilObject;
					storePointerUnchecked: 1 ofObject: introspectionData withValue: (objectMemory integerObjectOf: cbNoSwitchEntryOffset);
					storePointerUnchecked: 2 ofObject: introspectionData withValue: objectMemory nilObject;
					storePointerUnchecked: 3 ofObject: introspectionData withValue: (objectMemory integerObjectOf: cbEntryOffset)]
			ifFalse:
				[objectMemory
					storePointerUnchecked: 0 ofObject: introspectionData withValue: objectMemory nilObject;
					storePointerUnchecked: 1 ofObject: introspectionData withValue: (objectMemory integerObjectOf: cmEntryOffset);
					storePointerUnchecked: 2 ofObject: introspectionData withValue: objectMemory nilObject;
					storePointerUnchecked: 3 ofObject: introspectionData withValue: (objectMemory integerObjectOf: cmNoCheckEntryOffset)].
		 ^4].
	errCode := self
					mapFor: (self cCoerceSimple: cogMethod to: #'CogBlockMethod *')
					bcpc: (coInterpreter startPCOfMethod: cogMethod methodObject)
					performUntil: #pcDataFor:Annotation:Mcpc:Bcpc:Method:
					arg: cogMethod asVoidPointer.
	errCode ~= 0 ifTrue:
		[self assert: errCode = PrimErrNoMemory.
		 ^-1].
	cogMethod blockEntryOffset ~= 0 ifTrue:
		[errCode := self blockDispatchTargetsFor: cogMethod
						perform: #pcDataForBlockEntry:Method:
						arg: cogMethod asInteger.
		 errCode ~= 0 ifTrue:
			[self assert: errCode = PrimErrNoMemory.
			 ^-1]].
	^introspectionDataIndex