accessing
alignedByteSizeOf: aCObjectAccessor forClient: aVMClass
	"Hack; this only works if the object is actually bytes."
	^aCObjectAccessor object size