debug support
sendBreakpoint: selector receiver: receiver
	<inline: true>
	self sendBreak: (objectMemory firstFixedFieldOfMaybeImmediate: selector)
		point: (objectMemory lengthOfMaybeImmediate: selector)
		receiver: receiver