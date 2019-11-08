"
A RuAbstractRuleTest is a test class for testing the behavior of RuAbstractRule
"
Class {
	#name : #RuAbstractRuleTest,
	#superclass : #TestCase,
	#instVars : [
		'rule'
	],
	#category : #'Rules-Tests'
}

{ #category : #testing }
RuAbstractRuleTest class >> isAbstract [
	^ self = RuAbstractRuleTest
]

{ #category : #testing }
RuAbstractRuleTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #helpers }
RuAbstractRuleTest >> actualClass [
	^ self subclassResponsibility
]

{ #category : #helpers }
RuAbstractRuleTest >> mockModel [
	| model container1 container2 container3 |
	container1 := Mock named: 'Container1'.
	container1 stub numberOfLinesOfCode willReturn: 24.
	container2 := Mock named: 'Container2'.
	container2 stub numberOfLinesOfCode willReturn: 11.
	container3 := Mock named: 'Container3'.
	container3 stub numberOfLinesOfCode willReturn: 7.
	model := Mock named: 'Model'.
	model stub allContainers willReturn: {container1 . container2 . container3}.

	^ model
]

{ #category : #helpers }
RuAbstractRuleTest >> mutate: aRule [
	self subclassResponsibility
]

{ #category : #helpers }
RuAbstractRuleTest >> newInstance [
	| root |
	root :=" RuRule new
		label: 'Root rule';
		model: self mockModel;
		yourself." Mock named: 'Root rule'.
		root stub model willReturn: self mockModel.
	^ self actualClass new
		label: 'test';
		explanation: 'This is a test';
		parent: root;
		yourself
]

{ #category : #running }
RuAbstractRuleTest >> setUp [
	super setUp.
	rule := self newInstance
]

{ #category : #tests }
RuAbstractRuleTest >> testCacheIsResetWhenRulesChange [
	| time |
	time := rule totalRemediationTime.
	self mutate: rule.
	self deny: time equals: rule totalRemediationTime
]

{ #category : #tests }
RuAbstractRuleTest >> testEquals [
	| inst2 |
	inst2 := self newInstance.
	self assert: rule equals: rule.
	self assert: rule equals: inst2.
	inst2 label: 'something new'.
	self deny: rule = inst2
]

{ #category : #tests }
RuAbstractRuleTest >> testTotalRemediationTime [
	self assert: rule totalRemediationTime equals: self totalRemediationTime
]

{ #category : #helpers }
RuAbstractRuleTest >> totalRemediationTime [
	^ self subclassResponsibility
]
