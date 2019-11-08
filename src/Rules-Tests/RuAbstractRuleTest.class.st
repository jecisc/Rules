"
A RuAbstractRuleTest is a test class for testing the behavior of RuAbstractRule
"
Class {
	#name : #RuAbstractRuleTest,
	#superclass : #RuTestCase,
	#instVars : [
		'rootRule',
		'rule'
	],
	#category : #'Rules-Tests'
}

{ #category : #testing }
RuAbstractRuleTest class >> isAbstract [
	^ self = RuAbstractRuleTest
]

{ #category : #helpers }
RuAbstractRuleTest >> actualClass [
	^ self subclassResponsibility
]

{ #category : #accessing }
RuAbstractRuleTest >> mutate: aRule [
	self subclassResponsibility
]

{ #category : #helpers }
RuAbstractRuleTest >> newInstance [
	^ (self actualClass parent: (rootRule := self rootRule))
		label: 'test';
		explanation: 'This is a test';
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
RuAbstractRuleTest >> testCopy [
	| copy |
	copy := rule copy.
	self assert: rule equals: copy.
	self deny: rule identicalTo: copy
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
RuAbstractRuleTest >> testHash [
	| inst2 |
	inst2 := self newInstance.
	self assert: rule hash equals: rule hash.
	self assert: rule hash equals: inst2 hash.
	inst2 label: 'something new'.
	self deny: rule hash equals: inst2 hash
]

{ #category : #tests }
RuAbstractRuleTest >> testPrintOnDoesNotCrashOnNilLabel [
	rule label: nil.
	self shouldnt: [ rule printString ] raise: Error
]

{ #category : #tests }
RuAbstractRuleTest >> testRestoreFromMemento [
	| memento |
	memento := rule createMemento.
	rule label: 'toto'.
	self assert: rule label equals: 'toto'.
	rule restoreFromMemento: memento.
	self deny: rule label equals: 'toto'
]

{ #category : #tests }
RuAbstractRuleTest >> testTotalRemediationTime [
	self assert: rule totalRemediationTime equals: self totalRemediationTime
]

{ #category : #tests }
RuAbstractRuleTest >> testWorkingHours [
	self assert: rule workingHours equals: 8.
	rootRule workingHours: 7.
	self assert: rule workingHours equals: 7
]

{ #category : #helpers }
RuAbstractRuleTest >> totalRemediationTime [
	^ self subclassResponsibility
]
