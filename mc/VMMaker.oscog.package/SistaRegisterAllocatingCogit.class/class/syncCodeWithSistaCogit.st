class initialization
syncCodeWithSistaCogit
	"Make sure that the SistaRegisterAllocatingCogit/SistaCogitClone combination is up-to-date w.r.t. SistaCogit.
	 - 	SistaCogitClone should have all methods in SistaCogit except those implemented in SistaRegisterAllocatingCogit.
		This means that super sends in SistaCogitClone will be understood in SistaRegisterAllocatingCogit, not
		SistaRegisterAllocatingCogit.
	 -	newer methods in SistaCogitClone that are implemented in SistaRegisterAllocatingCogit should be moved up to
		SistaRegisterAllocatingCogit becaude it means that we probably changed them in SistaCogitClone by mistake
		and forgot to copy them up.
	 -	the same goes for the class side, except for the intializeWithOptions: method which /should/ exist in both
		SistaRegisterAllocatingCogit and SistaCogitClone, because it runs this initialization."
	| syncAction |
	syncAction :=
		[self syncCodeIn: SistaCogit with: SistaCogitClone leavingUnchanged: nil.
		 self syncCodeIn: SistaCogit class with: SistaCogitClone class leavingUnchanged: #initializeWithOptions:].
	^(Smalltalk classNamed: #CurrentReadOnlySourceFiles)
		ifNil: syncAction
		ifNotNil: [:crosf| crosf cacheDuring: syncAction]