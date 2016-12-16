primitive support
maybeDisownVM: calloutState threadIndexInto: aBlock
	<var: #calloutState type: #'CalloutState *'>
	<inline: #always>
	self cppIf: COGMTVM
		ifTrue:
			[(calloutState callFlags anyMask: FFICallFlagThreaded) ifTrue:
				[aBlock value: (interpreterProxy disownVM: 0)]]