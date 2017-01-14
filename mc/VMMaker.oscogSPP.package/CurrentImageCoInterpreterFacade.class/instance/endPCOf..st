accessing
endPCOf: methodOop
	^(objectMap keyAtValue: methodOop) endPC - 1