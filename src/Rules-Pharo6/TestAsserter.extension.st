Extension { #name : #TestAsserter }

{ #category : #'*Rules-Pharo6' }
TestAsserter >> deny: actual equals: expected [
	"This method raises an AssertionFailure if actual is equals (using #= message) to expected.
	 Else it does nothing and execution continues.
	"
	^ self
		deny: expected = actual
		description: [self unexpectedEqualityStringBetween: actual and: expected]
]
