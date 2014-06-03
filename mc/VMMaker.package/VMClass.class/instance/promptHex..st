simulation support
promptHex: string
	<doNotGenerate>
	| s |
	s := UIManager default request: string, ' (hex)'.
	s := s withBlanksTrimmed.
	^(s notEmpty and: ['-+0123456789abcdefABCDEF' includes: s first]) ifTrue:
		[(s includes: $r)
			ifTrue:
				[Number readFrom: s readStream]
			ifFalse:
				[(#('0x' '-0x') detect: [:prefix| s beginsWith: prefix] ifNone: []) ifNotNil:
					[:prefix|
					s := s allButFirst: prefix size.
					prefix first = $- ifTrue: [s := '-', s]].
				Integer readFrom: s readStream base: 16]]