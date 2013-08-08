jit - api
ceCaptureCStackPointers
	<api: 'extern void (*ceCaptureCStackPointers)()'>
	<doNotGenerate>
	| range |
	coInterpreter isThreadedVM ifFalse:
		[^self].
	thisContext sender selector == #generateStackPointerCapture ifTrue:
		[^self].
	range := coInterpreter cStackRangeForThreadIndex: coInterpreter threadManager getVMOwner.
	self assert: (range notNil "VM is owned"
				and: [(range includes: processor sp)
				and: [range includes: processor fp]]).
	self setCStackPointer: processor sp.
	self setCFramePointer: processor fp