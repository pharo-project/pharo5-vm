process primitives
primitiveVMProfileInfoInto
	"Primitive. Answer whether the profiler is running or not.
	 If the argument is an Array of suitable size fill it with the following information:
		1. the addresses of the first element of the VM histogram (the first address in the executable)
		2. the address following the last element (the last address in the executable, excluding dynamically linked libraries)
		3. the size of the VM histogram in bins (each bin is a 4 byte unsigned long)
		4. the size of the VM histogram in bins (each bin is a 4 byte unsigned long)"
	| info running exeStart exeLimit vmBins easBins |
	<var: #exeStart type: #'char *'>
	<var: #exeLimit type: #'char *'>
	<var: #vmBins type: #long>
	<var: #easBins type: #long>
	self success: argumentCount = 1.
	self successful ifTrue:
		[info := self stackObjectValue: 0].
	self successful ifTrue:
		[info ~= objectMemory nilObject ifTrue:
			[self assertClassOf: info is: (objectMemory splObj: ClassArray).
			 self success: (objectMemory numSlotsOf: info) >= 4]].
	self successful ifFalse:
		[^nil].
	
	self cCode: 'ioProfileStatus(&running,&exeStart,&exeLimit,0,&vmBins,0,&easBins)'
		inSmalltalk: [running := exeStart := exeLimit := vmBins := easBins := 0].
	info ~= objectMemory nilObject ifTrue:
		[objectMemory storePointerUnchecked: 0
			ofObject: info
			withValue: (objectMemory integerObjectOf: (self oopForPointer: exeStart)).
		objectMemory storePointerUnchecked: 1
			ofObject: info
			withValue: (objectMemory integerObjectOf: (self oopForPointer: exeLimit)).
		objectMemory storePointerUnchecked: 2
			ofObject: info
			withValue: (objectMemory integerObjectOf: vmBins).
		objectMemory storePointerUnchecked: 3
			ofObject: info
			withValue: (objectMemory integerObjectOf: easBins)].
	self pop: 2 thenPushBool: running