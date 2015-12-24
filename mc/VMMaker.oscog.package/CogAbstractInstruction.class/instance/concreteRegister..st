private
concreteRegister: reg
	<inline: true>
	self cCode: [] inSmalltalk: [self assert: reg isInteger].
	^reg