compiled methods
isProtectedMethod: methodObj
	<option: #NewspeakVM>
	<inline: true>
	^(self accessModifierOfMethod: methodObj) = AccessModifierProtected