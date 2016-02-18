become
prepareForwardingTableForBecoming: array1 with: array2 twoWay: twoWayFlag 
	"Ensure that there are enough forwarding blocks to 
	accomodate this become, then prepare forwarding blocks for 
	the pointer swap. Return true if successful."
	"Details: Doing a GC might generate enough space for 
	forwarding blocks if we're short. However, this is an 
	uncommon enough case that it is better handled by primitive 
	fail code at the Smalltalk level."

	"Important note on multiple references to same object  - since the preparation of
	fwdBlocks is NOT idempotent we get VM crashes if the same object is referenced more
	than once in such a way as to require multiple fwdBlocks.
	oop1 forwardBecome: oop1 is ok since only a single fwdBlock is needed.
	oop1 become: oop1 would fail because the second fwdBlock woudl not have the actual object
	header but rather the mutated ref to the first fwdBlock.
	Further problems can arise with an array1 or array2 that refer multiply to the same 
	object. This would notbe expected input for programmer writen code but might arise from
	automatic usage such as in ImageSegment loading.
	To avoid the simple and rather common case of oop1 become*: oop1, we skip such pairs
	and simply avoid making fwdBlocks - it is redundant anyway"
	| entriesNeeded entriesAvailable fieldOffset oop1 oop2 fwdBlock fwdBlkSize |
	entriesNeeded := (self lastPointerOf: array1) // self wordSize. "need enough entries for all oops"
	"Note: Forward blocks must be quadword aligned - see fwdTableInit:."
	twoWayFlag
		ifTrue: ["Double the number of blocks for two-way become"
			entriesNeeded := entriesNeeded * 2.
			fwdBlkSize := self wordSize * 2]
		ifFalse: ["One-way become needs backPointers in fwd blocks."
			fwdBlkSize := self wordSize * 4].
	entriesAvailable := self fwdTableInit: fwdBlkSize.
	entriesAvailable < entriesNeeded ifTrue:
		[self initializeMemoryFirstFree: freeStart.
		 "re-initialize the free block"
		 ^false].
	fieldOffset := self lastPointerOf: array1.
	[fieldOffset >= self baseHeaderSize] whileTrue:
		[oop1 := self longAt: array1 + fieldOffset.
		 oop2 := self longAt: array2 + fieldOffset.
		 "if oop1 == oop2, no need to do any work for this pair.
		  May still be other entries in the arrays though so keep looking"
		 oop1 ~= oop2 ifTrue:
			[(self hasForwardingBlock: oop1) ifFalse: "Don't allocate multiple forwarding entries for duplicates."
				[fwdBlock := self fwdBlockGet: fwdBlkSize.
				 self
					initForwardBlock: fwdBlock
					mapping: oop1
					to: oop2
					withBackPtr: twoWayFlag not].
			 (twoWayFlag
			  and: [(self hasForwardingBlock: oop2) not]) ifTrue: "Again don't get confused by duplicates"
				["Second block maps oop2 back to oop1 for two-way become"
						fwdBlock := self fwdBlockGet: fwdBlkSize.
						self
							initForwardBlock: fwdBlock
							mapping: oop2
							to: oop1
							withBackPtr: twoWayFlag not]].
		fieldOffset := fieldOffset - self wordSize].
	^true