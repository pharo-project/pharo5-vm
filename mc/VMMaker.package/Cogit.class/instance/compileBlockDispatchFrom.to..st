compile abstract instructions
compileBlockDispatchFrom: lowBlockStartIndex to: highBlockStartIndex
	<var: #blockStart type: #'BlockStart *'>
	<var: #jmp type: #'AbstractInstruction *'>
	| blockStart halfWay jmp |
	lowBlockStartIndex = highBlockStartIndex ifTrue:
		[blockStart := self blockStartAt: lowBlockStartIndex.
		 self Jump: blockStart entryLabel.
		^nil].
	halfWay := highBlockStartIndex + lowBlockStartIndex // 2.
	self assert: (halfWay between: lowBlockStartIndex and: highBlockStartIndex).
	blockStart := self blockStartAt: halfWay.
	"N.B. FLAGS := TempReg - startpc"
	self CmpCq: (objectMemory integerObjectOf: blockStart startpc + 1) R: TempReg.
	lowBlockStartIndex = halfWay ifTrue:
		[self JumpLessOrEqual: blockStart entryLabel.
		 self compileBlockDispatchFrom: halfWay + 1 to: highBlockStartIndex.
		 ^nil].
	halfWay + 1 = highBlockStartIndex ifTrue:
		[blockStart := self blockStartAt: highBlockStartIndex.
		 self JumpGreater: blockStart entryLabel.
		 ^self compileBlockDispatchFrom: lowBlockStartIndex to: halfWay].
	jmp := self JumpGreater: 0.
	self compileBlockDispatchFrom: lowBlockStartIndex to: halfWay.
	halfWay = highBlockStartIndex
		ifTrue:
			[blockStart := self blockStartAt: highBlockStartIndex.
			 jmp jmpTarget: blockStart entryLabel]
		ifFalse:
			[jmp jmpTarget: self Label.
			 self compileBlockDispatchFrom: halfWay + 1 to: highBlockStartIndex]