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
	^ RuRootRule
]

{ #category : #helpers }
RuRootRuleTest >> newInstance [
	^ super newInstance
		model: self mockModel;
		yourself
]
