C code generator
emitCVariablesOn: aStream
	"Store the global variable declarations on the given stream.
	 Break logic into vars for structure and vars for non-structure."
	| structure nonstruct |

	structure := WriteStream on: (String new: 32768).
	nonstruct := WriteStream on: (String new: 32768).
	aStream nextPutAll: '/*** Variables ***/'; cr.
	structure
		nextPutAll: '#if SQ_USE_GLOBAL_STRUCT'; cr;
		nextPutAll: '# define _iss /* define in-struct static as void */'; cr;
		nextPutAll: 'static struct foo {'; cr;
		nextPutAll: '#else'; cr;
		nextPutAll: '# define _iss static'; cr;
		nextPutAll: '#endif'; cr.
	self buildSortedVariablesCollection do:
		[ :var | | decl varString inStruct target |
		target := (inStruct := self placeInStructure: (varString := var asString)) 
					ifTrue: [structure]
					ifFalse: [nonstruct].
		decl := variableDeclarations at: varString ifAbsent: ['sqInt ' , varString].
		decl first == $# "support cgen var: #bytecodeSetSelector declareC: '#define bytecodeSetSelector 0' hack"
			ifTrue:
				[target nextPutAll: decl; cr]
			ifFalse:
				[self isGeneratingPluginCode
					ifTrue:
						[varString = 'interpreterProxy'
							ifTrue: "quite special..."
								[self preDeclareInterpreterProxyOn: target]
							ifFalse: [target nextPutAll: 'static ']]
					ifFalse:
						[(vmClass mustBeGlobal: varString) ifFalse:
							[target nextPutAll: (inStruct ifTrue: ['_iss '] ifFalse: ['static '])]].
				target nextPutAll: decl; nextPut: $;; cr]].
	structure
		nextPutAll: '#undef _iss'; cr;
		nextPutAll: '#if SQ_USE_GLOBAL_STRUCT'; cr;
		nextPutAll: ' } fum;'; cr;
		nextPutAll: ' #if SQ_USE_GLOBAL_STRUCT_REG';cr;
		nextPutAll: '# define DECL_MAYBE_SQ_GLOBAL_STRUCT /* using a global reg pointer */'; cr;
		nextPutAll: '# define DECL_MAYBE_VOLATILE_SQ_GLOBAL_STRUCT /* using a global reg pointer */'; cr;
		nextPutAll:'#else';cr;
		nextPutAll: '# define DECL_MAYBE_SQ_GLOBAL_STRUCT register struct foo * foo = &fum;'; cr;
		nextPutAll: '# define DECL_MAYBE_VOLATILE_SQ_GLOBAL_STRUCT volatile register struct foo * foo = &fum;'; cr;
		nextPutAll: '#endif';cr;
		nextPutAll: '# define GIV(interpreterInstVar) (foo->interpreterInstVar)'; cr;
		nextPutAll: '#else'; cr;
		nextPutAll: '# define DECL_MAYBE_SQ_GLOBAL_STRUCT /* oh, no mr bill! */'; cr;
		nextPutAll: '# define DECL_MAYBE_VOLATILE_SQ_GLOBAL_STRUCT /* oh no, mr bill! */'; cr;
		nextPutAll: '# define GIV(interpreterInstVar) interpreterInstVar'; cr;
		nextPutAll: '#endif'; cr.

	"if the machine needs the fum structure defining locally, do it now; global register users don't need that, but DO need some batshit insane C macro fudging in order to convert the define of USE_GLOBAL_STRUCT_REG into a simple string to use in the asm clause below. Sigh."
	structure
		nextPutAll: '#if SQ_USE_GLOBAL_STRUCT'; cr;
		nextPutAll: '#if SQ_USE_GLOBAL_STRUCT_REG';cr;
		nextPutAll: '#define fooxstr(s) foostr(s)'; cr;
		nextPutAll: '#define foostr(s)  #s'; cr;
		nextPutAll: 'register struct foo * foo asm(fooxstr(USE_GLOBAL_STRUCT_REG));'; cr;
		nextPutAll: '#else'; cr;
		nextPutAll: 'static struct foo * foo = &fum;'; cr;
		nextPutAll: '#endif'; cr;
		nextPutAll: '#endif'; cr.

	aStream
		nextPutAll: structure contents;
		nextPutAll: nonstruct contents;
		cr