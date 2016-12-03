Class {
	#name : #XMLDecodingReadStreamAdapterUTF8BOMTest,
	#superclass : #XMLDecodingReadStreamAdapterUTF8Test,
	#category : #'XML-Tests-Parser-Streams'
}

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF8BOMTest >> invalidStreamCollection [
	^ self invalidEncodedInputCollectionWithBOM
]

{ #category : #testing }
XMLDecodingReadStreamAdapterUTF8BOMTest >> isDetecting [
	^ true
]

{ #category : #accessing }
XMLDecodingReadStreamAdapterUTF8BOMTest >> streamCollection [
	^ self inputCollectionWithBOM
]