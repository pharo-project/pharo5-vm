object format
firstIndexableField: oop
	"NOTE: overridden in various simulator subclasses to add coercion to CArray, so please duplicate any changes"
	| hdr fmt totalLength fixedFields |
	<returnTypeC: #'void *'>
	hdr := self baseHeader: oop.
	fmt := self formatOfHeader: hdr.
	fmt <= self lastPointerFormat ifTrue:
		["pointer; may need to delve into the class format word"
		totalLength := self lengthOf: oop baseHeader: hdr format: fmt.
		fixedFields := self fixedFieldsOf: oop format: fmt length: totalLength.
		^self pointerForOop: oop + self baseHeaderSize + (fixedFields << self shiftForWord)].
	^self pointerForOop: oop + self baseHeaderSize