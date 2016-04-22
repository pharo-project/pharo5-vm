C code generator
preDeclareMacrosForFastClassCheckingOn: aStream
	"These macros can be used to check for various case of Integer type.
	Since they can be defined based on existing API, this is a good trade off:
	- avoid extending the interpreterProxy API like mad
	- provide fast type checking"
	
	"Fast-up generated code by using a macro for this well known function unconditionnally"
	#(	'#define isIntegerObject(oop) (oop & 1)' cr
		'#if SPURVM && defined(SQUEAK_BUILTIN_PLUGIN)'

		"Compact class index are hardcoded because there is no guarantee that the pool values at generation time are that of SPUR..
		 Make sure they are in sync with SpurMemoryManager class>>initializeCompactClassIndices"
		'extern sqInt classIndexOf(sqInt);'
		'# define LargeNegativeIntegerClassIndex 32'
		'# define LargePositiveIntegerClassIndex 33'
		'# define isKindOfInteger(oop) (isImmediate(oop) ? isIntegerObject(oop) : (unsigned)(classIndexOf(oop) - LargeNegativeIntegerClassIndex) <= 1)'
		'# define isLargeIntegerObject(oop) (!isImmediate(oop) && (unsigned)(classIndexOf(oop) - LargeNegativeIntegerClassIndex) <= 1)'
		'# define isLargeNegativeIntegerObject(oop) (!isImmediate(oop) && classIndexOf(oop) == LargeNegativeIntegerClassIndex)'
		'# define isLargePositiveIntegerObject(oop) (!isImmediate(oop) && classIndexOf(oop) == LargePositiveIntegerClassIndex)'

		'#else /* defined(SQUEAK_BUILTIN_PLUGIN) && defined(SPURVM) */'

		'# define isLargeNegativeIntegerObject(oop) (fetchClassOf(oop) == classLargeNegativeInteger())'
		'# define isLargePositiveIntegerObject(oop) (fetchClassOf(oop) == classLargePositiveInteger())'
		'# define isLargeIntegerObject(oop) (isLargeNegativeIntegerObject(oop) || isLargePositiveIntegerObject(oop))'
		'# define isKindOfInteger(oop) (isIntegerObject(oop) || isLargeNegativeIntegerObject(oop) || isLargePositiveIntegerObject(oop))'

		'#endif /* defined(SQUEAK_BUILTIN_PLUGIN) && defined(SPURVM) */' cr) do:
		[:element|
		aStream cr.
		element ~~ #cr ifTrue: [aStream cr; nextPutAll: element]]