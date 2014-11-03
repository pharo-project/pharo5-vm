interpreter access
isNonIntegerImmediate: oop
	"ObjectMemory only has integer immedates"
	<inline: true>
	^false