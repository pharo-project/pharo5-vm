register management
registerMaskFor: reg1 and: reg2
	<inline: true>
	^1 << reg1 bitOr: 1 << reg2