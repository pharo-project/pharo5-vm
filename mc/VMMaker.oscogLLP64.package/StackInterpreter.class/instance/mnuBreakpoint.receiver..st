debug support
mnuBreakpoint: selector receiver: rcvr
	<inline: true>
	self mnuBreak: (objectMemory firstFixedFieldOfMaybeImmediate: selector)
		point: (objectMemory lengthOfMaybeImmediate: selector)
		receiver: rcvr