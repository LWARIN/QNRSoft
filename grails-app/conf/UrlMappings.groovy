class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		"/"(view: "/index")
		"403"(view: '/error/forbidden')
		"404"(view: '/error/notFound')
		
		"/forbidden"(view: '/error/forbidden')
		"/notFound"(view: '/error/notFound')
	}
}
