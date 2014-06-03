primitives
primitiveDropRequestFileName
	"Note: File handle creation needs to be handled by specific support code explicitly bypassing the plugin file sand box."
	| dropIndex dropName nameLength nameOop namePtr |
	<export: true>
	<inline: false>
	<var: #dropName type: 'char *'>
	<var: #namePtr type: 'char *'>
	interpreterProxy methodArgumentCount = 1 
		ifFalse:[^interpreterProxy primitiveFail].
	dropIndex := interpreterProxy stackIntegerValue: 0.
	dropName := self dropRequestFileName: dropIndex.
	"dropRequestFileName returns name or NULL on error"
	dropName == nil 
		ifTrue:[^interpreterProxy primitiveFail].
	nameLength := self strlen: dropName.
	nameOop := interpreterProxy instantiateClass: interpreterProxy classString indexableSize: nameLength.
	namePtr := interpreterProxy firstIndexableField: nameOop.
	0 to: nameLength-1 do:[:i| namePtr at: i put: (dropName at: i)].
	interpreterProxy pop: 2.
	interpreterProxy push: nameOop.
