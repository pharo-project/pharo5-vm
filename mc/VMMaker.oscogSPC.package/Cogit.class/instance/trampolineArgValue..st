initialization
trampolineArgValue: n
	"Decode true and false and 0 to N to their C equivalents from the encoding by trampolineArgConstant:"
	<inline: true>
	^-2 - n