memory management
rePluginMalloc: anInteger
	"Allocate a block of fixed memory using C calls to malloc().  Instrumented to facilitate leak analysis from Smalltalk.  Set global lastAlloc to anInteger.  OS-specific variations on malloc/free, such as with MacOS, are handled by adding a C macro to the header file redefining malloc/free -- see the class comment"

	| aPointer |
	<inline: true>
	<var: #anInteger type: 'size_t '>
	<var: #aPointer type: 'void *'>
	<returnTypeC: 'void *'>
	numAllocs := numAllocs + 1.
	(aPointer := self malloc: anInteger) notNil ifTrue:
		[lastAlloc := anInteger].
	^aPointer
