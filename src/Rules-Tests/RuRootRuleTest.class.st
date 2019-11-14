"
A RuRootRuleTest is a test class for testing the behavior of RuRootRule
"
Class {
	#name : #RuRootRuleTest,
	#superclass : #RuCompositeRuleTest,
	#category : #'Rules-Tests'
}

{ #category : #helpers }
RuRootRuleTest >> actualClass [
	^ RuRulesManager
]

{ #category : #helpers }
RuRootRuleTest >> newInstance [
	^ super newInstance
		model: self mockModel;
		yourself
]

{ #category : #running }
RuRootRuleTest >> setUp [
	super setUp.
	rootRule := rule
]
