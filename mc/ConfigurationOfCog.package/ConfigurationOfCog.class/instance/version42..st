versions
version42: spec
	<version: '4.2' imports: #('4.1' )>

	spec for: #'common' do: [
		spec blessing: #'development'.
		spec author: 'EstebanLorenzano'.
		spec timestamp:  '20 February 2012 6:50:49 pm'.
		
		spec
			package: 'CMakeVMMaker' with: 'CMakeVMMaker-EstebanLorenzano.151';
			package: 'VMMaker' with: 'VMMaker-oscog-EstebanLorenzano.149' ].


