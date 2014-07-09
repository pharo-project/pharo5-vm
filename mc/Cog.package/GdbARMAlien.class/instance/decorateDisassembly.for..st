disassembly
decorateDisassembly: anInstructionString for: aSymbolManager
	| parts strm hexNum string |

	"break up the string"
	parts:= anInstructionString subStrings: '	 ,:'.
	"part 1 is the address, part 2 is the instruction. Last part is sometimes a hex number"
	
	"is this a mov of a literal number?"
	((parts at: 2) includesSubString: 'mov')
		ifTrue:[ 
			"clear the flags & running total"
			LongConstReg := nil.
			LongConstValue := 0.
			LongConstStep := 0.
			(parts at:4) first = $#
				ifTrue:["looks a good candidate"
					LongConstReg :=(parts at: 3). "the target register"
					(parts last beginsWith: '0x') ifTrue:[
						LongConstValue :=(NumberParser on: (parts last allButFirst:2)) nextUnsignedIntegerBase: 16].
					LongConstStep := 1].
			"not a likely candidate, just return the string"			
			^anInstructionString].
	
	"is this a build of a literal number?"
	(((parts at: 2) includesSubString: 'orr') and:[LongConstStep >0])
		ifTrue:["add to running total if the register matches"
			LongConstReg = (parts at: 3) 
				ifTrue:[
					(parts at:5) first = $#
						ifTrue:["looks a good candidate"
							(parts last beginsWith: '0x') ifTrue:[
								LongConstValue := LongConstValue + ((NumberParser on: (parts last allButFirst:2)) nextUnsignedIntegerBase: 16) ].
							LongConstStep:= LongConstStep +1].
					LongConstStep = 4
						ifTrue:["we've completed a pattern of mov/orr/orr/orr, so print the value it built" 
							^anInstructionString, ' (', LongConstReg , ' = ', LongConstValue hex8, ((aSymbolManager lookupAddress: LongConstValue) ifNil: [''] ifNotNil:[:val| ' = ', val]), ')']]
				ifFalse:[ LongConstStep := 0.
						LongConstReg := nil.
						LongConstValue := 0].
			"either not a likely candidate orpartway through the pattern, so just return the string"			
			^anInstructionString].
	

	strm :=anInstructionString readStream.
	strm skip: 9. "the instruction address"
	
	strm upToAll: '0x'. "see if there is a hex number"
	strm atEnd ifTrue:[^anInstructionString]. "if not, leave it be"

	"extract the number"		
	hexNum := (NumberParser on: strm) nextUnsignedIntegerBase: 16.
	"is there an intersting address with this?"
	(string := aSymbolManager lookupAddress: hexNum) ifNil: [^anInstructionString].
	^ anInstructionString, ' = ', string