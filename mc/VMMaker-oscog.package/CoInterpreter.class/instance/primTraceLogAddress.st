cog jit support
primTraceLogAddress
	<api>
	<returnTypeC: #'void *'>
	^self cCode: [primTraceLog] inSmalltalk: [primTraceLog offset * BytesPerWord]