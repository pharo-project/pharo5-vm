comparing
isMergedWithTargetEntry: targetEntry
	"The receiver is a simStackEntry at a jump to the corresponding simStackEntry at the jump's target.
	 Answer if no merge is required for the jump."
	<var: 'ssEntry' type: #'CogSimStackEntry *'>
	spilled ~= targetEntry spilled ifTrue: "push or pop required"
		[^false].
	(liveRegister = NoReg and: [targetEntry liveRegister ~= NoReg]) ifTrue: "register load required"
		[^false].
	(liveRegister ~= NoReg
	 and: [liveRegister = targetEntry liveRegister
	 and: [type = targetEntry type
	 and: [type = SSConstant or: [type = SSRegister and: [register = targetEntry register]]]]]) ifTrue:
		[^true].
	((type = SSBaseOffset or: [type == SSSpill])
	 and: [(targetEntry type = SSBaseOffset or: [targetEntry type == SSSpill])
	 and: [offset = targetEntry offset and: [register = targetEntry register]]]) ifTrue:
		[^true].
	"self: const =1 (16r1) (live: Extra4Reg) {172} vs reg ReceiverResultReg {127}"
	"self: reg ReceiverResultReg {95} vs reg Extra5Reg {85}"
	((type = SSConstant and: [targetEntry type = SSRegister and: [liveRegister ~= targetEntry registerOrNone]])
	 or: [type = SSRegister and: [targetEntry type = SSRegister and: [register ~= targetEntry registerOrNone]]]) ifFalse:
		[self halt: 'comment the incompatible pair please'].
	^false