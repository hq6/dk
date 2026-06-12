all: dk completions/.built dkbin/hello-world-bin

dk: dk.go
	go build .

completions/.built: completions/generate-completions.go
	go run completions/generate-completions.go
	touch $@

clean:
	rm -f dk completions/bash-completion.sh completions/zsh-completion.sh completions/.built \
	  dkbin/hello-world-bin

dkbin/hello-world-bin: dkbin-src/hello-world-bin.c
	gcc -o $@ $<
