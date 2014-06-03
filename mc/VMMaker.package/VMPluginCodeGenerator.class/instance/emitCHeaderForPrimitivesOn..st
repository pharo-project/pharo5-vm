C code generator
emitCHeaderForPrimitivesOn: aStream
	"Write a C file header for compiled primitives onto the given stream."

	self emitCHeaderOn: aStream.
	aStream nextPutAll: '
/*** Proxy Functions ***/
#if defined(SQUEAK_BUILTIN_PLUGIN)
extern sqInt stackValue(sqInt offset);
extern sqInt stackIntegerValue(sqInt offset);
extern sqInt failed(void);
# define successFlag (!failed())
extern sqInt success(sqInt aBoolean);
extern void * arrayValueOf(sqInt oop);
extern void * fetchArrayofObject(sqInt fieldIndex, sqInt objectPointer);
extern double fetchFloatofObject(sqInt fieldIndex, sqInt objectPointer);
extern sqInt fetchIntegerofObject(sqInt fieldIndex, sqInt objectPointer);
extern double floatValueOf(sqInt oop);
extern sqInt pop(sqInt nItems);
extern sqInt pushInteger(sqInt integerValue);
extern sqInt sizeOfSTArrayFromCPrimitive(void *cPtr);
extern sqInt storeIntegerofObjectwithValue(sqInt index, sqInt oop, sqInt integer);
extern sqInt primitiveFail(void);
#else /* SQUEAK_BUILTIN_PLUGIN */
# define stackValue(i) (interpreterProxy->stackValue(i))
# define stackIntegerValue(i) (interpreterProxy->stackIntegerValue(i))
# define successFlag (!interpreterProxy->failed())
# define success(bool) (interpreterProxy->success(bool))
# define arrayValueOf(oop) (interpreterProxy->arrayValueOf(oop))
# define fetchArrayofObject(idx,oop) (interpreterProxy->fetchArrayofObject(idx,oop))
# define fetchFloatofObject(idx,oop) (interpreterProxy->fetchFloatofObject(idx,oop))
# define fetchIntegerofObject(idx,oop) (interpreterProxy->fetchIntegerofObject(idx,oop))
# define floatValueOf(oop) (interpreterProxy->floatValueOf(oop))
# define pop(n) (interpreterProxy->pop(n))
# define pushInteger(n) (interpreterProxy->pushInteger(n))
# define sizeOfSTArrayFromCPrimitive(cPtr) (interpreterProxy->sizeOfSTArrayFromCPrimitive(cPtr))
# define storeIntegerofObjectwithValue(idx,oop,value) (interpreterProxy->storeIntegerofObjectwithValue(idx,oop,value))
# define primitiveFail() interpreterProxy->primitiveFail()
#endif /* SQUEAK_BUILTIN_PLUGIN */

/* allows accessing Strings in both C and Smalltalk */
#define asciiValue(c) c


'