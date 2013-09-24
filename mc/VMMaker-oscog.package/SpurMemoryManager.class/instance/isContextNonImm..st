object testing
isContextNonImm: oop
	<inline: true>
	^(self classIndexOf: oop) = ClassMethodContextCompactIndex