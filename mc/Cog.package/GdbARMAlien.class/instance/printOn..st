printing
printOn: aStream
	| first |
	first := true.
	aStream nextPutAll: 'an ARMAlien ('.
	self registerState with: self registerStateGetters do: [ :state :getter |
		first
			ifTrue: [first := false]
			ifFalse: [aStream << ', '].
		getter first = $d
			ifTrue:
				[aStream
					<< getter << ': '
					<< (Float fromIEEE64BitWord: state)]
			ifFalse:
				[getter == #eflags
					ifTrue:
						[aStream
							<< 'NZCVIF: '
							<< (state printStringBase: 2 length: 6 padded: true)]
					ifFalse:
						[aStream
							<< getter << ': '
							<< (state printStringBase: 16)]]]