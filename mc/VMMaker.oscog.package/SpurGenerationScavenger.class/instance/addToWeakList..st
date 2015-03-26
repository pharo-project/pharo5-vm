weakness and ephemerality
addToWeakList: weakCorpse
	"weakCorpse is the corpse of a weak array that was copied and forwarded.
	 Later on its surviving copy must be scanned to nil weak references.
	 Thread the corpse onto the weakList.  Later, the weakList can be followed, and
	 the forwarding pointer followed to locate the survivor."
	<inline: #never> "Should be too infrequent to lower icache density of copyAndForward:"
	| weakListOffset |

	weakListOffset := weakList ifNil: 0.
	self setCorpseOffsetOf: weakCorpse to: weakListOffset.
	weakList := self corpseOffsetOf: weakCorpse.
	self assert: (self firstCorpse: weakList) = weakCorpse