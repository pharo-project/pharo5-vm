compiled methods
accessModifierOfMethod: methodObj
	<option: #NewspeakVM>
	<inline: true>
	^self accessModifierOfMethodHeader: (objectMemory methodHeaderOf: methodObj)