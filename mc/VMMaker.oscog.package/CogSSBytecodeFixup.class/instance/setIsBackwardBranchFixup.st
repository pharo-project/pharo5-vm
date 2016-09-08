accessing
setIsBackwardBranchFixup
	<inline: true>
	simStackPtr := UnknownSimStackPtrFlag.
	self cppIf: LowcodeVM ifTrue: [ 
		simNativeStackPtr := UnknownSimStackPtrFlag.
		simNativeStackSize := 0.
	]
