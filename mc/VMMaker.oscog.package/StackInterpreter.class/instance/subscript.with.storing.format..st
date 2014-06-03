indexing primitive support
subscript: array with: index storing: oopToStore format: fmt 
	"Note: This method assumes that the index is within bounds!"
	| valueToStore |
	<inline: true>
	fmt <= objectMemory lastPointerFormat
		ifTrue:
			[objectMemory
				storePointer: index - 1
				ofObject: array
				withValue: oopToStore]
		ifFalse:
			[fmt >= objectMemory firstByteFormat
				ifTrue:
					[(objectMemory isIntegerObject: oopToStore) ifFalse:
						[primFailCode := PrimErrBadIndex].
					 valueToStore := objectMemory integerValueOf: oopToStore.
					 (valueToStore >= 0 and: [valueToStore <= 255]) ifFalse:
						[primFailCode := PrimErrBadArgument].
					self successful ifTrue:
						[objectMemory
							storeByte: index - 1
							ofObject: array
							withValue: valueToStore]]
				ifFalse: "long-word type objects"
					[valueToStore := self positive32BitValueOf: oopToStore.
					self successful ifTrue:
						[objectMemory
							storeLong32: index - 1
							ofObject: array
							withValue: valueToStore]]]