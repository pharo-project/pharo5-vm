versions
version44: spec
	<version: '4.4' imports: #('4.3' )>

	spec for: #'common' do: [
		spec blessing: #'release'.
		spec author: 'EstebanLorenzano'.
		spec timestamp:  '6 April 2012 3:18:03 pm'.
		
		spec
			package: 'CMakeVMMaker' with: 'CMakeVMMaker-IgorStasenko.154';
			package: 'VMMaker-oscog' with: 'VMMaker-oscog-EstebanLorenzano.150' ].


