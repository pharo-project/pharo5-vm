memory management
rePluginFree: aPointer
	"Free a block of fixed memory allocated with rePluginMalloc.  Instrumented version of C free() to facilitate leak analysis from Smalltalk.   OS-specific variations on malloc/free, such as with MacOS, are handled by adding a C macro to the header file redefining malloc/free -- see the class comment"

	<inline: true>
	<var: #aPointer type: 'void * '>
	<returnTypeC: 'void'>

	numFrees := numFrees + 1.
	aPointer notNil ifTrue: [self free: aPointer]	