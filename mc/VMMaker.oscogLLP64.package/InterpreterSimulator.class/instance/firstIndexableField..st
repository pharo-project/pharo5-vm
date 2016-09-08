memory access
firstIndexableField: oop
	"NOTE: overridden from ObjectMemory to add coercion to CArray, so please duplicate any changes"
	| hdr fmt totalLength fixedFields |
	<returnTypeC: #'void *'>
	hdr := self baseHeader: oop.
	fmt := self formatOfHeader: hdr.
	fmt <= 4 ifTrue: "<= 4 pointer"
		["pointer; may need to delve into the class format word"
		totalLength := self lengthOf: oop baseHeader: hdr format: fmt.
		fixedFields := self fixedFieldsOf: oop format: fmt length: totalLength.
		^self cCoerce: (self pointerForOop: oop + self baseHeaderSize + (fixedFields << self shiftForWord)) to: 'oop *'].
	^self
		cCoerce: (self pointerForOop: oop + self baseHeaderSize)
		to: (fmt < 8
				ifTrue: [fmt = 6
						ifTrue: ["32 bit field objects" 'int *']
						ifFalse: ["full word objects (bits)" 'oop *']]
				ifFalse: ["byte objects (including CompiledMethod" 'char *'])