"
This formatter adds highlights to XMLHighlightingWriter output.
"
Class {
	#name : #XMLHighlightingPrettyPrintingWriterFormatter,
	#superclass : #XMLPrettyPrintingWriterFormatter,
	#instVars : [
		'highlighter'
	],
	#category : #'XML-Parser-GTExtensions-Highlighting-Writer'
}

{ #category : #private }
XMLHighlightingPrettyPrintingWriterFormatter >> endPosition [
	^ self writer position
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatAfterCData: aCDataWriter [
	highlighter endCDataHighlightPosition: self endPosition.

	super formatAfterCData: aCDataWriter.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatAfterCharacterEscape: aCharacterEscape [
	highlighter endEntityReferenceHighlightPosition: self endPosition.

	super formatAfterCharacterEscape: aCharacterEscape.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatAfterComment: aCommentWriter [
	highlighter endCommentHighlightPosition: self endPosition.

	super formatAfterComment: aCommentWriter.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatAfterDeclaration: aDeclarationWriter [
	highlighter endDeclarationHighlightPosition: self endPosition.

	super formatAfterDeclaration: aDeclarationWriter.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatAfterDoctypeDeclaration: aDoctypeDeclarationWriter [
	highlighter endDoctypeDeclarationHighlightPosition: self endPosition.

	super formatAfterDoctypeDeclaration: aDoctypeDeclarationWriter.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatAfterEndTag: aTagWriter [
	highlighter endTagHighlightPosition: self endPosition.

	super formatAfterEndTag: aTagWriter.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatAfterEntityReference: anEntityReferenceWriter [
	highlighter endEntityReferenceHighlightPosition: self endPosition.

	super formatAfterEntityReference: anEntityReferenceWriter.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatAfterPI: aPIWriter [
	highlighter endPIHighlightPosition: self endPosition.

	super formatAfterPI: aPIWriter.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatAfterQuotedStringValue: aString [
	highlighter endQuotedStringValueHighlightPosition: self endPosition.

	super formatAfterQuotedStringValue: aString.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatAfterStartTag: aTagWriter [
	highlighter endTagHighlightPosition: self endPosition.

	super formatAfterStartTag: aTagWriter.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatAfterXMLDeclaration: anXMLDeclarationWriter [
	highlighter endXMLDeclarationHighlightPosition: self endPosition.

	super formatAfterXMLDeclaration: anXMLDeclarationWriter.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatBeforeCData: aCDataWriter [
	super formatBeforeCData: aCDataWriter.

	highlighter startCDataHighlightPosition: self startPosition.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatBeforeCharacterEscape: aCharacterEscape [
	super formatBeforeCharacterEscape: aCharacterEscape.

	highlighter startEntityReferenceHighlightPosition: self startPosition.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatBeforeComment: aCommentWriter [
	super formatBeforeComment: aCommentWriter.

	highlighter startCommentHighlightPosition: self startPosition.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatBeforeDeclaration: aDeclarationWriter [
	super formatBeforeDeclaration: aDeclarationWriter.

	highlighter startDeclarationHighlightPosition: self startPosition.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatBeforeDoctypeDeclaration: aDoctypeDeclarationWriter [
	super formatBeforeDoctypeDeclaration: aDoctypeDeclarationWriter.

	highlighter startDoctypeDeclarationHighlightPosition: self startPosition.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatBeforeEndTag: aTagWriter [
	super formatBeforeEndTag: aTagWriter.

	highlighter startTagHighlightPosition: self startPosition.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatBeforeEntityReference: anEntityReferenceWriter [
	super formatBeforeEntityReference: anEntityReferenceWriter.

	highlighter startEntityReferenceHighlightPosition: self startPosition.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatBeforePI: aPIWriter [
	super formatBeforePI: aPIWriter.

	highlighter startPIHighlightPosition: self startPosition.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatBeforeQuotedStringValue: aString [
	super formatBeforeQuotedStringValue: aString.

	highlighter startQuotedStringValueHighlightPosition: self startPosition.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatBeforeStartTag: aTagWriter [
	super formatBeforeStartTag: aTagWriter.

	highlighter startTagHighlightPosition: self startPosition.
]

{ #category : #formatting }
XMLHighlightingPrettyPrintingWriterFormatter >> formatBeforeXMLDeclaration: anXMLDeclarationWriter [
	super formatBeforeXMLDeclaration: anXMLDeclarationWriter.

	highlighter startXMLDeclarationHighlightPosition: self startPosition.
]

{ #category : #private }
XMLHighlightingPrettyPrintingWriterFormatter >> startPosition [
	^ self writer position + 1
]

{ #category : #accessing }
XMLHighlightingPrettyPrintingWriterFormatter >> writer: aWriter [
	super writer: aWriter.

	highlighter := aWriter highlighter.
]