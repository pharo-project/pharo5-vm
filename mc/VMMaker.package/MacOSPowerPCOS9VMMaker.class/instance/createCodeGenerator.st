initialize
createCodeGenerator
	"Set up a CCodeGenerator for this VMMaker - Mac OS uses the global struct and local def of the
	 structure.  The global struct/loca def regime appears to be about 10% faster than the default
	 regime for Smalltalk-intensive macro benchmarks for both the Intel and gcc 4.0 compiler on x86.
	 eem 12/10/2008 14:34 2.16 GHz Intel Core Duo MacBook Pro Mac OS X 10.4.11"
	^CCodeGeneratorGlobalStructure new
		vmMaker: self;
		structDefDefine: '1';
		"structDefDefine: 'defined(PPC) || defined(_POWER) || defined(__powerpc__) || defined(__ppc__)';"
		logger: logger;
		yourself