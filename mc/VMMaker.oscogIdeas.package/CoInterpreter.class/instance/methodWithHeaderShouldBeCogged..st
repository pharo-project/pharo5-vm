compiled methods
methodWithHeaderShouldBeCogged: methodHeader
	"At the moment jit any method with less than N literals, where N defaults to 60.
	 See e.g. SimpleStackBasedCogit class>>initialize.
	 In my dev image eem 2/22/2009 13:39
		(30 to: 100 by: 5) collect:
			[:n| n -> (SystemNavigation default allSelect: [:m| m numLiterals > n]) size]
		#(30->1681 35->1150 40->765 45->523 50->389 55->289 60->206
		    65->151 70->124 75->99 80->73 85->63 90->54 95->42 100->38).
	 And running the CogVMSimulator with flagging of interpreted methods turned on reveals
	 the following sizes of interpreted methods.
		| sizes |
		sizes := Bag new.
		SystemNavigation default allSelect: [:m| m flag ifTrue: [sizes add: m numLiterals]. false].
		sizes sortedElements asArray
			#(	40->4 41->1 42->2 44->1 45->3 46->1 47->2 48->1
				50->2 51->1 53->1 55->1 56->1
				87->1 108->1 171->1)
	 literalCountOfHeader: does not include the header word."
	^SistaVM
		ifTrue: [(self isOptimizedMethodHeader: methodHeader)
				or: [(objectMemory literalCountOfMethodHeader: methodHeader) <= maxLiteralCountForCompile]]
		ifFalse: [(objectMemory literalCountOfMethodHeader: methodHeader) <= maxLiteralCountForCompile]