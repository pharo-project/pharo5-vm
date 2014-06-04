object access
fetchWordLengthOf: objOop
	"NOTE: this gives size appropriate for fetchPointer: n, but not in general for, eg, fetchLong32, etc.
	 Unlike lengthOf: this does not adjust the length of a context
	 by the stackPointer and so can be used e.g. by cloneContext:"
	^self numSlotsOf: objOop