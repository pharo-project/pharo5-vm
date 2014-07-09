sista support
resetCountersIn: cogMethod
	<var: #cogMethod type: #'CogMethod *'>
	<api>
	<option: #SistaStackToRegisterMappingCogit>
	cogit fillInCounters: (self numCountersFor: cogMethod counters) atStartAddress: cogMethod counters