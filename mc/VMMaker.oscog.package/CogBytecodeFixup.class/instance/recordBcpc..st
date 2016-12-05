simulation
recordBcpc: theBytecodePC
	<inline: true>
	self cCode: '' inSmalltalk:
		[bcpc
			ifNil: [bcpc := theBytecodePC]
			ifNotNil:
				[bcpc := bcpc isInteger
							ifTrue: [{bcpc. theBytecodePC}]
							ifFalse: [bcpc, {theBytecodePC}]]]