initialization
initialize
	<doNotGenerate>
	super initialize.
	relinquishing := checkThreadActivation := deferThreadSwitch := false.
	foreignCallbackPriority := maxWaitingPriority := disownCount := willNotThreadWarnCount := 0