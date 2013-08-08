initialization
movePrimTraceLogToMemoryAt: address
	| oldTraceLog |
	oldTraceLog := primTraceLog.
	self flag: 'broken for 64-bit VM because Bitmap access unit is 32-bits'.
	primTraceLog := CObjectAccessor new
						memory: objectMemory memory
						offset: address / BytesPerWord.
	0 to: PrimTraceLogSize - 1 do:
		[:i|
		self assert: (primTraceLog at: i) = 0].
	primTraceLog at: 0 put: 16rC4EC4.
	self assert: (self longAt: address) = 16rC4EC4.
	0 to: PrimTraceLogSize - 1 do:
		[:i|
		primTraceLog at: i put: (oldTraceLog at: i)]