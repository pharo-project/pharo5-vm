SistaRegisterAllocatingCogit is a port of SistaCogit under RegisterAllocatingCogit.  Its subclass SistaCogitClone holds those methods that are identical to SistaCogit's.  This class holds the methods that are different.  SistaRegisterAllocatingCogit's initialize method keeps things up-to-date and arranges that no method implemented in SistaRegisterAllocatingCogit is implemented in SistaCogitClone so that super sends in SistaCogitClone activate code in RegisterAllocatingCogit as intended.

Instance Variables
	branchReachedOnlyForCounterTrip:		<Object>
	ceTrapTrampoline:		<Object>
	counterIndex:		<Object>
	counters:		<Object>
	initialCounterValue:		<Object>
	numCounters:		<Object>

branchReachedOnlyForCounterTrip
	- xxxxx

ceTrapTrampoline
	- xxxxx

counterIndex
	- xxxxx

counters
	- xxxxx

initialCounterValue
	- xxxxx

numCounters
	- xxxxx
