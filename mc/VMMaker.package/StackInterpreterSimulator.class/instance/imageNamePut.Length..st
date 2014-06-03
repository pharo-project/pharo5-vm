file primitives
imageNamePut: p Length: sz
	| newName |
	newName := ByteString new: sz.
	1 to: sz  do:
		[:i |
		newName
			at: i
			put: (Character value: (objectMemory byteAt: p + i - 1))].
	imageName := newName