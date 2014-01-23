object memory support
mapProfileState
	profileProcess := objectMemory remap: profileProcess.
	profileMethod := objectMemory remap: profileMethod.
	profileSemaphore := objectMemory remap: profileSemaphore.
	"The longRunningPrimitiveCheckMethod (LRPCM) is sampled in an interrupt.  Be very careful with it.
	  If longRunningPrimitiveCheckSequenceNumber (LRPCSN) = statCheckForEvents then LRPCM has
	  been recenty sampled and could be mapped or not, but it must be newMethod and we can simply
	  copy newMethod.  If LRPCSN ~= statCheckForEvents then LRPCM must be some extant object and
	  needs to be remapped."
	self sqLowLevelMFence.
	longRunningPrimitiveCheckMethod ~= nil ifTrue:
		[longRunningPrimitiveCheckMethod :=
			longRunningPrimitiveCheckSequenceNumber = statCheckForEvents
				ifTrue: [newMethod]
				ifFalse: [self remap: longRunningPrimitiveCheckMethod].
		 self sqLowLevelMFence].
	longRunningPrimitiveCheckSemaphore ~= nil ifTrue:
		[longRunningPrimitiveCheckSemaphore := objectMemory remap: longRunningPrimitiveCheckSemaphore]