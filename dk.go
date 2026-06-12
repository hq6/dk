package main

import (
	"os"
	"path/filepath"
	"strings"

	"github.com/square/exit"
	"github.com/square/exoskeleton"
)

func main() {
	paths := []string{}
	dir, _ := os.Getwd()
	for dir != "/" {
		path := dir + "/dkbin"
		if _, err := os.Stat(path); err == nil {
			paths = append(paths, path)
		}
		dir = filepath.Dir(dir)
	}

	home := os.Getenv("HOME")

	cli, _ := exoskeleton.New(paths,
		exoskeleton.WithModuleMetadataFilename(".dk-module"),
		exoskeleton.WithMenuHeadingFor(func(m exoskeleton.Module, c exoskeleton.Command) string {
			return "COMMANDS IN " + strings.Replace(c.(exposeDiscoveredIn).DiscoveredIn(), home, "~", 1)
		}))
	cmd, args, _ := cli.Identify(os.Args[1:])
	err := cmd.Exec(cli, args, os.Environ())
	os.Exit(exit.FromError(err))
}

type exposeDiscoveredIn interface {
	DiscoveredIn() string
}
