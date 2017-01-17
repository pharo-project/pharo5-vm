garbage collection
hasValidHeaderPostGC: cogMethod
	<var: #cogMethod type: #'CogMethod *'>
	<inline: true>
	^cogMethod objectHeader = objectMemory nullHeaderForMachineCodeMethod