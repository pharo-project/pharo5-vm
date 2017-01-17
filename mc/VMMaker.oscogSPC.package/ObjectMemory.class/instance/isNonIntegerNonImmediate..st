interpreter access
isNonIntegerNonImmediate: oop
	"ObjectMemory only has integer immedates"
	<inline: true>
	^true