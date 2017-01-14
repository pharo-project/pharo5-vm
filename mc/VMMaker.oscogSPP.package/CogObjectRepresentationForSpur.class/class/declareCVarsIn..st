translation
declareCVarsIn: aCodeGen
	"Deal wuth the fact that the number of trampolines depends on IMMUTABILITY
	 and that IMMUTABILITY can be defined at compile time.  Yes, this is a mess."
	| current values |
	self assert: (CogObjectRepresentationForSpur allSubclasses allSatisfy:
					[:sc|
					 CogObjectRepresentationForSpur initializationOptions == sc initializationOptions]).
	current := initializationOptions at: #IMMUTABILITY ifAbsent: nil.
	values := #(true false) collect:
				[:bool|
				 initializationOptions at: #IMMUTABILITY put: bool.
				 self cogitClass initializeNumTrampolines.
				 (Cogit classPool at: #NumTrampolines) printString].
	current
		ifNil: [initializationOptions removeKey: #IMMUTABILITY]
		ifNotNil: [initializationOptions at: #IMMUTABILITY put: current].
	values first ~= values last ifTrue:
		[aCodeGen addConstantForBinding: #NumTrampolines -> ('(IMMUTABILITY ? ' , values first , ' : ' , values last , ')')].
	aCodeGen
		var: #ceStoreTrampolines
		declareC: ('#if IMMUTABILITY\sqInt ceStoreTrampolines[', NumStoreTrampolines printString, '];\#endif') withCRs