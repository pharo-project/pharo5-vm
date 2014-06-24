system control primitives
primitiveVMParameter
	"Behaviour depends on argument count:
		0 args:	return an Array of VM parameter values;
		1 arg:	return the indicated VM parameter;
		2 args:	set the VM indicated parameter.
	VM parameters are numbered as follows:
		1	end/size of old-space (0-based, read-only)
		2	end/size of young/new-space (read-only)
		3	end/size of heap (read-only)
		4	nil (was allocationCount (read-only))
		5	nil (was allocations between GCs (read-write)
		6	survivor count tenuring threshold (read-write)
		7	full GCs since startup (read-only)
		8	total milliseconds in full GCs since startup (read-only)
		9	incremental GCs (SqueakV3) or scavenges (Spur) since startup (read-only)
		10	total milliseconds in incremental GCs (SqueakV3) or scavenges (Spur) since startup (read-only)
		11	tenures of surving objects since startup (read-only)
		12-20 specific to ikp's JITTER VM
		21	root table size (read-only)
		22	root table overflows since startup (read-only)
		23	bytes of extra memory to reserve for VM buffers, plugins, etc.
		24	memory threshold above which shrinking object memory (rw)
		25	memory headroom when growing object memory (rw)
		26	interruptChecksEveryNms - force an ioProcessEvents every N milliseconds (rw)
		27	number of times mark loop iterated for current IGC/FGC (read-only) includes ALL marking
		28	number of times sweep loop iterated for current IGC/FGC (read-only)
		29	number of times make forward loop iterated for current IGC/FGC (read-only)
		30	number of times compact move loop iterated for current IGC/FGC (read-only)
		31	number of grow memory requests (read-only)
		32	number of shrink memory requests (read-only)
		33	number of root table entries used for current IGC/FGC (read-only)
		34	number of allocations done before current IGC/FGC (read-only)
		35	number of survivor objects after current IGC/FGC (read-only)
		36	millisecond clock when current IGC/FGC completed (read-only)
		37	number of marked objects for Roots of the world, not including Root Table entries for current IGC/FGC (read-only)
		38	milliseconds taken by current IGC (read-only)
		39	Number of finalization signals for Weak Objects pending when current IGC/FGC completed (read-only)
		40	BytesPerWord for this image
		41	imageFormatVersion for the VM
		42	number of stack pages in use
		43	desired number of stack pages (stored in image file header, max 65535)
		44	size of eden, in bytes
		45	desired size of eden, in bytes (stored in image file header)
		46	machine code zone size, in bytes (Cog only; otherwise nil)
		47	desired machine code zone size (Cog only; otherwise nil)
		48	various header flags.  See getCogVMFlags.
		49	max size the image promises to grow the external semaphore table to (0 sets to default, which is 256 as of writing)
		50-54 nil; reserved for VM parameters that persist in the image (such as eden above)
		55	ratio of growth and image size at or above which a GC will be performed post scavenge
		56	number of process switches since startup (read-only)
		57	number of ioProcessEvents calls since startup (read-only)
		58	number of ForceInterruptCheck calls since startup (read-only)
		59	number of check event calls since startup (read-only)
		60	number of stack page overflows since startup (read-only)
		61	number of stack page divorces since startup (read-only)
		62	compiled code compactions since startup (read-only; Cog only; otherwise nil)
		63	total milliseconds in compiled code compactions since startup (read-only; Cog only; otherwise nil)
		64	the number of methods that currently have jitted machine-code
		65	whether the VM supports MULTIPLE_BYTECODE_SETS or not.
		66	the byte size of a stack page
		67 - 69 reserved for more Cog-related info
		70	the vmProxyMajorVersion (the interpreterProxy VM_MAJOR_VERSION)
		71	the vmProxyMinorVersion (the interpreterProxy VM_MINOR_VERSION)
	Note: Thanks to Ian Piumarta for this primitive."

	| paramsArraySize result arg index |
	paramsArraySize := 71.
	argumentCount = 0 ifTrue:
		[result := objectMemory instantiateClass: (objectMemory splObj: ClassArray) indexableSize: paramsArraySize.
		objectMemory storePointerUnchecked: 0	ofObject: result withValue: (objectMemory integerObjectOf: objectMemory newSpaceSize).
		objectMemory storePointerUnchecked: 1	ofObject: result withValue: (self positive64BitIntegerFor: objectMemory oldSpaceSize).
		objectMemory storePointerUnchecked: 2	ofObject: result withValue: (self positive64BitIntegerFor: objectMemory totalMemorySize).
		objectMemory storePointerUnchecked: 3	ofObject: result withValue: objectMemory nilObject "was allocationCount".
		objectMemory storePointerUnchecked: 4	ofObject: result withValue: objectMemory nilObject "allocationsBetweenGCs".
		objectMemory storePointerUnchecked: 5	ofObject: result withValue: (objectMemory integerObjectOf: objectMemory tenuringThreshold).
		objectMemory storePointerUnchecked: 6	ofObject: result withValue: (objectMemory integerObjectOf: objectMemory statFullGCs).
		objectMemory storePointerUnchecked: 7	ofObject: result withValue: (objectMemory integerObjectOf: objectMemory statFullGCUsecs + 500 // 1000).
		objectMemory
			storePointerUnchecked: 8
			ofObject: result
			withValue: (objectMemory integerObjectOf: (objectMemory hasSpurMemoryManagerAPI
															ifTrue: [objectMemory statScavenges]
															ifFalse: [objectMemory statIncrGCs])).
		objectMemory
			storePointerUnchecked: 9
			ofObject: result
			withValue: (objectMemory integerObjectOf: (objectMemory hasSpurMemoryManagerAPI
															ifTrue: [objectMemory statScavengeGCUsecs]
															ifFalse: [objectMemory statIncrGCUsecs]) + 500 // 1000).
		objectMemory storePointerUnchecked: 10	ofObject: result withValue: (objectMemory integerObjectOf: objectMemory statTenures).
		"JITTER VM info"
		11 to: 19 do:
			[:i | objectMemory storePointerUnchecked: i ofObject: result withValue: ConstZero].
		objectMemory storePointerUnchecked: 20	ofObject: result withValue: (objectMemory integerObjectOf: objectMemory rootTableCount).
		objectMemory storePointerUnchecked: 21	ofObject: result withValue: (objectMemory integerObjectOf: objectMemory statRootTableOverflows).
		objectMemory storePointerUnchecked: 22	ofObject: result withValue: (objectMemory integerObjectOf: extraVMMemory).
		objectMemory storePointerUnchecked: 23	ofObject: result withValue: (objectMemory integerObjectOf: objectMemory shrinkThreshold).
		objectMemory storePointerUnchecked: 24	ofObject: result withValue: (objectMemory integerObjectOf: objectMemory growHeadroom).
		objectMemory storePointerUnchecked: 25	ofObject: result withValue: (objectMemory integerObjectOf: self ioHeartbeatMilliseconds).
		objectMemory storePointerUnchecked: 26	ofObject: result withValue: (objectMemory integerObjectOf: objectMemory statMarkCount).
		objectMemory storePointerUnchecked: 27	ofObject: result withValue: (objectMemory integerObjectOf: objectMemory statSweepCount).
		objectMemory storePointerUnchecked: 28	ofObject: result withValue: (objectMemory integerObjectOf: objectMemory statMkFwdCount).
		objectMemory storePointerUnchecked: 29	ofObject: result withValue: (objectMemory integerObjectOf: objectMemory statCompMoveCount).
		objectMemory storePointerUnchecked: 30	ofObject: result withValue: (objectMemory integerObjectOf: objectMemory statGrowMemory).
		objectMemory storePointerUnchecked: 31	ofObject: result withValue: (objectMemory integerObjectOf: objectMemory statShrinkMemory).
		objectMemory storePointerUnchecked: 32	ofObject: result withValue: (objectMemory integerObjectOf: objectMemory statRootTableCount).
		objectMemory storePointerUnchecked: 33	ofObject: result withValue: objectMemory nilObject "was statAllocationCount".
		objectMemory storePointerUnchecked: 34	ofObject: result withValue: (objectMemory integerObjectOf: objectMemory statSurvivorCount).
		objectMemory storePointerUnchecked: 35	ofObject: result withValue: (objectMemory integerObjectOf: (self microsecondsToMilliseconds: objectMemory statGCEndUsecs)).
		objectMemory storePointerUnchecked: 36	ofObject: result withValue: (objectMemory integerObjectOf: objectMemory statSpecialMarkCount).
		objectMemory storePointerUnchecked: 37	ofObject: result withValue: (objectMemory integerObjectOf: objectMemory statIGCDeltaUsecs + 500 // 1000).
		objectMemory storePointerUnchecked: 38	ofObject: result withValue: (objectMemory integerObjectOf: statPendingFinalizationSignals).
		objectMemory storePointerUnchecked: 39	ofObject: result withValue: (objectMemory integerObjectOf: BytesPerWord).
		objectMemory storePointerUnchecked: 40	ofObject: result withValue: (objectMemory integerObjectOf: self imageFormatVersion).
		objectMemory storePointerUnchecked: 41	ofObject: result withValue: (objectMemory integerObjectOf: numStackPages).
		objectMemory storePointerUnchecked: 42	ofObject: result withValue: (objectMemory integerObjectOf: desiredNumStackPages).
		objectMemory storePointerUnchecked: 43	ofObject: result withValue: (objectMemory integerObjectOf: objectMemory edenBytes).
		objectMemory storePointerUnchecked: 44	ofObject: result withValue: (objectMemory integerObjectOf: desiredEdenBytes).
		objectMemory storePointerUnchecked: 45	ofObject: result withValue: self getCogCodeSize.
		objectMemory storePointerUnchecked: 46	ofObject: result withValue: self getDesiredCogCodeSize.
		objectMemory storePointerUnchecked: 47	ofObject: result withValue: self getCogVMFlags.
		objectMemory storePointerUnchecked: 48	ofObject: result withValue: (objectMemory integerObjectOf: self ioGetMaxExtSemTableSize).
		objectMemory hasSpurMemoryManagerAPI
			ifTrue:
				[49 to: 52 do:
					[:i | objectMemory storePointerUnchecked: i ofObject: result withValue: objectMemory nilObject].
				 objectMemory
					storePointerUnchecked: 53 ofObject: result withValue: (objectMemory integerObjectOf: objectMemory freeSize);
					storePointer: 54	ofObject: result withValue: (self floatObjectOf: objectMemory getHeapGrowthToSizeGCRatio)]
			ifFalse:
				[49 to: 54 do:
					[:i | objectMemory storePointerUnchecked: i ofObject: result withValue: objectMemory nilObject]].
		objectMemory storePointerUnchecked: 55	ofObject: result withValue: (self positive64BitIntegerFor: statProcessSwitch).
		objectMemory storePointerUnchecked: 56	ofObject: result withValue: (self positive64BitIntegerFor: statIOProcessEvents).
		objectMemory storePointerUnchecked: 57	ofObject: result withValue: (self positive64BitIntegerFor: statForceInterruptCheck).
		objectMemory storePointerUnchecked: 58	ofObject: result withValue: (self positive64BitIntegerFor: statCheckForEvents).
		objectMemory storePointerUnchecked: 59	ofObject: result withValue: (self positive64BitIntegerFor: statStackOverflow).
		objectMemory storePointerUnchecked: 60	ofObject: result withValue: (self positive64BitIntegerFor: statStackPageDivorce).
		objectMemory storePointerUnchecked: 61	ofObject: result withValue: self getCodeCompactionCount.
		objectMemory storePointerUnchecked: 62	ofObject: result withValue: self getCodeCompactionMSecs.
		objectMemory storePointerUnchecked: 63	ofObject: result withValue: self getCogMethodCount.
		objectMemory storePointerUnchecked: 64	ofObject: result withValue: (objectMemory booleanObjectOf: MULTIPLEBYTECODESETS).
		objectMemory storePointerUnchecked: 65	ofObject: result withValue: (objectMemory integerObjectOf: self stackPageByteSize).
		66 to: 68 do: "reserved for more Cog-related info"
			[:i | objectMemory storePointerUnchecked: i ofObject: result withValue: objectMemory nilObject].
		objectMemory
			storePointerUnchecked: 69
			ofObject: result
			withValue: (self integerObjectOf: (self cCode: 'VM_PROXY_MAJOR' inSmalltalk: [self class vmProxyMajorVersion])).
		objectMemory
			storePointerUnchecked: 70
			ofObject: result
			withValue: (self integerObjectOf: (self cCode: 'VM_PROXY_MINOR' inSmalltalk: [self class vmProxyMinorVersion])).
		self assert: paramsArraySize = 71.
		self pop: 1 thenPush: result.
		^nil].

	arg := self stackTop.
	argumentCount = 1 ifTrue:	 "read VM parameter"
		[(objectMemory isIntegerObject: arg) ifFalse:
			[^self primitiveFailFor: PrimErrBadArgument].
		arg := objectMemory integerValueOf: arg.
		(arg < 1 or: [arg > paramsArraySize]) ifTrue: [^self primitiveFailFor: PrimErrBadIndex].
		result := objectMemory nilObject.
		arg = 1		ifTrue: [result := objectMemory integerObjectOf: objectMemory newSpaceSize].
		arg = 2		ifTrue: [result := self positive64BitIntegerFor: objectMemory oldSpaceSize].
		arg = 3		ifTrue: [result := self positive64BitIntegerFor: objectMemory totalMemorySize].
		arg = 4		ifTrue: [result := objectMemory nilObject "was allocationCount"].
		arg = 5		ifTrue: [result := objectMemory nilObject "was allocationsBetweenGCs"].
		arg = 6		ifTrue: [result := objectMemory integerObjectOf: objectMemory tenuringThreshold].
		arg = 7		ifTrue: [result := objectMemory integerObjectOf: objectMemory statFullGCs].
		arg = 8		ifTrue: [result := objectMemory integerObjectOf: objectMemory statFullGCUsecs + 500 // 1000].
		arg = 9		ifTrue: [result := objectMemory integerObjectOf: (objectMemory hasSpurMemoryManagerAPI
																		ifTrue: [objectMemory statScavenges]
																		ifFalse: [objectMemory statIncrGCs])].
		arg = 10	ifTrue: [result := objectMemory integerObjectOf: (objectMemory hasSpurMemoryManagerAPI
																		ifTrue: [objectMemory statScavengeGCUsecs]
																		ifFalse: [objectMemory statIncrGCUsecs]) + 500 // 1000].
		arg = 11	ifTrue: [result := objectMemory integerObjectOf: objectMemory statTenures].
		(arg between: 12 and: 20) ifTrue: [result := ConstZero]. "JITTER VM info"
		arg = 21	ifTrue: [result := objectMemory integerObjectOf: objectMemory rootTableCount].
		arg = 22	ifTrue: [result := objectMemory integerObjectOf: objectMemory statRootTableOverflows].
		arg = 23	ifTrue: [result := objectMemory integerObjectOf: extraVMMemory].
		arg = 24	ifTrue: [result := objectMemory integerObjectOf: objectMemory shrinkThreshold].
		arg = 25	ifTrue: [result := objectMemory integerObjectOf: objectMemory growHeadroom].
		arg = 26	ifTrue: [result := objectMemory integerObjectOf: self ioHeartbeatMilliseconds].
		arg = 27	ifTrue: [result := objectMemory integerObjectOf: objectMemory statMarkCount].
		arg = 28	ifTrue: [result := objectMemory integerObjectOf: objectMemory statSweepCount].
		arg = 29	ifTrue: [result := objectMemory integerObjectOf: objectMemory statMkFwdCount].
		arg = 30	ifTrue: [result := objectMemory integerObjectOf: objectMemory statCompMoveCount].
		arg = 31	ifTrue: [result := objectMemory integerObjectOf: objectMemory statGrowMemory].
		arg = 32	ifTrue: [result := objectMemory integerObjectOf: objectMemory statShrinkMemory].
		arg = 33	ifTrue: [result := objectMemory integerObjectOf: objectMemory statRootTableCount].
		arg = 34	ifTrue: [result := objectMemory nilObject "was statAllocationCount"].
		arg = 35	ifTrue: [result := objectMemory integerObjectOf: objectMemory statSurvivorCount].
		arg = 36	ifTrue: [result := objectMemory integerObjectOf: (self microsecondsToMilliseconds: objectMemory statGCEndUsecs)].
		arg = 37	ifTrue: [result := objectMemory integerObjectOf: objectMemory statSpecialMarkCount].
		arg = 38	ifTrue: [result := objectMemory integerObjectOf: objectMemory statIGCDeltaUsecs + 500 // 1000].
		arg = 39	ifTrue: [result := objectMemory integerObjectOf: statPendingFinalizationSignals].
		arg = 40	ifTrue: [result := objectMemory integerObjectOf: BytesPerWord].
		arg = 41	ifTrue: [result := objectMemory integerObjectOf: self imageFormatVersion].
		arg = 42	ifTrue: [result := objectMemory integerObjectOf: numStackPages].
		arg = 43	ifTrue: [result := objectMemory integerObjectOf: desiredNumStackPages].
		arg = 44	ifTrue: [result := objectMemory integerObjectOf: objectMemory edenBytes].
		arg = 45	ifTrue: [result := objectMemory integerObjectOf: desiredEdenBytes].
		arg = 46	ifTrue: [result := self getCogCodeSize].
		arg = 47	ifTrue: [result := self getDesiredCogCodeSize].
		arg = 48	ifTrue: [result := self getCogVMFlags].
		arg = 49	ifTrue: [result := objectMemory integerObjectOf: self ioGetMaxExtSemTableSize].
		"(arg between: 50 and: 55) ifTrue: [result := objectMemory nilObject]."
		(arg = 54
		 and: [objectMemory hasSpurMemoryManagerAPI]) ifTrue:
			[result := objectMemory integerObjectOf: objectMemory freeSize].
		(arg = 55
		 and: [objectMemory hasSpurMemoryManagerAPI]) ifTrue:
			[result := self floatObjectOf: objectMemory getHeapGrowthToSizeGCRatio].
		arg = 56	ifTrue: [result := self positive64BitIntegerFor: statProcessSwitch].
		arg = 57	ifTrue: [result := self positive64BitIntegerFor: statIOProcessEvents].
		arg = 58	ifTrue: [result := self positive64BitIntegerFor: statForceInterruptCheck].
		arg = 59	ifTrue: [result := self positive64BitIntegerFor: statCheckForEvents].
		arg = 60	ifTrue: [result := self positive64BitIntegerFor: statStackOverflow].
		arg = 61	ifTrue: [result := self positive64BitIntegerFor: statStackPageDivorce].
		arg = 62	ifTrue: [result := self getCodeCompactionCount].
		arg = 63	ifTrue: [result := self getCodeCompactionMSecs].
		arg = 64	ifTrue: [result := self getCogMethodCount].
		arg = 65	ifTrue: [result := objectMemory booleanObjectOf: MULTIPLEBYTECODESETS].
		arg = 66	ifTrue: [result := objectMemory integerObjectOf: self stackPageByteSize].
		"(arg between: 67 and: 69) ifTrue: [result := objectMemory nilObject]." "reserved for more Cog-related info"
		arg = 70 ifTrue: [result := self integerObjectOf: (self cCode: 'VM_PROXY_MAJOR' inSmalltalk: [self class vmProxyMajorVersion])].
		arg = 71 ifTrue: [result := self integerObjectOf: (self cCode: 'VM_PROXY_MINOR' inSmalltalk: [self class vmProxyMinorVersion])].

		self pop: 2 thenPush: result.
		^nil].

	"write a VM parameter"
	argumentCount = 2 ifFalse: [^self primitiveFailFor: PrimErrBadNumArgs].
	index := self stackValue: 1.
	(objectMemory isIntegerObject: index) ifFalse: [^self primitiveFailFor: PrimErrBadArgument].
	index := objectMemory integerValueOf: index.
	(index < 1 or: [index > 63]) ifTrue: [^self primitiveFailFor: PrimErrBadIndex].
	(objectMemory isIntegerObject: arg)
		ifTrue: [arg := objectMemory integerValueOf: arg]
		ifFalse:
			[(index = 55 and: [self isFloatObject: arg]) ifFalse:
				[^self primitiveFailFor: PrimErrBadArgument]].

	"assume failure, then set success for handled indices"
	self success: false.
	index = 5 ifTrue: "Was:
						result := allocationsBetweenGCs.
						allocationsBetweenGCs := arg."
		"Ignore for now, because old images won't start up otherwise.
		 See 44 & 45 for eden size setting."
		[result := objectMemory nilObject.
		self initPrimCall].
	index = 6 ifTrue:
		[result := objectMemory integerObjectOf: objectMemory tenuringThreshold.
		objectMemory tenuringThreshold: arg.
		self initPrimCall].
	index = 23 ifTrue:
		[result := objectMemory integerObjectOf: extraVMMemory.
		extraVMMemory := arg.
		self initPrimCall].
	index = 24 ifTrue:
		[result := objectMemory integerObjectOf: objectMemory shrinkThreshold.
		arg > 0 ifTrue:
			[objectMemory shrinkThreshold: arg.
			self initPrimCall]].
	index = 25 ifTrue:
		[result := objectMemory integerObjectOf: objectMemory growHeadroom.
		arg > 0 ifTrue:
			[objectMemory growHeadroom: arg.
			self initPrimCall]].
	index = 26 ifTrue:
		[arg >= 0 ifTrue:[ "0 turns off the heartbeat"
			result := objectMemory integerObjectOf: self ioHeartbeatMilliseconds.
			self ioSetHeartbeatMilliseconds: arg.
			self initPrimCall]].
	index = 43 ifTrue:
		[(arg >= 0 and: [arg <= 65535]) ifTrue:
			[result := objectMemory integerObjectOf: desiredNumStackPages.
			desiredNumStackPages := arg.
			self initPrimCall]].
	index = 45 ifTrue:
		[(arg >= 0) ifTrue:
			[result := objectMemory integerObjectOf: desiredEdenBytes.
			desiredEdenBytes := arg.
			self initPrimCall]].
	(index = 47 and: [self isCog]) ifTrue:
		[(arg >= 0) ifTrue:
			[result := objectMemory integerObjectOf: self getDesiredCogCodeSize.
			self setDesiredCogCodeSize: arg.
			self initPrimCall]].
	(index = 48 and: [self isCog]) ifTrue:
		[(arg >= 0) ifTrue:
			[result := objectMemory integerObjectOf: self getCogVMFlags.
			self initPrimCall. "i.e. setCogVMFlags: can fail"
			self setCogVMFlags: arg]].
	index = 49 ifTrue:
		[(arg >= 0 and: [arg <= 65535]) ifTrue:
			[result := objectMemory integerObjectOf: self ioGetMaxExtSemTableSize.
			self initPrimCall. "i.e. ioSetMaxExtSemTableSize: is allowed to fail"
			self setMaxExtSemSizeTo: arg]].

	(index = 55
	 and: [objectMemory hasSpurMemoryManagerAPI]) ifTrue:
		[result := self floatObjectOf: objectMemory getHeapGrowthToSizeGCRatio.
		 primFailCode := objectMemory setHeapGrowthToSizeGCRatio: (self floatValueOf: arg)].

	self successful ifTrue:
		[self pop: 3 thenPush: result.  "return old value"
		^nil].

	self primitiveFailFor: PrimErrInappropriate  "attempting to write a read-only or non-existent parameter"