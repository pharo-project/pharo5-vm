as yet unclassified
initializePrimitiveTableForSqueakV3
	"Initialize the table of primitive generators.  This does not include normal primitives implemened in the coInterpreter."
	"SimpleStackBasedCogit initializePrimitiveTableForSqueakV3"

	| prim |
		
	super initializePrimitiveTableForSqueakV3.
		"(220 primitiveFail)"		"reserved for Cog primitives"


	prim := (primitiveTable at: 220).
	prim primitiveGenerator: #genPrimitiveNBNativeCall;
			primNumArgs: -1;
			enabled: nil.
			
	