VERSION     := 0.1.0
GO_BUILDOPT := -ldflags '-s -w -X main.version $(VERSION)'

gom:
	go get github.com/mattn/gom
	gom install

run:
	gom run main.go ${ARGS}

fmt:
	gom exec goimports -w *.go chikurin/*.go

build: fmt
	gom build $(GO_BUILDOPT) -o bin/chikurin main.go

release: fmt
	GOOS=linux GOARCH=amd64 gom build $(GO_BUILDOPT) -o bin/chikurin$(VERSION).linux-amd64 main.go
	GOOS=linux GOARCH=386 gom build $(GO_BUILDOPT) -o bin/chikurin$(VERSION).linux-386 main.go

clean:
	rm -f bin/chikurin*

install: build
	cp bin/chikurin /usr/local/bin/

uninstall: clean
	rm -f /usr/local/bin/chikurin
