timing
stop
	| elapsedInThisPeriod current |
	current := self currentMillis.
	
	elapsedInThisPeriod := Time milliseconds: current since: startTime.
	
	elapsedTime := elapsedTime + elapsedInThisPeriod.