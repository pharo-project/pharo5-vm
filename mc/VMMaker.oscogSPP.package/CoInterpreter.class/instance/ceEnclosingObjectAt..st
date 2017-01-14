stack bytecodes
ceEnclosingObjectAt: level
	<api>
	<option: #NewspeakVM>
	^self 
		enclosingObjectAt: level
		withObject: (self mframeReceiver: framePointer)
		withMixin: self mMethodClass