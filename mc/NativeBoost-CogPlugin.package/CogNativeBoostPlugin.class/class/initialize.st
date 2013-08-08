as yet unclassified
initialize
	" self initialize"
	
	"will fail if your image does not supports native code trailers!!"
	NativeCodeTrailerId := 	(CompiledMethodTrailer new nativeCode: #() platformId: 0 sourcePointer: 0) kindAsByte.
