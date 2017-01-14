initialization
maybeGenerateSelectorIndexDereferenceRoutine
	"If required, generate the routine that converts selector indices into selector objects.
	 If it exists, it is called from the send trampolines.
	 If the selector index is negative, convert it into a positive index into the
	 special selectors array and index that.  Otherwise, index the current method.
	 This is only required on 64-bit platforms."