initialization
initializeClassIndices
	"Class Class"
	SuperclassIndex := 0.
	MethodDictionaryIndex := 1.
	InstanceSpecificationIndex := 2.
	"Fields of a message dictionary"
	MethodArrayIndex := 1. 
	SelectorStart := 2.

	"Newspeak extensions"
	"Fields of a Mixin (also defined by Behavior)"
	EnclosingMixinIndex := NewspeakVM ifTrue: [3].  "(Class instVarIndexFor: 'mixinSlot') - 1"
	"Fields of a MixinApplication (also defined by Behavior)"
	MixinIndex := NewspeakVM ifTrue: [3]. "(Class instVarIndexFor: 'mixinSlot') - 1"
	EnclosingObjectIndex := NewspeakVM ifTrue: [4]. "(Class instVarIndexFor: 'enclosingObjectSlot') - 1"

