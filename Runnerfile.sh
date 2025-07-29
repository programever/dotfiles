#!/usr/bin/env bash
# https://github.com/stylemistake/runner

task_default() {
  echo "Available tasks to run:"
  runner --list-tasks
}

task_start:work() {
  projects=("watch" "airon" "uob")

  for project in "${projects[@]}"; do
    echo "Starting tmux session for $project..."
    tmuxinator start "$project" --no-attach
  done
}

task_start:ts-bedrock() {
  projects=("ts-bedrock-core" "ts-bedrock-api" "ts-bedrock-web")

  for project in "${projects[@]}"; do
    echo "Starting tmux session for $project..."
    tmuxinator start "$project" --no-attach
  done
}
