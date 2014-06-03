object access primitives
primitiveInstVarAtPut
	| newValue index rcvr hdr fmt totalLength fixedFields |
	newValue := self stackTop.
	index := self stackIntegerValue: 1.
	rcvr := self stackValue: 2.
	successFlag
		ifTrue: [hdr := self baseHeader: rcvr.
			fmt := hdr >> 8 bitAnd: 15.
			totalLength := self lengthOf: rcvr baseHeader: hdr format: fmt.
			fixedFields := self fixedFieldsOf: rcvr format: fmt length: totalLength.
			(index >= 1 and: [index <= fixedFields]) ifFalse: [successFlag := false]].
	successFlag ifTrue: [self subscript: rcvr with: index storing: newValue format: fmt].
	successFlag ifTrue: [self pop: argumentCount + 1 thenPush: newValue]