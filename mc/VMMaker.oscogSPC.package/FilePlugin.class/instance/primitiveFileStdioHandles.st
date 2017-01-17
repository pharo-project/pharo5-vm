file primitives
primitiveFileStdioHandles
	"Answer an Array of file handles for standard in, standard out and standard error,
	 with nil in entries that are unvailable, e.g. because the platform does not provide
	 standard error, etc.  Fail if there are no standard i/o facilities on the platform or
	 if the security plugin denies access or if memory runs out."
	| fileRecords result validMask |
	<export: true>
	<var: 'fileRecords' declareC: 'SQFile fileRecords[3]'>
	sHFAfn ~= 0 ifTrue:
		[(self cCode: ' ((sqInt (*)(void))sHFAfn)()' inSmalltalk: [true]) ifFalse:
			[^interpreterProxy primitiveFailFor: PrimErrUnsupported]].
	self cCode: '' inSmalltalk: [fileRecords := Array new: 3].
	validMask := self sqFileStdioHandlesInto: fileRecords.
	validMask = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrUnsupported].
	result := interpreterProxy instantiateClass: interpreterProxy classArray indexableSize: 3.
	result = nil ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrNoMemory].
	interpreterProxy pushRemappableOop: result.
	0 to: 2 do:
		[:index|
		(validMask bitAnd: (1 << index)) ~= 0 ifTrue:
			[result := interpreterProxy instantiateClass: interpreterProxy classByteArray indexableSize: self fileRecordSize.
			 result = nil ifTrue:
				[interpreterProxy popRemappableOop.
				^interpreterProxy primitiveFailFor: PrimErrNoMemory].
			 interpreterProxy storePointer: index ofObject: interpreterProxy topRemappableOop withValue: result.
			 self
				cCode:
					[self mem: (interpreterProxy firstIndexableField: result)
						cp: (self addressOf: (fileRecords at: index))
						y: self fileRecordSize]
				inSmalltalk:
					[(interpreterProxy firstIndexableField: result)
						unitSize: interpreterProxy wordSize;
						at: 0 put: (fileRecords at: index + 1)]]].
	 "In the non-Spur threaded VM ensure the handles are old, so that sqFileReadIntoAt is unaffected
	  by incremental GCs.  See platforms/Cross/plugins/FilePlugin/sqFilePluginBasicPrims.c.  The Spur
	  VM uses pinning, so it doesn't need the GC."
	self cppIf: COGMTVM
		ifTrue: [self cppIf: SPURVM
					ifTrue: []
					ifFalse: [interpreterProxy fullGC]].
	result := interpreterProxy popRemappableOop.
	interpreterProxy pop: 1 thenPush: result