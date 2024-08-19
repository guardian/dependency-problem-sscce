#!/usr/bin/env bash

set -e

SBT_DEPENDENCY_SUBMISSION_OUTPUT=$(sbt githubGenerateSnapshot)
LINE_WITH_FILE=$(echo "$SBT_DEPENDENCY_SUBMISSION_OUTPUT" | grep 'Dependency snapshot written to')
FILENAME=${LINE_WITH_FILE//"[info] Dependency snapshot written to "/""}
jq . "$FILENAME" > sbt_dependency_submission_workflow.json
echo "Created sbt_dependency_submission_workflow.json"

SBT_DEPENDENCY_TREE_OUTPUT=$(sbt dependencyTree)
DEPENDENCY_TREE_OUTPUT=$(sbt dependencyTree)
SEARCH_STRING="set current project to dependency-problem-sscce"
# Use awk to drop lines up to and including the first line that contains the search string
OUTPUT=$(echo "$DEPENDENCY_TREE_OUTPUT" | awk -v s="$SEARCH_STRING" 'BEGIN{flag=0} $0 ~ s{flag=1; next} flag' | sed 's/^\[info\] //' | grep -v '^\[success\]')
echo "$OUTPUT" > dependency_tree.txt
echo "Created dependency_tree.txt"