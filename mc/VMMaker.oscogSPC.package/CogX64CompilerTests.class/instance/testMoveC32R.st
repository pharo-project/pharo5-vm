tests
testMoveC32R
	"self new testMoveMwrR"
	self concreteCompilerClass registersWithNamesDo:
		[:reg :rname|
		#(0 64 65536 -64 -65536) do:
			[:offset| | inst len |
			inst := self gen: MoveC32R operand: offset operand: reg.
			len := inst concretizeAt: 0.
			self processor
				disassembleInstructionAt: 0
				In: inst machineCode object
				into: [:str :sz| | plainJane herIntended po |
					plainJane := self strip: str.
					po := offset bitAnd: 1 << self processor bitsInWord - 1.
					herIntended := 'movq $0x', (po printStringBase: 16 length: 16 padded: true), ', ', rname.
					self assert: herIntended equals: plainJane.
					self assert: len = sz]]]