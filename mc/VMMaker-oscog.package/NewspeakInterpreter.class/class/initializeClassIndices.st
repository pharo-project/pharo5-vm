initialization
initializeClassIndices
	"Behavior"
	SuperclassIndex := 0.
	MessageDictionaryIndex := 1.
	InstanceSpecificationIndex := 2.

	"Fields of a Mixin (also defined by Behavior)"
	EnclosingMixinIndex := 3.  "(Class instVarIndexFor: 'mixinSlot') - 1"
	"Fields of a MixinApplication (also defined by Behavior)"
	MixinIndex := 3. "(Class instVarIndexFor: 'mixinSlot') - 1"
	MixinNameIndex := 8.  "(Class instVarIndexFor: 'name') - 1"
	EnclosingObjectIndex := 4. "(Class instVarIndexFor: 'enclosingObjectSlot') - 1"

	"Fields of a message dictionary"
	MethodArrayIndex := 1.
	SelectorStart := 2