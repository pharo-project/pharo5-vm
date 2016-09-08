initialization
initialize
	<doNotGenerate>
	"Initialize ObjectMemory when simulating the VM inside Smalltalk."
	super initialize.
	headerTypeBytes := CArrayAccessor on: HeaderTypeExtraBytes.
	rootTable := Array new: RootTableSize.
	weakRoots := Array new: WeakRootTableSize.
	remapBuffer := Array new: RemapBufferSize