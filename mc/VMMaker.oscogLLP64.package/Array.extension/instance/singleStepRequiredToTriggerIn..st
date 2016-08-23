*VMMaker-interpreter simulator
singleStepRequiredToTriggerIn: aCogit
	^self anySatisfy: [:address| address between: aCogit cogCodeBase and: aCogit methodZone limitZony]