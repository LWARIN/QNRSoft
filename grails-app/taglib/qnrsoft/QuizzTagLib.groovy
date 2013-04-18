package qnrsoft

class QuizzTagLib {
	
	static namespace = "quizz"
	
	def isOpened = { attrs, body ->
		if (attrs.state == Quizz.STATE_OPENED) {
			out << body{}
		}
	}
	
	def isVoting = { attrs, body ->
		if (attrs.state == Quizz.STATE_VOTING) {
			out << body{}
		}
	}
	
	def isClosed = { attrs, body ->
		if (attrs.state == Quizz.STATE_CLOSED) {
			out << body{}
		}
	}

}
