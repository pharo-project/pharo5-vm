compiled methods
isPublicMethod: methodObj
	<option: #NewspeakVM>
	^(self accessModifierOfMethod: methodObj) = 0