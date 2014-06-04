accessing
memMgr
	^memMgr ifNil:
		[memMgr := Spur32BitCoMemoryManager new]