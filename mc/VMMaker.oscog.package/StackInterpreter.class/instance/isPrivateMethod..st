compiled methods
isPrivateMethod: methodObj
	<option: #NewspeakVM>
	^(self accessModifierOfMethod: methodObj) = 1