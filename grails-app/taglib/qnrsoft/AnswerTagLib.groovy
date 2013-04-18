package qnrsoft

class AnswerTagLib {
	
	static namespace = "answer"
	
	def isPending = { attrs, body ->
		if (attrs.status == Answer.STATUS_PENDING) {
			out << body{}
		}
	}
	
	def isApproved = { attrs, body ->
		if (attrs.status == Answer.STATUS_APPROVED) {
			out << body{}
		}
	}
	
	def isRejected = { attrs, body ->
		if (attrs.status == Answer.STATUS_REJECTED) {
			out << body{}
		}
	}

}
