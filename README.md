# `__main__` in fish

## Problem statement

Find a way to check whether the current `.fish` file has been directly executed or if it was sourced.

### Why

This allows one to write scripts that can be directly called like scripts or sourced to be made available as commands for repeated/later use.

## Current partly working solution

```fish
#!/bin/fish
function hello_world --description "Print hello world"
    echo "Hello world"
end

if test ! (status current-command) = source
    hello_world $argv
end

echo DEBUG "$_" CURRENT (status current-command)
```

This works fine and can differentiate between being sourced and run directly.
However the source detection doesn't work when it is sourced by `~/.config/fish/config.fish`.

# Reproduce

## Requirements
* `buildah`
* `docker` or `podman`

## Setup env
```fish
> ./build_docker.fish
> podman run --rm -it fish-main # can also just replace podman with docker
```

Observe how `Hello world` is being printed upon launching the fish shell/container.

`C> source /root/.config/fish/my_functions/hello_world.fish`

`Hello world` won't be printed as expected.

`C> /root/.config/fish/my_functions/hello_world.fish`

`Hello world` will be printed as expected.

`C> exit`

`> source config.fish`

`Hello world` won't be printed as expected.

`> source my_functions/hello_world.fish`

`Hello world` won't be printed as expected.


`./my_functions/hello_world.fish`

`Hello world` will be printed as expected.