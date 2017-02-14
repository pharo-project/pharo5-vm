simulation
recordBcpc: theBytecodePC
	<inline: true>
	self cCode: '' inSmalltalk:
		[(bcpc isNil or: [bcpc = theBytecodePC])
			ifTrue: [bcpc := theBytecodePC]
			ifFalse:
				[bcpc := bcpc isInteger
							ifTrue: [{bcpc. theBytecodePC}]
							ifFalse: [bcpc, {theBytecodePC}]]]