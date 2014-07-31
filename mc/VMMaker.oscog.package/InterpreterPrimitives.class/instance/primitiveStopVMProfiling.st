process primitives
primitiveStopVMProfiling
	"Primitive. Stop the VM profiler and either copy the histogram data into the
	 supplied arguments, if they're non-nil.  Fail if the arguments are not of the right type or size."
	| vmHistArrayOrNil vmHist vmBins easHistArrayOrNil easHist easBins |
	<var: #vmHist type: #'long *'>
	<var: #vmBins type: #long>
	<var: #easHist type: #'long *'>
	<var: #easBins type: #long>
	self success: argumentCount = 2.
	vmHistArrayOrNil := self stackObjectValue: 1.
	easHistArrayOrNil := self stackObjectValue: 0.
	self successful ifFalse:
		[^nil].
	"Both args must be either nil or arrays.  If they're arrays and the wrong size we incorrectly stop profiling."
	((vmHistArrayOrNil = objectMemory nilObject or: [(objectMemory fetchClassOfNonImm: vmHistArrayOrNil) = (objectMemory splObj: ClassArray)])
	 and: [(objectMemory fetchClassOfNonImm: vmHistArrayOrNil) = (objectMemory fetchClassOfNonImm: easHistArrayOrNil)]) ifFalse:
		[^self primitiveFail].
	self cCode: 'ioControlProfile(0,&vmHist,&vmBins,&easHist,&easBins)'
		inSmalltalk: [vmHist := vmBins := easHist := easBins := 0].
	vmHistArrayOrNil ~= objectMemory nilObject ifTrue:
		[((objectMemory numSlotsOf: vmHistArrayOrNil) = vmBins
		  and: [(objectMemory numSlotsOf: easHistArrayOrNil) = easBins]) ifFalse:
			[^self primitiveFail].
		0 to: vmBins - 1 do:
			[:i|
			objectMemory storePointerUnchecked: i
				ofObject: vmHistArrayOrNil
				withValue: (objectMemory integerObjectOf: (vmHist at: i))].
		0 to: easBins - 1 do:
			[:i|
			objectMemory storePointerUnchecked: i
				ofObject: easHistArrayOrNil
				withValue: (objectMemory integerObjectOf: (easHist at: i))]].
	self pop: argumentCount