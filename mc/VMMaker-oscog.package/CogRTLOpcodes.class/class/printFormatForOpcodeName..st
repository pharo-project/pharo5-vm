debug printing
printFormatForOpcodeName: opcodeName
	"Answer a sequence of $r or nil for the operands in the opcode, used for printing."
	| format operands size |
	format := OrderedCollection new.
	size := (operands := opcodeName) size.
	[#('XwrR' 'X16rR' 'XbrR' 'RR' 'RdR' 'RRd' 'RdRd') do:
		[:regRegFmt|
		(operands endsWith: regRegFmt) ifTrue:
			[format addLast: $r; addLast: $r.
			 operands := operands allButLast: regRegFmt size]].
	  #('Mwr' 'M16r' 'Mbr' 'M64r') do:
		[:constRegFmt|
		(operands endsWith: constRegFmt) ifTrue:
			[format addLast: $r; addLast: nil.
			 operands := operands allButLast: constRegFmt size]].
	  #('Cq' 'Cw' 'C32' 'C64' 'Aw' 'Ab') do:
		[:constFmt|
		(operands endsWith: constFmt) ifTrue:
			[format addLast: nil.
			 operands := operands allButLast: constFmt size]].
	 #('R' 'Rd') do:
		[:regFmt|
		(operands endsWith: regFmt) ifTrue:
			[format addLast: $r.
			 operands := operands allButLast: regFmt size]].
	 operands size < size]
		whileTrue: [size := operands size].
	^format reverse
	
	"classPool keys collect: [:k| { k. (self printFormatForOpcodeName: k) asArray}]"