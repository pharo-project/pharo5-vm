profiling primitives
cogCodeConstituents
	"Answer the contents of the code zone as an array of pair-wise element, address in ascending address order.
	 Answer a string for a runtime routine or abstract label (beginning, end, etc), a CompiledMethod for a CMMethod,
	 or a selector (presumably a Symbol) for a PIC."
	<api>
	| count cogMethod constituents label value |
	<var: #cogMethod type: #'CogMethod *'>
	count := trampolineTableIndex / 2 + 3. "+ 3 for start, freeStart and end"
	cogMethod := self cCoerceSimple: methodZoneBase to: #'CogMethod *'.
	[cogMethod < methodZone limitZony] whileTrue:
		[cogMethod cmType ~= CMFree ifTrue:
			[count := count + 1].
		cogMethod := methodZone methodAfter: cogMethod].
	constituents := coInterpreter instantiateClass: coInterpreter classArray indexableSize: count * 2.
	constituents isNil ifTrue:
		[^constituents].
	coInterpreter pushRemappableOop: constituents.
	((label := coInterpreter stringForCString: 'CogCode') isNil
	 or: [(value := coInterpreter cePositive32BitIntegerFor: codeBase) isNil]) ifTrue:
		[^nil].
	coInterpreter
		storePointerUnchecked: 0 ofObject: coInterpreter topRemappableOop withValue: label;
		storePointerUnchecked: 1 ofObject: coInterpreter topRemappableOop withValue: value.
	0 to: trampolineTableIndex - 1 by: 2 do:
		[:i|
		((label := coInterpreter stringForCString: (trampolineAddresses at: i)) isNil
		 or: [(value := coInterpreter cePositive32BitIntegerFor: (trampolineAddresses at: i + 1) asUnsignedInteger) isNil]) ifTrue:
			[coInterpreter popRemappableOop.
			 ^nil].
		coInterpreter
			storePointerUnchecked: 2 + i ofObject: coInterpreter topRemappableOop withValue: label;
			storePointerUnchecked: 3 + i ofObject: coInterpreter topRemappableOop withValue: value].
	count := trampolineTableIndex + 2.
	cogMethod := self cCoerceSimple: methodZoneBase to: #'CogMethod *'.
	[cogMethod < methodZone limitZony] whileTrue:
		[cogMethod cmType ~= CMFree ifTrue:
			[coInterpreter
				storePointerUnchecked: count
				ofObject: coInterpreter topRemappableOop
				withValue: (cogMethod cmType = CMMethod
								ifTrue: [cogMethod methodObject]
								ifFalse: [cogMethod selector]).
			 (value := coInterpreter cePositive32BitIntegerFor: cogMethod asUnsignedInteger) isNil ifTrue:
				[coInterpreter popRemappableOop.
				 ^nil].
			 coInterpreter
				storePointerUnchecked: count + 1
				ofObject: coInterpreter topRemappableOop
				withValue: value.
			 count := count + 2].
		cogMethod := methodZone methodAfter: cogMethod].
	((label := coInterpreter stringForCString: 'CCFree') isNil
	 or: [(value := coInterpreter cePositive32BitIntegerFor: methodZone freeStart) isNil]) ifTrue:
		[coInterpreter popRemappableOop.
		 ^nil].
	coInterpreter
		storePointerUnchecked: count ofObject: coInterpreter topRemappableOop withValue: label;
		storePointerUnchecked: count + 1 ofObject: coInterpreter topRemappableOop withValue: value.
	((label := coInterpreter stringForCString: 'CCEnd') isNil
	 or: [(value := coInterpreter cePositive32BitIntegerFor: methodZone zoneEnd) isNil]) ifTrue:
		[coInterpreter popRemappableOop.
		 ^nil].
	coInterpreter
		storePointerUnchecked: count + 2 ofObject: coInterpreter topRemappableOop withValue: label;
		storePointerUnchecked: count + 3 ofObject: coInterpreter topRemappableOop withValue: value.
	constituents := coInterpreter popRemappableOop.
	coInterpreter beRootIfOld: constituents.
	^constituents