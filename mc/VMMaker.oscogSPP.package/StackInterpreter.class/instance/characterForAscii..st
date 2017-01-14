indexing primitive support
characterForAscii: ascii  "Above ObjectMemory, arg must lie in range 0-255!"
	<inline: true>
	^CharacterTable
		ifNil: [objectMemory characterObjectOf: ascii]
		ifNotNil: [objectMemory fetchPointer: ascii ofObject: objectMemory characterTable]