moonbeam
========

This is test for writing the Python Cookbook using a IPython Notebooks.  A few requirements:

* Notebook files in a folder called "notebooks"
* Each chapter in its own directory, with rich name, like "ch00-Sample-Content"
* Each recipe in its own IPYNB file

## Editing the Notebooks

### IPython in Docker

* Install Docker 1.3, Boot2docker, and Fig
* from the root directory, type `fig up`

### Conda

You might also just want to install conda.

## Generate markdown from notebooks

Do this to generate a low-fidelity PDF for review and sharing:

* Download  [pdc2md](https://github.com/odewahn/pdc2md/releases) and put it somewhere on your path.  Note that this is a Mac binary; if you're using something else I can recompile it.
* Run `pdc2md -out generated/` from the root directory
* Commit the files and push into Atlas

We'll most likely produce the final version using `nbconvert`, but let's see how this workflow goes.


### Produce a build in Atlas

Once you push in the markdown files and update the configuration to add the new files (if necessary), you can then produce a build.  To do this, you can either use the Atlas Web interface or the new command line tool:

* Download the [oreilly api](https://github.com/odewahn/atlas-cli/releases/tag/0.0.4) and put it somewhere on your path.  Note that this is a Mac binary; if you're using something else I can recompile it.
* Run `oreilly atlas build odewahn/moonbeam --pdf`
