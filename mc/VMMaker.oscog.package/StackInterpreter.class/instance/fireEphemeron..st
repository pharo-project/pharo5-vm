finalization
fireEphemeron: ephemeron
	<option: #SpurObjectMemory>
	objectMemory queueMourner: ephemeron..
	self setFormatOf: ephemeron to: self nonIndexablePointerFormat.
	self signalFinalization: ephemeron