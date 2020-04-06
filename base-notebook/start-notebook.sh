#!/bin/bash
# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

set -e

if [[ -n "${JUPYTERHUB_API_TOKEN}" ]]; then
    echo "WARNING: use start-singleuser.sh instead of start-notebook.sh to start a server associated with JupyterHub."
    exec /usr/local/bin/start-singleuser.sh "$@"
    exit
fi

wrapper=""
if [[ "${RESTARTABLE}" == "yes" ]]; then
    wrapper="run-one-constantly"
fi

if [[ -n "${JUPYTER_ENABLE_LAB}" ]]; then
    # shellcheck disable=SC1091,SC2086
    exec /usr/local/bin/start.sh ${wrapper} ${NOTEBOOK_ARGS} jupyter lab "$@"
else
    echo "WARN: Jupyter Notebook deprecation notice https://github.com/jupyter/docker-stacks#jupyter-notebook-deprecation-notice."
    # shellcheck disable=SC1091,SC2086
    exec /usr/local/bin/start.sh ${wrapper} ${NOTEBOOK_ARGS} jupyter notebook "$@"
fi
