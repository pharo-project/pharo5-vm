array primitive support
stObject: array at: index
	"Return what ST would return for <obj> at: index."

	| hdr fmt totalLength fixedFields stSize |
	<inline: false>
	hdr := self baseHeader: array.
	fmt := (hdr >> 8) bitAnd: 16rF.
	totalLength := self lengthOf: array baseHeader: hdr format: fmt.
	fixedFields := self fixedFieldsOf: array format: fmt length: totalLength.
	(fmt = 3 and: [self isContextHeader: hdr])
		ifTrue: [stSize := self fetchStackPointerOf: array]
		ifFalse: [stSize := totalLength - fixedFields].
	((self oop: index isGreaterThanOrEqualTo: 1)
			and: [self oop: index isLessThanOrEqualTo: stSize])
		ifTrue: [^ self subscript: array with: (index + fixedFields) format: fmt]
		ifFalse: [successFlag := false.  ^ 0].