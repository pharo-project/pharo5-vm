internal interpreter access
stackPointerIndexFor: sp context: ctxt
	"Return the 0-based index rel to the current context.
	(This is what stackPointer used to be before conversion to pointer"
	<api>
	<inline: true>
	^ (sp - ctxt - BaseHeaderSize) >> ShiftForWord