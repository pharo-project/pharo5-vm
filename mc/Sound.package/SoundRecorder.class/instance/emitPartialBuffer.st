private
emitPartialBuffer
	| s |
	s := self samplesPerFrame.
	self emitBuffer: (currentBuffer copyFrom: 1 to: ((nextIndex-1) +( s-1) truncateTo: s))