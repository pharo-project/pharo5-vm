md5
md5HashStream: aStream
	| start buffer bytes sz n words hash large |
	hash := WordArray with: 16r67452301 with: 16rEFCDAB89 with: 16r98BADCFE with: 16r10325476.
	words := WordArray new: 16.
	buffer := ByteArray new: 64.
	start := aStream position.
	[aStream atEnd] whileFalse: [
		bytes := aStream nextInto: buffer.
		(bytes size < 64 or:[aStream atEnd]) ifTrue:[
			sz := bytes size.
			buffer replaceFrom: 1 to: sz with: bytes startingAt: 1.
			buffer from: sz+1 to: buffer size put: 0.
			sz < 56 ifTrue:[
				buffer at: sz + 1 put: 128. "trailing bit"
			] ifFalse:[
				"not enough room for the length, so just pad this one, then..."
				sz < 64 ifTrue:[buffer at: sz + 1 put: 128].
				1 to: 16 do:[:i| words at: i put: (buffer unsignedLongAt: i*4-3 bigEndian: false)].
				self md5Transform: words hash: hash.
				"process one additional block of padding ending with the length"
				buffer atAllPut: 0.
				sz = 64 ifTrue: [buffer at: 1 put: 128].
			].
			"Fill in the final 8 bytes with the 64-bit length in bits."
			n := (aStream position - start) * 8.
			7 to: 0 by: -1 do:[:i| buffer at: (buffer size - i) put: ((n bitShift: 7 - i * -8) bitAnd: 255)].
		].
		1 to: 16 do:[:i| words at: i put: (buffer unsignedLongAt: i*4-3 bigEndian: false)].
		self md5Transform: words hash: hash.
	].
	bytes := ByteArray new: 16.
	bytes unsignedLongAt: 1 put: (hash at: 4) bigEndian: true.
	bytes unsignedLongAt: 5 put: (hash at: 3) bigEndian: true.
	bytes unsignedLongAt: 9 put: (hash at: 2) bigEndian: true.
	bytes unsignedLongAt: 13 put: (hash at: 1) bigEndian: true.
	large := LargePositiveInteger new: 16.
	1 to: 16 do:[:i| large digitAt: i put: (bytes at: i)].
	^large normalize