package qnrsoft

import org.apache.shiro.authc.UsernamePasswordToken
import org.apache.shiro.SecurityUtils

class SignupController {
	def shiroSecurityService

	def index() {
		User user = new User()
		[user: user]
	}

	def register() {
		
		if (SecurityUtils.subject.isAuthenticated()) {
			flash.error = "You are already logged in."
			render(view: '/index.gsp')
			return
		}
		
		if (params.password.length() < 8) {
			flash.error = "The password must contain at least 8 characters."
			redirect(action: 'index')
			return
		}

		def user = User.findByUsername(params.username)
		if (user) {
			flash.error = "The username '${params.username}' is not available."
			redirect(action: 'index')
			return
		}
		else {

			// Check passwords match
			if (params.password != params.passwordConf) {
				flash.error = "Passwords do not match."
				redirect(action: 'index')
				return
			}
			else {
				// Create user
				user = new User(
						username: params.username,
						passwordHash: shiroSecurityService.encodePassword(params.password)
						)

				if (user.save()) {

					// Add STUDENT role to new user
					user.addToRoles(Role.findByName('ROLE_STUDENT'))

					// Login user
					def authToken = new UsernamePasswordToken(user.username, params.password)
					SecurityUtils.subject.login(authToken)

					flash.message = "You are now logged in as '${user.username}'"
					redirect(uri: "/")
				}
			}
		}
	}
}
