"
A RuRulesManagerTest is a test class for testing the behavior of RuRulesManager
"
Class {
	#name : #RuRulesManagerTest,
	#superclass : #RuCompositeRuleTest,
	#category : #'Rules-Tests'
}

{ #category : #helpers }
RuRulesManagerTest >> actualClass [
	^ RuRulesManager
]

{ #category : #helpers }
RuRulesManagerTest >> newInstance [
	^ super newInstance
		model: self mockModel;
		yourself
]

{ #category : #running }
RuRulesManagerTest >> setUp [
	super setUp.
	rootRule := rule
]
