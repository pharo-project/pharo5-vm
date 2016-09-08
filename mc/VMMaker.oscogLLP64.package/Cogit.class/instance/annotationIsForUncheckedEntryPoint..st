in-line cacheing
annotationIsForUncheckedEntryPoint: annotation
	<inline: true>
	^annotation = IsSuperSend
	  or: [BytecodeSetHasDirectedSuperSend and: [annotation = IsDirectedSuperSend]]