compiled methods
isProtectedMethod: methodObj
	<option: #NewspeakVM>
	^(self accessModifierOfMethod: methodObj) = 2