simulation
assertCStackPointersBelongToCurrentVMOwner
	<doNotGenerate>
	| range |
	range := self cStackRangeForCurrentVMOwner.
	self assert: (range notNil "VM is owned"
				and: [(range includes: cogit getCStackPointer)
				and: [range includes: cogit getCFramePointer]])