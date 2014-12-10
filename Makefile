collectstatic: htmldeps
	mkdir -p dockci/static/lib/css
	mkdir -p dockci/static/lib/fonts
	mkdir -p dockci/static/lib/js

	cp bower_components/bootstrap/dist/css/bootstrap.min.css dockci/static/lib/css
	cp bower_components/bootstrap-material-design/dist/css/material.min.css dockci/static/lib/css
	cp bower_components/bootstrap-material-design/dist/css/material-wfont.min.css dockci/static/lib/css
	cp bower_components/bootstrap-material-design/dist/css/ripples.min.css dockci/static/lib/css

	cp bower_components/bootstrap-material-design/dist/fonts/Material-Design-Icons.woff dockci/static/lib/fonts
	cp bower_components/bootstrap-material-design/dist/fonts/Material-Design-Icons.ttf dockci/static/lib/fonts

	cp bower_components/ansi_up/ansi_up.js dockci/static/lib/js
	cp bower_components/bootstrap/js/tab.js dockci/static/lib/js
	cp bower_components/bootstrap-material-design/dist/js/material.min.js dockci/static/lib/js
	cp bower_components/bootstrap-material-design/dist/js/ripples.min.js dockci/static/lib/js
	cp bower_components/jquery/dist/jquery.min.js dockci/static/lib/js
	cp bower_components/jquery-ui/jquery-ui.min.js dockci/static/lib/js

htmldeps:
	npm install
	node_modules/bower/bin/bower --allow-root install
pythondeps:
	virtualenv -p $(shell which python3.4) python_env
	python_env/bin/pip install -r requirements.txt
deps: htmldeps pythondeps collectstatic

styletest:  # don't install deps
	pep8 dockci
	pylint --rcfile pylint.conf dockci
test: styletest

# Container commands
ci: test
run:
	@python_env/bin/python3 /code/serve_wrapper.py 0.0.0.0
sh:
	@sh

.PHONY: ci collectstatic htmldeps pythondeps deps run styletest test
