compaction
updatePointersIn: obj savedFirstFieldPointer: firstFieldPtr
	"Sweep the pointer fields in obj, updating all references to mobile objects to their eventual locations.
	 firstFieldPtr is supplied for mobile objects so that the saved first field can be updated, and so that
	 the first field of a compiled method (which is its header, or reference to a CogMethod holding its header)
	 can be retrieved."
	<inline: false>
	| fmt numPointerSlots oop fwd |
	fmt := manager formatOf: obj.
	numPointerSlots := self numPointerSlotsWhileCompactingOf: obj withFormat: fmt savedFirstFieldPointer: firstFieldPtr.
	(fmt <= manager lastPointerFormat "excludes CompiledMethod"
	 and: [numPointerSlots > 0]) ifTrue:
		["Relocate the saved first field; Note that CompiledMethods can be excluded since their
		  first field is either a SmallInteger or a reference to a CogMethod outside of oldSpace."
		 oop := manager longAt: firstFieldPtr.
		 ((manager isNonImmediate: oop) and: [self isMobile: oop]) ifTrue:
			[self assert: (manager isMarked: oop).
			 fwd := manager fetchPointer: 0 ofObject: oop.
			 self assert: (self isPostMobile: fwd).
			 manager longAt: firstFieldPtr put: fwd]].
	1 to: numPointerSlots - 1 do:
		[:i|
		 oop := manager fetchPointer: i ofObject: obj.
		 ((manager isNonImmediate: oop) and: [self isMobile: oop]) ifTrue:
			[self assert: ((manager isMarked: oop) or: [obj = manager hiddenRootsObject]).
			 fwd := manager fetchPointer: 0 ofObject: oop.
			 self assert: (self isPostMobile: fwd).
			 manager storePointerUnchecked: i ofObject: obj withValue: fwd]]