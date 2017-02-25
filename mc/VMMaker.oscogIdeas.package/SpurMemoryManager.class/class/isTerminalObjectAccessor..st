translation
isTerminalObjectAccessor: selector
	"For accessor depth calculation, answer if selector doesn't answer another object object; merely a value."
	^#(byteSizeOf: fetchFloat:ofObject: fetchInteger:ofObject: fetchLong32:ofObject: instanceSizeOf: slotSizeOf: stSizeOf:) includes: selector