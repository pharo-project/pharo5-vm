compiled methods
isPublicMethod: methodObj
	<option: #NewspeakVM>
	<inline: true>
	^(self accessModifierOfMethod: methodObj) = AccessModifierPublic