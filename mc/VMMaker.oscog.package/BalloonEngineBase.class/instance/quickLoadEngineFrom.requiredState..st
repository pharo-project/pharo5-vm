loading state
quickLoadEngineFrom: oop requiredState: requiredState
	<inline: false>
	| failureCode |
	(failureCode := self quickLoadEngineFrom: oop) = 0 ifFalse:[^failureCode].
	self stateGet = requiredState ifTrue:[^0].
	self stopReasonPut: GErrorBadState.
	^GEFWrongState