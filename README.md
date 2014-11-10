moonbeam
========

This is test for writing the Python Cookbook using a IPython Notebooks.  A few requirement:





## Running IPython in Docker

* Install Docker 1.3, Boot2docker, and Fig
* from the root directory, type `fig up`

## Conda

You might also just want to install conda.

## Generating markdown from notebooks

* Download  [pdc2md](https://github.com/odewahn/pdc2md/releases) and put it somewhere on your path
* Run `pdc2md -out generated/` from the root directory
* Commit the files and push into Atlas


## Building in Atlas

* Download the [oreilly api](https://github.com/odewahn/atlas-cli/releases/tag/0.0.4) and put it somewhere on your path
* Run `oreilly atlas build odewahn/moonbeam --pdf`
