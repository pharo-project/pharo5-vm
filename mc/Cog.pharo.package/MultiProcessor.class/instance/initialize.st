initialize-release
initialize
	registerState := WeakIdentityKeyDictionary new.
	mutex := Mutex new.
	threadIndex := 0.
	guardedProcessorProtocol := unguardedProcessorProtocol := Set new