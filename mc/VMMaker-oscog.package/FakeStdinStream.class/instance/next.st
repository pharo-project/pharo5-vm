accessing
next
	"Answer the next object in the Stream represented by the receiver.
	 If there are no more elements in the stream fill up the buffer by prompting for input"
	| sem threadIndex inputLine |
	position >= readLimit ifTrue:
		[simulator isThreadedVM
			ifTrue:
				["(simulator cogit singleStep not
				  and: [UIManager confirm: 'Single step?']) ifTrue:
					[simulator cogit singleStep: true]."
				 threadIndex := simulator disownVM: DisownVMLockOutFullGC.
				 simulator forceInterruptCheckFromHeartbeat.
				 sem := Semaphore new.
				 WorldState addDeferredUIMessage:
					[inputLine := UIManager default request: 'Input please!'.
					 sem signal].
				 sem wait]
			ifFalse:
				[inputLine := UIManager default request: 'Input please!'].
		 collection size <= inputLine size ifTrue:
			[collection := collection species new: inputLine size + 1].
		 collection
			replaceFrom: 1 to: inputLine size with: inputLine startingAt: 1;
		 	at: (readLimit := inputLine size + 1) put: Character lf.
		 position := 0.
		 simulator isThreadedVM ifTrue:
			[simulator ownVM: threadIndex]].
	^collection at: (position := position + 1)
	

" This does it with workspaces:
| ws r s |
s := Semaphore new.
ws := Workspace new contents: ''.
ws acceptAction: [:t| r := t asString. s signal].
[ws openLabel: 'Yo!'; shouldStyle: false.
(ws dependents detect: [:dep | dep isKindOf: PluggableTextMorph] ifNone: [nil]) ifNotNil:
	[:textMorph| textMorph acceptOnCR: true; hasUnacceptedEdits: true]] fork.
Processor activeProcess ==  Project uiProcess
	ifTrue: [[r isNil] whileTrue: [World doOneCycle]]
	ifFalse: [s wait].
ws topView delete.
s wait. s signal.
r"