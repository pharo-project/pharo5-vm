accessing class hierarchy
chooseCogitClass
	^Smalltalk at: ([:choices| choices at: (UIManager default chooseFrom: choices) ifAbsent: [^nil]]
						value: (Cogit allSubclasses collect: [:ea| ea  name]) sorted)