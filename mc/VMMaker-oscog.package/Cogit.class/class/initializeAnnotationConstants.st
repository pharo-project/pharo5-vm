class initialization
initializeAnnotationConstants
	"These form the method map for a cog method.  Each annotated instruction has a
	 byte in the map, and each byte in the map has two parts.  In the least signficant
	 bits are a byte distance from the start of the method or previous map entry.  In
	 the most signficant bits are the type of annotation at the point reached.  A null
	 byte ends the map.

	 The map occurs at the end of a method (*), in reverse, so that its start is found
	 by adding the method's block size.  If the distance between two mapped
	 instructions will not fit in the displacement field then one or more displacement
	 entries are placed in the map to bridge the gap.  There are either unit displacement
	 bytes or * 32 displacement bytes. (* if methods have performance counters then
	 the map preceedes the counters and so one finds the map by adding the block
	 size and subtracting numCounters * sizeof(counter)).

	 There is only one kind of call annotation that serves for all calls from machine
	 code. There are four kinds of call, sends, super sends, calls of the generated
	 run-time, and direct calls of primitive functions in the interpreter.  These need
	 different treatment at different times.  For example, when the send cache is
	 flushed or the method zone is shrunk some sends must be unlinked and some
	 sends must be relocated.

	 Sends can be distinguished from run-time or direct primitive calls based on
	 address; only sends have their target between methodZoneBase and methodZone
	 freeStart.  Further, normal sends can be distinguished from super sends because
	 normal sends link to the checked entry-point, whereas super sends link to the
	 unchecked entry-point, and both entry points have different alignment.
	 But to be able to parse bytecoded methods and match their pcs with corresponding
	 machine code pcs the map needs to differentiate between sends and run-time calls. 

	 While run-time calls can be distinguished from direct primitive calls on the basis
	 of address there is no need to do so.  They are merely calls to locations that
	 don't move during method zone compaction.

	 Absolute PC references are used for method references and counter references.
	 These are references from withi a particular method to absolute pcs in that same
	 method that must be relocated when the method moves."
	"self initializeAnnotationConstants"
	IsSendCall := 7.
	IsRelativeCall := 6.
	HasBytecodePC := 5.
	IsAbsPCReference := 4.
	IsObjectReference := 3.
	IsNSSendCall := NewspeakVM ifTrue: [2].
	IsDisplacementX2N := 1.
	IsDisplacement := 0.
	AnnotationShift := 5.

	DisplacementMask := (1 << AnnotationShift) - 1.
	DisplacementX2N := IsDisplacementX2N << AnnotationShift.
	FirstAnnotation := IsDisplacementX2N + 1 << AnnotationShift.
	MaxUnitDisplacement := DisplacementMask.
	MaxX2NDisplacement := DisplacementMask << AnnotationShift.

	MapEnd := 0.

	AnnotationConstantNames := NewspeakVM
									ifTrue:
										[#(	IsDisplacement IsDisplacementX2N
											IsNSSendCall
											IsObjectReference
											IsAbsPCReference
											HasBytecodePC
											IsRelativeCall
											IsSendCall)]
									ifFalse:
										[#(	IsDisplacement IsDisplacementX2N unused
											IsObjectReference
											IsAbsPCReference
											HasBytecodePC
											IsRelativeCall
											IsSendCall)]