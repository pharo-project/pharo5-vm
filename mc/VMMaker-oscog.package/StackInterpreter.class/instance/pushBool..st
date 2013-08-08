internal interpreter access
pushBool: trueOrFalse
	<inline: true>
	self push: (objectMemory booleanObjectOf: trueOrFalse)