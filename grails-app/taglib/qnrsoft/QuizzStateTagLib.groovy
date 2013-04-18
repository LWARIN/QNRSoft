package qnrsoft

class QuizzStateTagLib {
	def quizzState = { attrs, body ->
		if (attrs.name == attrs.instanceState) {
			out << body{}
		}
	}
}
