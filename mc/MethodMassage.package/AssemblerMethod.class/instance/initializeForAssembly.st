initialize-release
initializeForAssembly
	fixLabels := false.
	compiledMethodClass := CompiledMethod.
	instructions := OrderedCollection new.
	literals := OrderedCollection new.
	frameSize := thisContext method frameSize. "should be small"
	flag := signFlag := false.
	primitive := 0