FROM ipython/scipystack

WORKDIR /usr/src/notebooks

CMD ipython notebook --ip=0.0.0.0 --no-browser