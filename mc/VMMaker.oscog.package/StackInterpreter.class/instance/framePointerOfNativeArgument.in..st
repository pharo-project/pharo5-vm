internal interpreter access
framePointerOfNativeArgument: offset in: theFP
	<inline: false>
	<option: #LowcodeVM>
	<returnTypeC: 'char*'>
	<var: #theFP type: #'char*'>
	^ (self nativePreviousStackPointerIn: theFP) + offset - 1