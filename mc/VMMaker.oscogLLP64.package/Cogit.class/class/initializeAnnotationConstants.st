class initialization
initializeAnnotationConstants
	"These form the method map for a cog method.  The map defines which addresses
	 in a machine code method are ones with important functions, such as being a send
	 site or being a reference to a heap object.  Each annotated instruction has a byte
	 in the map, and each byte in the map has two parts.  In the least signficant bits are
	 a distance in codeGranularity units from the start of the method or the previous
	 map entry, except for the IsAnnotationExtension type.  In the most signficant bits
	 are the type of annotation at the point reached.  A null byte ends the map.  The
	 first mapped location is a distance from the cmNoCheckEntryOffset.

	 The map occurs at the end of a method (*), in reverse, so that its start is found
	 by adding the method's block size.  If the distance between two mapped
	 instructions will not fit in the displacement field then one or more displacement
	 entries are placed in the map to bridge the gap.  There is a * 32 displacement
	 units type for spanning large gaps.  The displacements are in codeGranularity
	 units so that processors like e.g. ARM, with 4-byte instructions, do not have overly
	 large maps.  In [practice maps are very compact, but they should be as quick to
	 navigate as possible, and hence be as compact as possible.

	 There is only one kind of call annotation that serves for all calls from machine
	 code. There are several kinds of call, sends, super sends, calls of the generated
	 run-time, and direct calls of primitive functions in the interpreter.  These need
	 different treatment at different times.  For example, when the send cache is
	 flushed or the method zone is shrunk some sends must be unlinked and some
	 sends must be relocated.  But to be able to parse bytecoded methods and match
	 their pcs with corresponding machine code pcs the map needs to differentiate
	 between sends and run-time calls. 

	 Sends can be distinguished from run-time or direct primitive calls based on address;
	 only sends have their target between methodZoneBase and methodZone freeStart.
	 We used to distinguish normal sends from super sends based on alignment of
	 entry-point, because normal sends link to the checked entry-point, whereas super sends
	 link to the unchecked entry-point, and both entry points have different alignments.
	 But now we use the IsAnnotationExtension to label sends other than normal sends.
	 For these ``exotic'' sends there is both an IsAnnotationExtension annotation and an
	 IsSendCall annotation.

	 While run-time calls can be distinguished from direct primitive calls on the basis
	 of address there is no need to do so.  They are merely calls to locations that
	 don't move during method zone compaction.

	 Absolute PC references are used for method references and counter references.
	 These are references from within a particular method to absolute pcs in that same
	 method that must be relocated when the method moves."
	"self initializeAnnotationConstants"

	AnnotationShift := 5.
	IsDisplacementX2N := 0.	"N.B. A 0 byte ends the map"
	IsAnnotationExtension := 1.	"Used to extend IsSendCall with different codes for exotic send types."
	IsObjectReference := 2.
	IsAbsPCReference := 3.
	IsRelativeCall := 4.
	HasBytecodePC := 5.
	IsNSSendCall := NewspeakVM ifTrue: [6].
	IsSendCall := 7.
	"These are formed by combining IsSendCall and IsAnnotationExtension annotations."
	IsSuperSend := 8.
	IsDirectedSuperSend := 9.
	IsNSSelfSend := NewspeakVM ifTrue: [10].
	IsNSDynamicSuperSend := NewspeakVM ifTrue: [11].
	IsNSImplicitReceiverSend := NewspeakVM ifTrue: [12].

	DisplacementMask := (1 << AnnotationShift) - 1.
	DisplacementX2N := IsDisplacementX2N << AnnotationShift.
	FirstAnnotation := IsObjectReference << AnnotationShift.
	MaxX2NDisplacement := DisplacementMask << AnnotationShift.

	MapEnd := 0.

	AnnotationConstantNames := #(	IsDisplacementX2N
										IsAnnotationExtension
										IsObjectReference
										IsAbsPCReference
										IsRelativeCall
										HasBytecodePC
										IsNSSendCall
										IsSendCall
										IsSuperSend
										IsDirectedSuperSend
										IsNSSelfSend
										IsNSDynamicSuperSend
										IsNSImplicitReceiverSend).
	AnnotationsWithBytecodePCs := #(HasBytecodePC
										IsNSSendCall
										IsSendCall
										IsSuperSend
										IsDirectedSuperSend
										IsNSSelfSend
										IsNSDynamicSuperSend
										IsNSImplicitReceiverSend),
										{'IsRelativeCall:\HasBytecodePC' withCRs}