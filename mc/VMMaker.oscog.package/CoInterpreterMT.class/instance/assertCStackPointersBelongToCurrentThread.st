simulation
assertCStackPointersBelongToCurrentThread
	<doNotGenerate>
	| range |
	range := self cStackRangeForCurrentThread.
	self assert: ((range includes: cogit getCStackPointer)
				and: [range includes: cogit getCFramePointer])