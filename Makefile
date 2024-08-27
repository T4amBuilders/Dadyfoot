# Run Flutter Web-dev
web-dev:
	@echo "Running Flutter for web..."
	cd ./frontend && flutter run -d web-server --web-port 2256

# Run the installer for the entire project
linter:
	@echo "Running linter..."
	./linter-script.sh
