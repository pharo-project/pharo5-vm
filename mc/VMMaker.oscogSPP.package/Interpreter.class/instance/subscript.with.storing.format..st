array primitive support
subscript: array with: index storing: oopToStore format: fmt 
	"Note: This method assumes that the index is within bounds!"
	| valueToStore |
	<inline: true>
	fmt <= 4
		ifTrue: ["pointer type objects"
			self storePointer: index - 1 ofObject: array
				withValue: oopToStore]
		ifFalse: [fmt < 8
				ifTrue: ["long-word type objects"
					valueToStore := self positive32BitValueOf: oopToStore.
					successFlag
						ifTrue: [self storeLong32: index - 1 ofObject: array
									withValue: valueToStore]]
				ifFalse: ["byte-type objects"
					(self isIntegerObject: oopToStore)
						ifFalse: [successFlag := false].
					valueToStore := self integerValueOf: oopToStore.
					(valueToStore >= 0
							and: [valueToStore <= 255])
						ifFalse: [successFlag := false].
					successFlag
						ifTrue: [self
								storeByte: index - 1
								ofObject: array
								withValue: valueToStore]]]