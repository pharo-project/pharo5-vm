specifying primitives
handlePrimitiveDirective: aStmt on: sStream

	isPrimitive := true.
	fullArgs := args.
	locals addAll: args.
	args := OrderedCollection new.
	fullArgs with: parmSpecs do:
		[:argName :spec |
		self declarationAt: argName
			put: (spec ccgDeclareCForVar: argName)].
	aStmt isAssignment ifTrue:
		[self declarationAt: aStmt variable name
			put: (rcvrSpec ccgDeclareCForVar: aStmt variable name).
		 sStream nextPutAll: (self
			statementsFor:
				(rcvrSpec
					ccg:		SmartSyntaxPluginCodeGenerator new
					prolog:  [:expr | aStmt variable name, ' := ', expr]
					expr: 	aStmt variable name
					index: 	(fullArgs size))
			varName: '')].

	"only add the failure guard if there are args or it is an assignment"
	(fullArgs isEmpty not or:[aStmt isAssignment]) ifTrue:[self generateFailureGuardOn: sStream].
	^true.
