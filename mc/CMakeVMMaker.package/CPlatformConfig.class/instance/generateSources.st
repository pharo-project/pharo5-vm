source generation
generateSources
	"Generate whole VM + plugins sources"
	| oldCompilerClass |

	[ 
		oldCompilerClass := SmalltalkImage compilerClass.
		SmalltalkImage compilerClass: Compiler.
	  	self basicGenerateSources ]
	ensure: [ 
		SmalltalkImage compilerClass: oldCompilerClass ]