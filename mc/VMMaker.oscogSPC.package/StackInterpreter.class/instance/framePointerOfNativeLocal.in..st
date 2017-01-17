internal interpreter access
framePointerOfNativeLocal: offset in: theFP
	<inline: false>
	<option: #LowcodeVM>
	<returnTypeC: 'char*'>
	<var: #theFP type: #'char*'>
	^ (self nativeFramePointerIn: theFP) + offset - 1