in-line cacheing
isSuperSend: entryPoint
	<inline: true>
	^(entryPoint bitAnd: entryPointMask) ~= checkedEntryAlignment