versions
version40: spec
	<version: '4.0' imports: #('3.9' )>

	spec for: #'common' do: [
		spec blessing: #'development'.
		spec author: 'IgorStasenko'.
		spec timestamp:  '7 Feb 2012'.
		
		spec
			package: 'CMakeVMMaker' with: 'CMakeVMMaker-EstebanLorenzano.148';
			package: 'VMMaker' with: 'VMMaker-oscog-IgorStasenko.143'
	].


