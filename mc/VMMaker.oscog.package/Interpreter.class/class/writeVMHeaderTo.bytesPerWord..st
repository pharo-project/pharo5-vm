translation
writeVMHeaderTo: aStream bytesPerWord: bytesPerWord
	"Currently the Interpreter adds nothing to interp.h above and beyond VMClass's default.
	 But the code in trunk's CCodeGenerator>>emitDefineBytesPerWordOn: is a candidate."
	super writeVMHeaderTo: aStream bytesPerWord: bytesPerWord