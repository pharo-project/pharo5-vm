C code generator
preDeclareMacrosForFastClassCheckingOn: aStream
	"These macros can be used to check for various cases of Integer types.
	 Since they can be defined based on existing API, this is a good trade off:
	 - avoid extending the interpreterProxy API unnecessarily
	 - provide fast type checking"
	
	"Speed-up generated code for internal plugins by using macros and fixed class indices to define this well known functionality."
	#(	'#if defined(SQUEAK_BUILTIN_PLUGIN)' cr

		'# define isIntegerObject(oop) ((oop) & 1)' cr

		'# if SPURVM'
		'extern sqInt classIndexOf(sqInt);'
	"Compact class indices are hardcoded here because there is no guarantee that the pool values at generation time
	 are that of SPUR.. Make sure they are in sync with SpurMemoryManager class>>initializeCompactClassIndices"
		'#	define LargeNegativeIntegerClassIndex 32'
		'#	define LargePositiveIntegerClassIndex 33'
		'#	if BytesPerOop == 4'
		'#	  define isImmediate(oop) ((oop) & 3)'
		'#	else'
		'#	  define isImmediate(oop) ((oop) & 7)'
		'#	endif'
		'#	define isKindOfInteger(oop) (isImmediate(oop) ? isIntegerObject(oop) : (unsigned)(classIndexOf(oop) - LargeNegativeIntegerClassIndex) <= 1)'
		'#	define isLargeIntegerObject(oop) (!isImmediate(oop) && (unsigned)(classIndexOf(oop) - LargeNegativeIntegerClassIndex) <= 1)'
		'#	define isLargeNegativeIntegerObject(oop) (!isImmediate(oop) && classIndexOf(oop) == LargeNegativeIntegerClassIndex)'
		'#	define isLargePositiveIntegerObject(oop) (!isImmediate(oop) && classIndexOf(oop) == LargePositiveIntegerClassIndex)'
		'# endif /* SPURVM */'
		'#endif /* defined(SQUEAK_BUILTIN_PLUGIN) */' cr

	"If the functionality has not been defined via macros, define default versions using existing plugin API"
		'#if !defined(isKindOfInteger)'
		'# define isLargeNegativeIntegerObject(oop) (fetchClassOf(oop) == classLargeNegativeInteger())'
		'# define isLargePositiveIntegerObject(oop) (fetchClassOf(oop) == classLargePositiveInteger())'
		'# define isLargeIntegerObject(oop) (isLargeNegativeIntegerObject(oop) || isLargePositiveIntegerObject(oop))'
		'# define isKindOfInteger(oop) (isIntegerObject(oop) || isLargeNegativeIntegerObject(oop) || isLargePositiveIntegerObject(oop))'
		'#endif' cr) do:
		[:element|
		aStream cr.
		element ~~ #cr ifTrue: [aStream nextPutAll: element]]