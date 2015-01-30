compiled methods
accessModifierOfMethod: methodObj
	<option: #NewspeakVM>
	^self accessModifierOfMethodHeader: (objectMemory methodHeaderOf: methodObj)