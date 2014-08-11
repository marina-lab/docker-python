=============
docker-python
=============

Built with the Dockerfile, then flattened to remove about 150 MB of cruft.

.. code::

   docker build -t marina/python:2.7.8_r1_unflat .
   export CONTAINER_ID=$(docker run -d marina/python:2.7.8_r1_unflat /bin/true)
   docker export $CONTAINER_ID | docker import - marina/python:2.7.8_r1
