debug printing
printHeaderOf: objOop
	<api>
	"N.B. No safety bounds checks!!  We need to look e.g. at corpses."
	coInterpreter printHexnp: objOop.
	(self numSlotsOfAny: objOop) >= self numSlotsMask
		ifTrue: [coInterpreter
					print: ' hdr16 slotf '; printHexnp: (self numSlotsOfAny: objOop - self allocationUnit);
					print: ' slotc '; printHexnp: (self rawOverflowSlotsOf: objOop); space]
		ifFalse: [coInterpreter print: ' hdr8 slots '; printHexnp: (self numSlotsOfAny: objOop)].
	coInterpreter
		space;
		printChar: ((self isMarked: objOop) ifTrue: [$M] ifFalse: [$m]);
		printChar: ((self isGrey: objOop) ifTrue: [$G] ifFalse: [$g]);
		printChar: ((self isPinned: objOop) ifTrue: [$P] ifFalse: [$p]);
		printChar: ((self isRemembered: objOop) ifTrue: [$R] ifFalse: [$r]);
		printChar: ((self isImmutable: objOop) ifTrue: [$I] ifFalse: [$i]);
		print: ' hash '; printHexnp: (self rawHashBitsOf: objOop);
		print: ' fmt '; printHexnp: (self formatOf: objOop);
		print: ' cidx '; printHexnp: (self classIndexOf: objOop);
		cr