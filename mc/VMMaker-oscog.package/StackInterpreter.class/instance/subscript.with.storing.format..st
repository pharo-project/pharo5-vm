indexing primitive support
subscript: array with: index storing: oopToStore format: fmt 
	"Note: This method assumes that the index is within bounds!"
	| valueToStore |
	<inline: true>
	fmt <= 4
		ifTrue: ["pointer type objects"
			objectMemory storePointer: index - 1 ofObject: array
				withValue: oopToStore]
		ifFalse: [fmt < 8
				ifTrue: ["long-word type objects"
					valueToStore := self positive32BitValueOf: oopToStore.
					self successful
						ifTrue: [objectMemory storeLong32: index - 1 ofObject: array
									withValue: valueToStore]]
				ifFalse: ["byte-type objects"
					(objectMemory isIntegerObject: oopToStore)
						ifFalse: [self success: false].
					valueToStore := objectMemory integerValueOf: oopToStore.
					(valueToStore >= 0
							and: [valueToStore <= 255])
						ifFalse: [self success: false].
					self successful
						ifTrue: [objectMemory
								storeByte: index - 1
								ofObject: array
								withValue: valueToStore]]]