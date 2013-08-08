stack bytecodes
ceExplicitReceiverAt: level
	<api>
	<option: #NewspeakVM>
	^self 
		explicitOuterReceiver: level
		withObject: (self mframeReceiver: framePointer)
		withMixin: self mMethodClass