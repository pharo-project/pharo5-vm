oop functions
isNormalized: anInteger 
	| len class positive pointer |
	<var: #pointer type: #'unsigned char *'>
	(interpreterProxy isIntegerObject: anInteger) ifTrue:
		[^true].
	class := interpreterProxy fetchClassOf: anInteger.
	(positive := class = interpreterProxy classLargePositiveInteger) ifFalse:
		[class = interpreterProxy classLargeNegativeInteger ifFalse:
			[interpreterProxy primitiveFailFor: PrimErrBadArgument.
			 ^false]].
	pointer := interpreterProxy cCoerce: (interpreterProxy firstIndexableField: anInteger) to: #'unsigned char *'.
	"Check for leading zero of LargeInteger"
	len := self digitLengthOfNonImmediate: anInteger.
	(len = 0 or: [(pointer at: len - 1) = 0]) ifTrue:
		[^false].
	"no leading zero, now check if anInteger is in SmallInteger range or not"
	"maximal digitLength of aSmallInteger"
	len ~= interpreterProxy bytesPerOop ifTrue:
		[^len > interpreterProxy bytesPerOop].
	positive ifTrue: "all bytes of but the highest one are just FF's"
		[^(pointer at: interpreterProxy bytesPerOop - 1)
			> (self cDigitOfCSI: interpreterProxy maxSmallInteger at: interpreterProxy bytesPerOop)].
	"all bytes of but the highest one are just 00's"
	(pointer at: interpreterProxy bytesPerOop - 1)
	 < (self cDigitOfCSI: interpreterProxy minSmallInteger at: interpreterProxy bytesPerOop) ifTrue:
		[^false].
	"if just one digit differs, then anInteger < minval (the corresponding digit byte is greater!)
	 and therefore a LargeNegativeInteger"
	0 to: interpreterProxy bytesPerOop - 1 do:
		[:ix |
		(pointer at: ix) = (self cDigitOfCSI: interpreterProxy minSmallInteger at: ix + 1) ifFalse:
			[^true]].
	^false