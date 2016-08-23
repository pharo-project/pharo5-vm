generate machine code
computeJumpTargetOffsetPlus: anPCOffset
	<inline: true> "Since it's an extraction from other methods."
	| jumpTarget |
	<var: #jumpTarget type: #'AbstractInstruction *'>
	jumpTarget := self jumpTargetAddress.
	^jumpTarget signedIntFromLong - (address + anPCOffset) signedIntFromLong.