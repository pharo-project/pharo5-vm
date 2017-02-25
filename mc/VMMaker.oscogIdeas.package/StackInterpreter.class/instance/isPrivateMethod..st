compiled methods
isPrivateMethod: methodObj
	<option: #NewspeakVM>
	<inline: true>
	^(self accessModifierOfMethod: methodObj) = AccessModifierPrivate