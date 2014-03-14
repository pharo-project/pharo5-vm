versions
version19: spec 
	<version: '1.9' imports: #('1.8') >
	
	spec for: #common do: [
		spec blessing: #development.
		spec 
			package: 'VMMaker-oscog' with: 'VMMaker-oscog-MarianoMartinezPeck.66';
			package: 'CMakeVMMaker' with: 'CMakeVMMaker-MarianoMartinezPeck.99'.
	].