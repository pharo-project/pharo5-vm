accessing
setIsBackwardBranchFixup
	<inline: true>
	simStackPtr := UnknownSimStackPtrFlag.
	LowcodeVM ifTrue: [ 
		simNativeStackPtr := UnknownSimStackPtrFlag.
		simNativeStackSize := 0.
	]
