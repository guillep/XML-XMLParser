Class {
	#name : #XMLAttributeTest,
	#superclass : #XMLNodeTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #accessing }
XMLAttributeTest >> escapedString [
	^ '&lt;test name=&quot;&amp;name;&quot;>''&amp;value;''&lt;/test>'
]

{ #category : #accessing }
XMLAttributeTest >> nodeClass [
	^ XMLAttribute
]

{ #category : #tests }
XMLAttributeTest >> testAncestorElements [
	self should: [super testAncestorElements] raise: Error
]

{ #category : #tests }
XMLAttributeTest >> testAncestorElementsDo [
	self should: [super testAncestorElementsDo] raise: Error
]

{ #category : #tests }
XMLAttributeTest >> testAncestorNodes [
	self should: [super testAncestorNodes] raise: Error
]

{ #category : #tests }
XMLAttributeTest >> testAncestorNodesDo [
	self should: [super testAncestorNodesDo] raise: Error
]

{ #category : #tests }
XMLAttributeTest >> testCopy [
	| node copy |

	(node := self nodeClass new)
		element: XMLElement new.
	copy := node copy.
	self
		deny: copy == node;
		assert: copy element isNil.
]

{ #category : #tests }
XMLAttributeTest >> testElement [
	| node element |

	node := self nodeClass new.
	element := XMLElement new.
	node element: element.
	self assert: node element == element.
]

{ #category : #tests }
XMLAttributeTest >> testExpandedName [
	| element attribute |

	element := XMLElement new.
	attribute := self nodeClass name: 'one' value: 'two'.
	element attributeNodes add: attribute.
	self assert: (attribute expandedName = 'one').

	element defaultNamespace: 'defaultNS'.
	self assert: (attribute expandedName = 'one').

	element declarePrefix: 'prefix' uri: 'prefixNS'.
	attribute name: 'prefix:two'.
	self assert: (attribute expandedName = '{prefixNS}two').
]

{ #category : #tests }
XMLAttributeTest >> testHasParent [
	self should: [super testHasParent] raise: Error
]

{ #category : #tests }
XMLAttributeTest >> testHasPrefix [
	| attribute |

	attribute := self nodeClass new.
	self deny: attribute hasPrefix.

	attribute name: 'one'.
	self deny: attribute hasPrefix.

	attribute name: 'prefix:two'.
	self assert: attribute hasPrefix.

	attribute name: 'three'.
	self deny: attribute hasPrefix.
]

{ #category : #tests }
XMLAttributeTest >> testIsNamed [
	| attribute |

	(attribute := self nodeClass new) name: 'one'.
	self
		assert: (attribute isNamed: 'one');
		deny: (attribute isNamed: 'two').
	attribute name: 'one:two'.
	self
		assert: (attribute isNamed: 'one:two');
		assert: (attribute isNamed: 'two');
		deny: (attribute isNamed: 'one').
]

{ #category : #tests }
XMLAttributeTest >> testIsNamedAny [
	| attribute |

	(attribute := self nodeClass new) name: 'one'.
	self
		assert: (attribute isNamedAny: #('two' 'one' 'three'));
		deny: (attribute isNamedAny: #('two' 'three')).
	attribute name: 'one:two'.
	self
		assert: (attribute isNamedAny: #('one' 'one:two' 'three'));
		assert: (attribute isNamedAny: #('one' 'two' 'three'));
		deny: (attribute isNamedAny: #('one' 'three')).
]

{ #category : #tests }
XMLAttributeTest >> testLocalName [
	| attribute |

	attribute := self nodeClass new.
	self assert: attribute name isEmpty.

	attribute name: 'one'.
	self assert: attribute localName = 'one'.

	attribute name: 'two'.
	self assert: attribute localName = 'two'.

	attribute name: 'prefix:three'.
	self assert: attribute localName = 'three'.

	attribute name: 'four'.
	self assert: attribute localName = 'four'.
]

{ #category : #tests }
XMLAttributeTest >> testName [
	| attribute |

	attribute := self nodeClass new.
	self assert: attribute name isEmpty.

	attribute name: 'one'.
	self assert: attribute name = 'one'.

	attribute name: 'prefix:two'.
	self assert: attribute name = 'prefix:two'.
]

{ #category : #tests }
XMLAttributeTest >> testNameValue [
	| attribute |

	attribute := self nodeClass name: 'one' value: 'two'.
	self
		assert: attribute name = 'one';
		assert: attribute value = 'two'
]

{ #category : #tests }
XMLAttributeTest >> testNamespaceURI [
	| element attribute|

	element := XMLElement new.
	attribute := self nodeClass new.
	element attributeNodes add: attribute.
	self assert: attribute namespaceURI isEmpty.

	element defaultNamespace: 'defaultNS'.
	self assert: attribute namespaceURI isEmpty.

	element declarePrefix: 'prefix' uri: 'prefixNS'.
	attribute name: 'prefix:test'.
	self assert: attribute namespaceURI = 'prefixNS'.
	
	attribute name: 'test'.
	self assert: attribute namespaceURI isEmpty.
]

{ #category : #tests }
XMLAttributeTest >> testNextNode [
	| elementWithAttributes nextNode |

	super testNextNode.
	elementWithAttributes := self newElementWithAttributes.
	nextNode := nil.
	elementWithAttributes attributeNodes reverseDo: [:each |
		self assert: each nextNode == nextNode.
		nextNode := each].
]

{ #category : #tests }
XMLAttributeTest >> testParent [
	| node |

	node := self nodeClass new.
	self
		should: [node parent] raise: Error;
		should: [node parent: self nodeClass new] raise: Error.
]

{ #category : #tests }
XMLAttributeTest >> testPrefix [
	| attribute |

	attribute := self nodeClass new.
	self assert: attribute prefix isEmpty.

	attribute name: 'one'.
	self assert: attribute prefix isEmpty.

	attribute name: 'prefix:two'.
	self assert: attribute prefix = 'prefix'.

	attribute name: 'three'.
	self assert: attribute prefix isEmpty.
]

{ #category : #tests }
XMLAttributeTest >> testPreviousNode [
	| elementWithAttributes previousNode |

	super testPreviousNode.
	elementWithAttributes := self newElementWithAttributes.
	previousNode := nil.
	elementWithAttributes attributeNodes do: [:each |
		self assert: each previousNode == previousNode.
		previousNode := each].
]

{ #category : #tests }
XMLAttributeTest >> testValue [
	self
		assert: self nodeClass new value isEmpty;
		assert: (self nodeClass new value: 'test') value = 'test'
]

{ #category : #tests }
XMLAttributeTest >> testWriteXMLOn [
	self
		assert: (self nodeClass name: 'name' value: '') printString = 'name=""';
		assert: (self nodeClass name: 'name' value: 'value') printString = 'name="value"';
		assert:
			(self nodeClass
				name: 'name'
				value: self markupString) printString = ('name="', self escapedString, '"')
]