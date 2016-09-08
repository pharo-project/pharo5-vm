object memory support
mapProfileState
	(objectMemory shouldRemapObj: profileProcess) ifTrue:
		[profileProcess := objectMemory remapObj: profileProcess].
	(objectMemory shouldRemapObj: profileMethod) ifTrue:
		[profileMethod := objectMemory remapObj: profileMethod].
	(objectMemory shouldRemapObj: profileSemaphore) ifTrue:
		[profileSemaphore := objectMemory remapObj: profileSemaphore].
	"The longRunningPrimitiveCheckMethod (LRPCM) is sampled in an interrupt.  Be very careful with it.
	  If longRunningPrimitiveCheckSequenceNumber (LRPCSN) = statCheckForEvents then LRPCM has
	  been recenty sampled and could be mapped or not, but it must be newMethod and we can simply
	  copy newMethod.  If LRPCSN ~= statCheckForEvents then LRPCM must be some extant object and
	  needs to be remapped."
	self sqLowLevelMFence.
	longRunningPrimitiveCheckMethod ifNotNil:
		[longRunningPrimitiveCheckSequenceNumber = statCheckForEvents
			ifTrue: [longRunningPrimitiveCheckMethod := newMethod]
			ifFalse:
				[(objectMemory shouldRemapObj: longRunningPrimitiveCheckMethod) ifTrue:
					[longRunningPrimitiveCheckMethod := self remapObj: longRunningPrimitiveCheckMethod]].
		 self sqLowLevelMFence].
	longRunningPrimitiveCheckSemaphore ifNotNil:
		[(objectMemory shouldRemapObj: longRunningPrimitiveCheckSemaphore) ifTrue:
			[longRunningPrimitiveCheckSemaphore := objectMemory remapObj: longRunningPrimitiveCheckSemaphore]]