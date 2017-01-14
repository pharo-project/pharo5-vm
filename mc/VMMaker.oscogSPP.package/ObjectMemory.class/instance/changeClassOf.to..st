interpreter access
changeClassOf: rcvr to: argClass
	"Attempt to change the class of the receiver to the argument given that the
	 format of the receiver matches the format of the argument.  If successful,
	 answer 0, otherwise answer an error code indicating the reason for failure. 
	 Fail if the receiver is an instance of a compact class and the argument isn't,
	 or if the format of the receiver is incompatible with the format of the argument,
	 or if the argument is a fixed class and the receiver's size differs from the size
	 that an instance of the argument should have."
	| classHdr sizeHiBits argClassInstByteSize argFormat rcvrFormat rcvrHdr ccIndex |
	"Check what the format of the class says"
	classHdr := self formatOfClass: argClass. "Low 2 bits are 0"

	"Compute the size of instances of the class (used for fixed field classes only)"
	sizeHiBits := (classHdr bitAnd: 16r60000) >> 9.
	classHdr := classHdr bitAnd: 16r1FFFF.
	argClassInstByteSize := (classHdr bitAnd: SizeMask) + sizeHiBits. "size in bytes -- low 2 bits are 0"

	"Check the receiver's format against that of the class"
	argFormat := self formatOfHeader: classHdr.
	rcvrHdr := self baseHeader: rcvr.
	rcvrFormat := self formatOfHeader: rcvrHdr.
	"If the receiver is a byte object we need to clear the number of odd bytes from the format."
	rcvrFormat > self firstByteFormat ifTrue:
		[rcvrFormat := rcvrFormat bitAnd: 16rC].
	argFormat = rcvrFormat ifFalse:
		[^PrimErrInappropriate]. "no way"

	"For fixed field classes, the sizes must match.
	Note: argClassInstByteSize-4 because base header is included in class size."
	argFormat < self arrayFormat
		ifTrue:
			[(argClassInstByteSize - self baseHeaderSize) ~= (self numBytesOf: rcvr) ifTrue:
				[^PrimErrBadReceiver]]
		ifFalse:
			[argFormat = self indexablePointersFormat ifTrue: "For indexable plus fixed fields the receiver must be at least big enough."
				[(argClassInstByteSize - self baseHeaderSize) > (self numBytesOf: rcvr) ifTrue:
					[^PrimErrBadReceiver]]].

	(self headerTypeOfHeader: rcvrHdr) = HeaderTypeShort
		ifTrue: "Compact classes. Check if the arg's class is compact and exchange ccIndex"
			[ccIndex := classHdr bitAnd: CompactClassMask.
			ccIndex = 0 ifTrue:
				[^PrimErrInappropriate]. "class is not compact"
			self cppIf: IMMUTABILITY
				ifTrue: [(rcvrHdr bitAnd: ImmutabilityBit) ~= 0 ifTrue:
							[^PrimErrNoModification]].
			self baseHeader: rcvr put: ((rcvrHdr bitClear: CompactClassMask) bitOr: ccIndex)]
		ifFalse: "Exchange the class pointer, which could make rcvr a root for argClass"
			[self cppIf: IMMUTABILITY
				ifTrue: [(rcvrHdr bitAnd: ImmutabilityBit) ~= 0 ifTrue:
							[^PrimErrNoModification]].
			"N.B. the recursive scan-mark algorithm uses the header word's size and compact class
			 fields to determine the header type when it reuses the header type bits for the mark
			 state.  So it is alas an invariant that non-compact headers have a 0 compact class field."
			(self compactClassIndexOfHeader: rcvrHdr) ~= 0 ifTrue:
				[self baseHeader: rcvr put: (rcvrHdr bitClear: CompactClassMask)].			
			self longAt: rcvr - self baseHeaderSize put: (argClass bitOr: (self headerTypeOfHeader: rcvrHdr)).
			(self oop: rcvr isLessThan: youngStart) ifTrue:
				[self possibleRootStoreInto: rcvr value: argClass]].
	"ok"
	^0