initialization
initializeCompactClassIndices
	"Initialize indices for compact classes we are going to depend on being compact.
	 The VI allows classes to become compact and become uncompact.  For efficiency
	 the VM assumes certain classes are compact with particular indices."

	"Smalltalk compactClassesArray"
	"{Array. LargePositiveInteger. Float. MethodContext. } collect: [:c| c -> c indexIfCompact]"

	ClassArrayCompactIndex := 3.
	ClassLargeNegativeIntegerCompactIndex := 4. "Was PseudoContext class"
	ClassLargePositiveIntegerCompactIndex := 5.
	ClassFloatCompactIndex := 6.
	ClassBlockClosureCompactIndex := 0 "12". "Prospective.  May still be TranslatedMethod class"
	ClassByteStringCompactIndex := 11.
	ClassBlockContextCompactIndex := 13.
	ClassMethodContextCompactIndex := 14.

	ClassByteArrayCompactIndex := 0.
	ClassMessageCompactIndex := 0.
	ClassBitmapCompactIndex := 0