ARG BASE_IMAGE
FROM ${BASE_IMAGE}
ENV PYTHONPATH "${PYTHONPATH}:/src"

# ADD path
# TODO

CMD ["/bin/bash", "-c", "source activate workspace && bash"]
