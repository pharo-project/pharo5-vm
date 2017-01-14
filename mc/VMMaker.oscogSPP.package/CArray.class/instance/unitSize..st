accessing
unitSize: n
	(n isPowerOfTwo and: [n <= 8]) ifFalse:
		[self error: 'unitSize must be 1, 2, 4 or 8'].
	unitSize := n