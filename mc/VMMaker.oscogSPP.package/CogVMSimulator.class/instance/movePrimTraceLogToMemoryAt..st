initialization
movePrimTraceLogToMemoryAt: address
	| oldTraceLog |
	oldTraceLog := primTraceLog.
	primTraceLog := CArrayOfLongsAccessor new
						objectMemory: objectMemory at: address.
	self assert: address = self primTraceLogAddress.
	0 to: PrimTraceLogSize - 1 do:
		[:i|
		self assert: (primTraceLog at: i) = 0].
	primTraceLog at: 0 put: 16rC4EC4.
	self assert: (objectMemory longAt: address) = 16rC4EC4.
	0 to: PrimTraceLogSize - 1 do:
		[:i|
		primTraceLog at: i put: (oldTraceLog at: i)]