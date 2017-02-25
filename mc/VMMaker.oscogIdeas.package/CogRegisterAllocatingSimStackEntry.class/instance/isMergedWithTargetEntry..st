comparing
isMergedWithTargetEntry: targetEntry
	"The receiver is a simStackEntry at a jump to the corresponding simStackEntry at the jump's target.
	 Answer if no merge is required for the jump."
	<var: 'ssEntry' type: #'CogSimStackEntry *'>
	spilled ~= targetEntry spilled ifTrue: "push or pop required"
		[^false].
	(liveRegister = NoReg and: [targetEntry liveRegister ~= NoReg]) ifTrue: "register load required"
		[^false].
	(self isSameEntryAs: targetEntry) ifTrue:
		[^liveRegister = targetEntry liveRegister].
	(type = SSConstant and: [targetEntry type = SSRegister and: [liveRegister = targetEntry register]]) ifTrue:
		[^true].
	"self: const =1 (16r1) (live: Extra4Reg) {172} vs reg ReceiverResultReg {127}"
	"self: reg ReceiverResultReg {95} vs reg Extra5Reg {85}"
	"(bo ReceiverResultReg+296 (live: Extra5Reg) {88} vs reg ReceiverResultReg {84}"
	((type = SSConstant and: [targetEntry type = SSRegister and: [liveRegister ~= targetEntry registerOrNone]])
	 or: [(type = SSRegister and: [targetEntry type = SSRegister and: [register ~= targetEntry registerOrNone]])
	 or: [type = SSBaseOffset and: [register = ReceiverResultReg and: [targetEntry type = SSRegister]]]]) ifFalse:
		[self halt: 'comment the incompatible pair please'].
	^false