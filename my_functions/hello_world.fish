#!/usr/bin/fish
function hello_world --description "Print hello world"
    echo "Hello world"
end

if test ! (status current-command) = source
    hello_world $argv
end

echo DEBUG "$_" CURRENT (status current-command)
