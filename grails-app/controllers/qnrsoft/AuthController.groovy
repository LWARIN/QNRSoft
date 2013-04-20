package qnrsoft

import org.apache.shiro.SecurityUtils
import org.apache.shiro.authc.AuthenticationException
import org.apache.shiro.authc.UsernamePasswordToken
import org.apache.shiro.web.util.SavedRequest
import org.apache.shiro.web.util.WebUtils

class AuthController {
    def shiroSecurityManager

    def index = { redirect(action: "login", params: params) }

    def login = {
        return [ username: params.username, rememberMe: (params.rememberMe != null), targetUri: params.targetUri ]
    }

    def signIn = {
        def authToken = new UsernamePasswordToken(params.username, params.password as String)

        if (params.rememberMe) {
            authToken.rememberMe = true
        }
		
        // If a controller redirected to this page, redirect back
        // to it. Otherwise redirect to the root URI.
        def targetUri = params.targetUri ?: "/"
        
        def savedRequest = WebUtils.getSavedRequest(request)
        if (savedRequest) {
            targetUri = savedRequest.requestURI - request.contextPath
            if (savedRequest.queryString) targetUri = targetUri + '?' + savedRequest.queryString
        }
        
        try{
            SecurityUtils.subject.login(authToken)

            log.info "Redirecting to '${targetUri}'."
			flash.message = "You are now logged in as '${params.username}'"
            redirect(uri: targetUri)
        }
        catch (AuthenticationException ex){
            log.info "Authentication failure for user '${params.username}'."
            flash.error = message(code: "login.failed")

            // Keep the username and "remember me" setting so that the
            // user doesn't have to enter them again.
            def m = [ username: params.username ]
            if (params.rememberMe) {
                m["rememberMe"] = true
            }

            // Remember the target URI.
            if (params.targetUri) {
                m["targetUri"] = params.targetUri
            }

            // Redirect back to the login page.
            redirect(action: "login", params: m)
        }
    }

    def signOut = {
        // Log the user out of the application.
        SecurityUtils.subject?.logout()

		flash.message = "You are now logged out."
        redirect(uri: "/")
    }

    def unauthorized = {
        render (view: "/error.gsp")
    }
}
