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
		
		if (SecurityUtils.getSubject().isAuthenticated()) {
			flash.error = "You are already logged in."
			render(view: '/index.gsp')
			return
		}
		
		if (params.username.length() < 2 || params.username.length() > 10) {
			flash.error = "The username must contain between 2 and 10 characters."
			redirect(action: 'index')
			return
		}
		
		if (params.password.length() < 2 || params.passwordConf.length() < 2) {
			flash.error = "The password must contain at least 2 characters."
			redirect(action: 'index')
			return
		}

		// Check to see if the username already exists
		def user = User.findByUsername(params.username)
		if (user) {
			flash.error = "The username '${params.username}' is not available."
			redirect(action: 'index')
			return
		}

		// User doesn't exist with username. Let's create one
		else {

			// Make sure the passwords match
			if (params.password != params.passwordConf) {
				flash.error = "Passwords do not match."
				redirect(action: 'index')
				return
			}

			// Passwords match. Let's attempt to save the user
			else {
				// Create user
				user = new User(
						username: params.username,
						passwordHash: shiroSecurityService.encodePassword(params.password)
						)

				if (user.save()) {

					// Add USER role to new user
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
