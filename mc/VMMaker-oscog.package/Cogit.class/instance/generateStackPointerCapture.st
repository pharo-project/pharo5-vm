initialization
generateStackPointerCapture
	"Generate a routine ceCaptureCStackPointers that will capture the C stack pointer,
	 and, if it is in use, the C frame pointer.  These are used in trampolines to call
	 run-time routines in the interpreter from machine-code."

	| oldMethodZoneBase oldTrampolineTableIndex |
	self assertCStackWellAligned.
	oldMethodZoneBase := methodZoneBase.
	oldTrampolineTableIndex := trampolineTableIndex.
	self generateCaptureCStackPointers: true.
	self perform: #ceCaptureCStackPointers.
	(cFramePointerInUse := self isCFramePointerInUse) ifFalse:
		[methodZoneBase := oldMethodZoneBase.
		 trampolineTableIndex := oldTrampolineTableIndex.
		 self generateCaptureCStackPointers: false]