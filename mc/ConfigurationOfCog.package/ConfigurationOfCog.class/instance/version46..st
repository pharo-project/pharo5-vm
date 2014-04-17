versions
version46: spec
	<version: '4.6' imports: #('4.5' )>

	spec for: #'common' do: [
		spec blessing: #'release'.
		spec author: 'EstebanLorenzano'.
		spec timestamp:  '25 April 2012 9:35:37 am'.
		
		spec
			package: 'CMakeVMMaker' with: 'CMakeVMMaker-EstebanLorenzano.156';
			package: 'VMMaker-oscog' with: 'VMMaker-oscog-EstebanLorenzano.157' ].


