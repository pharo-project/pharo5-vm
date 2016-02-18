munging
installableMethodFor: methodWithSource selector: selectorOop siblingMethod: sibling 
	| method classOop clone delta numBytes |
	method := methodWithSource copyWithTempsFromMethodNode: methodWithSource methodNode.
	delta := (method primitive > 0
			  and: [(method at: method initialPC) ~= method methodClass callPrimitiveCode])
				ifTrue: [3]
				ifFalse: [0].
	clone := heap
				allocateSlots: (heap numSlotsForBytes: (numBytes := method size) + delta)
				format: (heap compiledMethodFormatForNumBytes: numBytes + delta)
				classIndex: (heap classIndexOf: sibling).
	classOop := interpreter methodClassOf: sibling.
	method methodClass isMeta ifTrue:
		[classOop := heap fetchPointer: interpreter thisClassIndex ofObject: classOop].
	heap storePointer: 0
		ofObject: clone
		withValue: (self methodHeaderForMethod: method).
	1 to: method numLiterals - 2 do:
		[:i|
		heap storePointer: i
			ofObject: clone
			withValue: (self literalFor: (method literalAt: i) inClass: classOop)].
	heap
		storePointer: method numLiterals - 1
			ofObject: clone
				withValue: selectorOop;
		storePointer: method numLiterals
			ofObject: clone
				withValue: (interpreter methodClassAssociationOf: sibling).

	delta > 0 ifTrue:
		[heap
			storeByte: method initialPC - 1 ofObject: clone 	withValue: 139;
			storeByte: method initialPC + 0 ofObject: clone withValue: (method primitive bitAnd: 255);
			storeByte: method initialPC + 1 ofObject: clone withValue: (method primitive bitShift: -8)].
	method initialPC to: method size do:
		[:i|
		 heap storeByte: i - 1 + delta ofObject: clone withValue: (method at: i)].

	^clone