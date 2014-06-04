file primitives
imageNameGet: p Length: sz
	1 to: sz  do:
		[:i |
		objectMemory
			byteAt:  p + i - 1
			put: (imageName at: i) asInteger]