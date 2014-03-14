versions
version43: spec
	<version: '4.3' imports: #('4.2' )>

	spec for: #'common' do: [
		spec blessing: #'release'.
		spec author: 'EstebanLorenzano'.
		spec timestamp:  '5 April 2012 2:06:47 pm'.
		
		spec
			package: 'CMakeVMMaker' with: 'CMakeVMMaker-EstebanLorenzano.153';
			package: 'VMMaker' with: 'VMMaker-oscog-EstebanLorenzano.150' ].


