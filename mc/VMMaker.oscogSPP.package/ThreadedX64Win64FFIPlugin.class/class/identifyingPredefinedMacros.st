translation
identifyingPredefinedMacros
	"Answer the predefined macros that identify the platforms a subclass handles, if any.
	 If the subclass isn't yet ready for production (a work in progress) simply answer nil."
	^#('x86_64' '__amd64' '__x86_64' '__amd64__' '__x86_64__' '_M_AMD64' '_M_X64')