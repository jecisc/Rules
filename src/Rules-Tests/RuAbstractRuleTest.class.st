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
RuAbstractRuleTest >> mutate: aRule [
	self subclassResponsibility
]

{ #category : #helpers }
RuAbstractRuleTest >> newInstance [
	| root |
	root := Mock named: 'Root rule'.
	self flag: #todo. "This should return a mock model instead of an empty array"
	root stub model willReturn: #().
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
	self skip.
	self flag: #todo. "unskip"
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
	self skip.
	self flag: #todo. "unskip"
	self assert: rule totalRemediationTime equals: self totalRemediationTime
]

{ #category : #helpers }
RuAbstractRuleTest >> totalRemediationTime [
	^ self subclassResponsibility
]
