simulation only
promptForBreakPC
	<doNotGenerate>
	| s first pc |
	s := UIManager default request: 'Break pc (hex)'.
	s := s withBlanksTrimmed.
	s isEmpty ifTrue: [^self].
	('+-' includes: s first) ifTrue: [first := s first. s := s allButFirst].
	(s isEmpty and: [first = $-]) ifTrue:
		[^self breakPC: nil].
	pc := (s includes: $r)
			ifTrue:
				[Number readFrom: s readStream]
			ifFalse:
				[(#('0x' '-0x') detect: [:prefix| s beginsWith: prefix] ifNone: []) ifNotNil:
					[:prefix|
					s := s allButFirst: prefix size.
					prefix first = $- ifTrue: [s := '-', s]].
				Integer readFrom: s readStream base: 16].
	first = $+ ifTrue:
		[^self breakPC: (breakPC addBreakpoint: pc)].
	first = $- ifTrue:
		[^self breakPC: (breakPC removeBreakpoint: pc)].
	self breakPC: pc