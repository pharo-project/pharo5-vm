compile abstract instructions
noteLiveRegisterIn: simStackEntry
	"Copy the liveRegister state in simStackEntry into the receiver if it is the same value at a different location on the stack."
	<inline: true>
	self flag: 'should this also apply to SSConstant entries assigned to registers?'.
	(self ~~ simStackEntry
	 and: [type = simStackEntry type
	 and: [type = SSBaseOffset
	 and: [register = simStackEntry register and: [offset = simStackEntry offset]]]]) ifTrue:
		[liveRegister := simStackEntry liveRegister]