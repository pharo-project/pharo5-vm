*VMMaker-interpreter simulator
removeBreakpoint: address
	^(self copyWithout: address) ifEmpty: nil