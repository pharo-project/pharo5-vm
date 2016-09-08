public
storeCodeOnFile: fileName doInlining: inlineFlag
	"Store C code for this code base on the given file."

	self storeCodeOnFile: fileName doInlining: inlineFlag doAssertions: true