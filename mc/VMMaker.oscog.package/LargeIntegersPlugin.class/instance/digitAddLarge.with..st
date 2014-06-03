oop functions
digitAddLarge: firstInteger with: secondInteger 
	"Does not need to normalize!"
	| over firstLen secondLen shortInt shortLen longInt longLen sum newSum resClass |
	<var: #over type: 'unsigned char  '>
	firstLen := self byteSizeOfBytes: firstInteger.
	secondLen := self byteSizeOfBytes: secondInteger.
	resClass := interpreterProxy fetchClassOf: firstInteger.
	firstLen <= secondLen
		ifTrue: 
			[shortInt := firstInteger.
			shortLen := firstLen.
			longInt := secondInteger.
			longLen := secondLen]
		ifFalse: 
			[shortInt := secondInteger.
			shortLen := secondLen.
			longInt := firstInteger.
			longLen := firstLen].
	"	sum := Integer new: len neg: firstInteger negative."
	self remapOop: #(shortInt longInt ) in: [sum := interpreterProxy instantiateClass: resClass indexableSize: longLen].
	over := self
				cDigitAdd: (interpreterProxy firstIndexableField: shortInt)
				len: shortLen
				with: (interpreterProxy firstIndexableField: longInt)
				len: longLen
				into: (interpreterProxy firstIndexableField: sum).
	over > 0
		ifTrue: 
			["sum := sum growby: 1."
			self remapOop: sum in: [newSum := interpreterProxy instantiateClass: resClass indexableSize: longLen + 1].
			self
				cBytesCopyFrom: (interpreterProxy firstIndexableField: sum)
				to: (interpreterProxy firstIndexableField: newSum)
				len: longLen.
			sum := newSum.
			"C index!"
			(self cCoerce: (interpreterProxy firstIndexableField: sum)
				to: 'unsigned char *')
				at: longLen put: over].
	^ sum