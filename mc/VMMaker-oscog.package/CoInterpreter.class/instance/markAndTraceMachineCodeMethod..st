gc -- mark and sweep
markAndTraceMachineCodeMethod: aCogMethod
	<var: #aCogMethod type: #'CogBlockMethod *'>
	| homeMethod |
	<var: #homeMethod type: #'CogMethod *'>
	homeMethod := self asCogHomeMethod: aCogMethod.
	objectMemory markAndTrace: homeMethod methodObject