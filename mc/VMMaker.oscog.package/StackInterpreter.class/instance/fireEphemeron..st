finalization
fireEphemeron: ephemeron
	<option: #SpurObjectMemory>
	objectMemory
		queueMourner: ephemeron;
		setFormatOf: ephemeron to: objectMemory nonIndexablePointerFormat.
	self signalFinalization: ephemeron