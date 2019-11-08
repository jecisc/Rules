"
A RuQueryRuleTest is a test class for testing the behavior of RuQueryRule
"
Class {
	#name : #RuQueryRuleTest,
	#superclass : #RuLeafRuleTest,
	#category : #'Rules-Tests'
}

{ #category : #helpers }
RuQueryRuleTest >> actualClass [
	^ RuQueryRule
]

{ #category : #helpers }
RuQueryRuleTest >> mutate: aRule [
	aRule inputQuery: (RuMockNameQuery regex: 'Meth.*')
]

{ #category : #helpers }
RuQueryRuleTest >> newInstance [
	^ super newInstance
		inputQuery: (RuMockNameQuery regex: 'Class.*');
		yourself
]

{ #category : #helpers }
RuQueryRuleTest >> totalRemediationTime [
	^ 90 minutes
]
