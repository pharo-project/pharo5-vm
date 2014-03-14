versions
version41: spec
	<version: '4.1' imports: #('4.0' )>

	spec for: #'common' do: [
		spec blessing: #'development'.
		spec author: 'EstebanLorenzano'.
		spec timestamp:  '18 February 2012 10:41:44 am'.
		
		spec
			package: 'CMakeVMMaker' with: 'CMakeVMMaker-EstebanLorenzano.150';
			package: 'VMMaker' with: 'VMMaker-oscog-IgorStasenko.144' ].


