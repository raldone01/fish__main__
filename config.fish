printf "Sourcing hello_world only debug should be printed and the hello world function should be defined\n"

if test -z "$DOCKER_CONTAINER"
  source my_functions/hello_world.fish
else
  source /root/.config/fish/my_functions/hello_world.fish
end
