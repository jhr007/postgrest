stack test --test-arguments "--skip \"returns a valid openapi\""
git ls-files | grep '\.l\?hs$' | xargs stack exec -- hlint -X QuasiQuotes -X NoPatternSynonyms "$@"
stack exec -- cabal update
stack exec --no-ghc-package-path -- cabal install --only-d --dry-run
stack exec -- packdeps *.cabal || true
stack exec -- cabal check
stack  --no-haddock-deps
stack sdist
