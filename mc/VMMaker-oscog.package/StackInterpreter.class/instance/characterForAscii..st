indexing primitive support
characterForAscii: ascii  "Arg must lie in range 0-255!"
	<inline: true>
	^ objectMemory fetchPointer: ascii ofObject: (objectMemory splObj: CharacterTable)