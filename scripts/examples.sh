#!/bin/sh

for f in internal/generator/examples/*.feature; do
  dir=$(dirname $f)
  base=$(basename $f)
  go run cmd/gherkingen/main.go \
    -package examples_test \
    -permanent-ids \
    -format go \
    -go-parallel \
    -template "@/std.simple.v1.go.tmpl" \
    $f \
    > ${dir}/simpleparallel/${base}_test.go
  go run cmd/gherkingen/main.go \
    -package examples_test \
    -permanent-ids \
    -format go \
    -template "@/std.simple.v1.go.tmpl" \
    $f \
    > ${dir}/simple/${base}_test.go
done
