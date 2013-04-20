<!DOCTYPE html>
<html>
	<head>
		<title>QnR - URI not found</title>
		<meta name="layout" content="main">
		<style type="text/css" media="screen">

			.ie6 #status {
				display: inline; /* float double margin fix http://www.positioniseverything.net/explorer/doubled-margin.html */
			}

			#status h1 {
				text-transform: uppercase;
				font-size: 1.1em;
				margin: 0 0 0.3em;
			}

			#page-body {
				margin: 2em 7em 1.25em 7em;
			}

			@media screen and (max-width: 480px) {
				#status {
					display: none;
				}

				#page-body {
					margin: 0 1em 1em;
				}

				#page-body h1 {
					margin-top: 0;
				}
			}
		</style>
	</head>
	<body>
		<div id="header"></div>
		<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
		</g:if>
		<div id="page-body" role="main">
			<h1>URI Not Found (404)</h1>
			
			The URI you requested can't be found.
		</div>
</html>
