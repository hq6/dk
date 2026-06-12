package main

import (
	"os"

	"github.com/square/exoskeleton"
)

func main() {
	if f, err := os.Create("completions/bash-completion.sh"); err != nil {
		panic(err)
	} else {
		exoskeleton.GenerateCompletionScript("dk", "bash", f)
		f.Close()
	}

	if f, err := os.Create("completions/zsh-completion.sh"); err != nil {
		panic(err)
	} else {
		exoskeleton.GenerateCompletionScript("dk", "zsh", f)
		f.Close()
	}
}
