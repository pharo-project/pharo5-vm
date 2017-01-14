translation
instVarNamesAndTypesForTranslationDo: aBinaryBlock
	"enumerate aBinaryBlock with the names and C type strings for the
	 inst vars to include in a CogMethod or CogBlockMethod struct."

	self allInstVarNames do:
		[:ivn|
		"Notionally objectHeader is in a union with homeOffset and startpc but
		 we don't have any convenient support for unions.  So hack, hack, hack, hack."
		((self == CogBlockMethod
			ifTrue: [#('objectHeader')]
			ifFalse: [#('homeOffset' 'startpc' 'padToWord')]) includes: ivn) ifFalse:
				[aBinaryBlock
					value: ivn
					value: (ivn caseOf: {
								['objectHeader']			-> [self objectMemoryClass baseHeaderSize = 8
																ifTrue: [#sqLong]
																ifFalse: [#sqInt]].
								['cmNumArgs']				-> [#(unsigned ' : 8')].		"SqueakV3 needs only 5 bits"
								['cmType']					-> [#(unsigned ' : 3')].
								['cmRefersToYoung']		-> [#(unsigned #Boolean ' : 1')].
								['cpicHasMNUCaseOrCMIsFullBlock']
															-> [#(unsigned #Boolean ' : 1')].
								['cmUsageCount']			-> [#(unsigned ' : 3')].		"See CMMaxUsageCount in initialize"
								['cmUsesPenultimateLit']	-> [#(unsigned #Boolean ' : 1')].
								['cbUsesInstVars']			-> [#(unsigned #Boolean ' : 1')].
								['cmUnusedFlags']			-> [#(unsigned ' : 2')].
								['stackCheckOffset']		-> [#(unsigned ' : 12')].		"See MaxStackCheckOffset in initialize. a.k.a. cPICNumCases"
								['blockSize']				-> [#'unsigned short'].		"See MaxMethodSize in initialize"
								['blockEntryOffset']			-> [#'unsigned short'].
								['homeOffset']				-> [#'unsigned short'].
								['startpc']					-> [#'unsigned short'].
								['padToWord']				-> [#(#BaseHeaderSize 8 'unsigned int')].
								['nextMethod']				-> ['struct _CogMethod *'].	"See NewspeakCogMethod"
								['counters']					-> [#usqInt]}				"See SistaCogMethod"
							otherwise:
								[#sqInt])]]