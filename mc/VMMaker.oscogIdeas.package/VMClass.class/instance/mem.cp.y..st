C library simulation
mem: dString cp: sString y: bytes
	<doNotGenerate>
	"implementation of memcpy(3). N.B. If ranges overlap, must use memmove."
	(dString isString or: [sString isString]) ifFalse:
		[| destAddress sourceAddress |
		 destAddress := dString asInteger.
		 sourceAddress := sString asInteger.
		 self deny: ((destAddress <= sourceAddress and: [destAddress + bytes > sourceAddress])
					or: [sourceAddress <= destAddress and: [sourceAddress + bytes > destAddress]])].
	dString isString
		ifTrue:
			[1 to: bytes do:
				[:i| | v |
				v := sString isString
						ifTrue: [sString at: i]
						ifFalse: [Character value: (self byteAt: sString + i - 1)].
				dString at: i put: v]]
		ifFalse:
			[1 to: bytes do:
				[:i| | v |
				v := sString isString
						ifTrue: [(sString at: i) asInteger]
						ifFalse: [self byteAt: sString + i - 1].
				self byteAt: dString + i - 1 put: v]].
	^dString