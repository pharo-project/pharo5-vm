simulation
recordBcpc: bytecodePC
	<inline: true>
	self cCode: '' inSmalltalk:
		[bcpc
			ifNil: [bcpc := bytecodePC]
			ifNotNil:
				[bcpc := bcpc isInteger
							ifTrue: [{bcpc. bytecodePC}]
							ifFalse: [bcpc, {bytecodePC}]]]