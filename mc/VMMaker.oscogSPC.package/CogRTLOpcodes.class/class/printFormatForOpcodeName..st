debug printing
printFormatForOpcodeName: opcodeName
	"Answer a sequence of $r, $f or nil for the operands in the opcode, used for printing, where
	 r => integer register, f => floating point register, and nil => numeric or address operand."
	| printFormat operands |
	printFormat := OrderedCollection new.
	operands := opcodeName.
	[(#(	('Ab' nil) ('Aw' nil)
		('Cw' nil) ('Cq' nil) ('C32' nil)
		(Fill32 nil)
		(Label nil) (Literal nil)
		('Mb' nil) ('Mw' nil) ('M16' nil) ('M32' nil) ('M64' nil)
		('Nops' nil)
		('R' $r) ('Rd' $f) ('Rs' $f)
		('Xbr' $r) ('Xwr' $r) ('X16r' $r) ('X32r' $r) ('X64r' $r) ('X' $r) ('ow' nil)
		('Greater' exit) ('Xor' exit) ('r' $r))
				detect: [:pair| operands endsWith: pair first]
				ifNone: [])
			ifNil: [false]
			ifNotNil:
				[:match|
				match last ~~ #exit
				and: [operands := operands allButLast: match first size.
					 printFormat addFirst: match last.
					 true]]]
		whileTrue.
	(printFormat isEmpty and: [(operands beginsWith: 'Jump') or: [operands beginsWith: 'Call']]) ifTrue:
		[printFormat addFirst: nil].
	^printFormat
	
	"classPool keys sort collect: [:k| { k. (self printFormatForOpcodeName: k) asArray}]"