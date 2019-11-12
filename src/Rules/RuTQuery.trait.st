"
Description
--------------------

I am a trait defining the API a Query should be able to answer to to be used by a RuQueryRule.

Basically, a query should be able to give an explanation of the violation and to run on a model to find violations.
"
Trait {
	#name : #RuTQuery,
	#category : #'Rules-Traits'
}

{ #category : #accessing }
RuTQuery >> explanation [
	^ self explicitRequirement
]

{ #category : #running }
RuTQuery >> runOn: aModel [
	"A rule query should be able to run on a model and return a list of violations."

	^ self explicitRequirement
]
