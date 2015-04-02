accessing-abstract
extractOffsetFromLoadStore: instr
"work out the address offset implied by instr.
We assume it has been determined it is actually a load store before attaching any meaning to the result.
If it is post-indexed, then the offset must be 0, no matter what else is encoded.
If the instr is immediate-offset, pull the relevent bits out of instr.
If it is register-offset, pull the value from the indicated register."
	|offset shiftAmt shiftType |

	"post-indexed means no offset to the read address"
	(instr bitAnd: 1 << 24) = 0 ifTrue:[^0].
	
	(self instructionIsImmediateOffsetLoadStore: instr)
		ifTrue:["two cases apply - a 12bit immediate for 010 group instructions and an 8bit for 000 group ldrh stuff"
			(instr >> 25 bitAnd: 7) = 2
				ifTrue:[ "immed word or byte op, with 12bit offset"
					offset := instr bitAnd: 16rFFF]
				ifFalse:["halfword 8bit offset"
					offset := (instr bitAnd: 16rF00)>>4 bitOr: (instr bitAnd: 16rF)]].

	(self instructionIsRegisterOffsetLoadStore: instr)
		ifTrue:["both forms use same offset-reg encoding"
			offset := self perform:(self registerStateGetters at:(instr bitAnd: 16rF) + 1).
			(instr >> 25 bitAnd: 7) = 3
				ifTrue:[ "register offset with assorted modifiers"
					"sort out modifiers"
					shiftType := instr >> 5 bitAnd: 3.
					shiftAmt := instr  >>7 bitAnd: 16r1F.
					shiftType = 0"lsl" ifTrue:[offset := offset << shiftAmt.].
					shiftType = 1"lsr" ifTrue:[offset := offset >> shiftAmt].
					shiftType = 2"asr" ifTrue:[offset := offset  >>> shiftAmt].
					"I refuse to countenance using ROR or RRX here. Just Say No" ]
				"halfword stuff register offset uses no modifiers in the form we suport. See ARM DDI0406A p. A8-156"].

	"all forms have the bit 23 up/down flag to account for"
	(instr bitAnd: 1<<23) = 0
						ifTrue:["-ve offset" ^offset negated]
						ifFalse:["+ve offset" ^offset]	