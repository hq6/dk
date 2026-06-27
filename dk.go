package main

import (
	"os"
	"path/filepath"
	"slices"
	"strings"

	"github.com/square/exit"
	"github.com/square/exoskeleton"
)

func main() {
	paths := []string{}
	pwd, _ := os.Getwd()
	starting_paths := []string{pwd}

	if os.Getenv("DKBIN_SEARCH_PATH") != "" {
		starting_paths = filepath.SplitList(os.Getenv("DKBIN_SEARCH_PATH"))
	}

	for _, dir := range starting_paths {
		dir, err := filepath.Abs(dir)
		if err != nil {
			// Skip paths that do not resolve
			continue
		}
		for ; dir != "/"; dir = filepath.Dir(dir) {
			path := dir + "/dkbin"
			// Ignore duplicate dkbin directories
			if slices.Contains(paths, path) {
				continue
			}
			if _, err := os.Stat(path); err == nil {
				paths = append(paths, path)
			}
		}
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
