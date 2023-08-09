h:
	cat Makefile
b:
	bal build --cloud="docker"
r:
	docker run -it --platform=linux/amd64 --rm --env-file=./.env -p 8080:8080 svg_parser:latest
