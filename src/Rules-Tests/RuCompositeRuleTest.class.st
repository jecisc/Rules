"
A RuCompositeRuleTest is a test class for testing the behavior of RuCompositeRule
"
Class {
	#name : #RuCompositeRuleTest,
	#superclass : #RuAbstractRuleTest,
	#category : #'Rules-Tests'
}

{ #category : #helpers }
RuCompositeRuleTest >> actualClass [
	^ RuCompositeRule
]

{ #category : #helpers }
RuCompositeRuleTest >> mutate: aRule [
	aRule children anyOne rule: [ :aModel | aModel allContainers select: [ :each | each numberOfLinesOfCode > 100 ] ]
]

{ #category : #helpers }
RuCompositeRuleTest >> newInstance [
	^ super newInstance
		in: [ :compositeRule | self addSomeRulesTo: compositeRule ];
		yourself
]

{ #category : #tests }
RuCompositeRuleTest >> testAddRule [
	| rules newRule |
	rules := rule children copy.
	newRule := RuRule
		rule: [ true ]
		label: 'test'
		explanation: 'test 2'
		remediationTime: 10 minutes.
	rule addRule: newRule.
	self assert: rule children size equals: rules size + 1
]

{ #category : #tests }
RuCompositeRuleTest >> testAddRuleSetParent [
	| newRule |
	newRule := RuRule
		rule: [ true ]
		label: 'test'
		explanation: 'test 2'
		remediationTime: 10 minutes.
	self assert: newRule parent isNil.
	rule addRule: newRule.
	self assert: newRule parent equals: rule
]

{ #category : #tests }
RuCompositeRuleTest >> testCompositeRuleWithoutChildren [
	rule children: #().
	self shouldnt: [ rule totalRemediationTime ] raise: Error.
	self assert: rule totalRemediationTime equals: Duration zero
]

{ #category : #tests }
RuCompositeRuleTest >> testRemoveRule [
	| rules newRule |
	rules := rule children copy.
	newRule := RuRule
		rule: [ true ]
		label: 'test'
		explanation: 'test 2'
		remediationTime: 10 minutes.
	rule addRule: newRule.
	self assert: rule children size equals: rules size + 1.
	rule removeRule: newRule.
	self assert: rule children size equals: rules size
]

{ #category : #tests }
RuCompositeRuleTest >> testTechnicalDebt [
	"For now, this is the same as the total remediation time but in the future we should be able to remove some rules from the technical debt."

	self assert: rule technicalDebt equals: self totalRemediationTime
]

{ #category : #helpers }
RuCompositeRuleTest >> totalRemediationTime [
	^ 65 minutes
]
