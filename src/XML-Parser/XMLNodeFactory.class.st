"
This class is the default node factory. Its accessor messages return the class objects used by the DOM parser to build a node tree. You can override these messages to return different class objects and inject an instance of your factory using #nodeFactory:.
"
Class {
	#name : #XMLNodeFactory,
	#superclass : #Object,
	#category : #'XML-Parser-Nodes'
}

{ #category : #accessing }
XMLNodeFactory >> cdataClass [
	^ XMLCData
]

{ #category : #accessing }
XMLNodeFactory >> classForElement: aQualifiedName prefix: aPrefix uri: aNamespaceUri localName: aLocalName [
	^ self elementClass
]

{ #category : #accessing }
XMLNodeFactory >> commentClass [
	^ XMLComment
]

{ #category : #accessing }
XMLNodeFactory >> doctypeDeclarationClass [
	^ XMLDoctypeDeclaration
]

{ #category : #accessing }
XMLNodeFactory >> documentClass [
	^ XMLDocument
]

{ #category : #accessing }
XMLNodeFactory >> elementClass [
	^ XMLElement
]

{ #category : #accessing }
XMLNodeFactory >> piClass [
	^ XMLPI
]

{ #category : #accessing }
XMLNodeFactory >> stringClass [
	^ XMLString
]