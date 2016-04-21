C code generator
preDeclareMacrosForFastClassChekingOn: aStream
	"These macros can be used to check for various case of Integer type.
	Since they can be defined based on existing API, this is a good trade off:
	- avoid extending the interpreterProxy API like mad
	- provide fast type checking"
	
	"Fast-up generated code by using a macro for this well known function unconditionnally"
	aStream cr; nextPutAll: '#define isIntegerObject(oop) (oop & 1)'; cr. 
	
	aStream cr; nextPutAll: '#if SPURVM && defined(SQUEAK_BUILTIN_PLUGIN)'.
	
	"Compact class index are hardcoded because there is no guaranty that the pool values at generation time are that of SPUR..
	 Make sure they are in sync with SpurMemoryManager class>>initializeCompactClassIndices"
	aStream cr; nextPutAll: '# define LargeNegativeIntegerClassIndex 32'.
	aStream cr; nextPutAll: '# define LargePositiveIntegerClassIndex 33'.
	aStream cr; nextPutAll: 'extern sqInt classIndexOf(sqInt);'.
	aStream cr; nextPutAll: '# define isKindOfInteger(oop) (isImmediate(oop) ? isIntegerObject(oop) : (unsigned)(classIndexOf(oop) - LargeNegativeIntegerClassIndex) <= 1)'.
	aStream cr; nextPutAll: '# define isLargeIntegerObject(oop) (!isImmediate(oop) && (unsigned)(classIndexOf(oop) - LargeNegativeIntegerClassIndex) <= 1)'.
	aStream cr; nextPutAll: '# define isLargeNegativeIntegerObject(oop) (!isImmediate(oop) && classIndexOf(oop) == LargeNegativeIntegerClassIndex)'.
	aStream cr; nextPutAll: '# define isLargePositiveIntegerObject(oop) (!isImmediate(oop) && classIndexOf(oop) == LargePositiveIntegerClassIndex)'.
	
	aStream cr; nextPutAll: '#else /* defined(SQUEAK_BUILTIN_PLUGIN) && defined(SPURVM) */'.
	
	aStream cr; nextPutAll: '# define isLargeNegativeIntegerObject(oop) (fetchClassOf(oop) == classLargeNegativeInteger())'.
	aStream cr; nextPutAll: '# define isLargePositiveIntegerObject(oop) (fetchClassOf(oop) == classLargePositiveInteger())'.
	aStream cr; nextPutAll: '# define isLargeIntegerObject(oop) (isLargeNegativeIntegerObject(oop) || isLargePositiveIntegerObject(oop))'.
	aStream cr; nextPutAll: '# define isKindOfInteger(oop) (isIntegerObject(oop) || isLargeNegativeIntegerObject(oop) || isLargePositiveIntegerObject(oop))'.

	aStream cr; nextPutAll: '#endif /* defined(SQUEAK_BUILTIN_PLUGIN) && defined(SPURVM) */'; cr
	