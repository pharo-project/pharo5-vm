message sending
handleSpecialSelectorSendFaultFor: obj
	<inline: true>
	<option: #SpurObjectMemory>
	^self handleSpecialSelectorSendFaultFor: obj fp: localFP sp: localSP