=============
docker-python
=============

Built with the Dockerfile, then flattened to remove about 150 MB of cruft.

.. code::

   docker build -t marina/python:2.7.8_r1_unflat .
   export CONTAINER_ID=$(docker run -d marina/python:2.7.8_r1_unflat /bin/true)
   docker export $CONTAINER_ID | docker import - marina/python:2.7.8_r1

Will allow builds of many popular Python libaries with C extensions, including,
but not limited to:

 - lxml
 - uwsgi
 - psycopg2
 - gevent
 - greenlet
 - SQLAlchemy
 - czipfile

pyscopg2 will be built against postgresql-devel @ 9.2.7-1.el7.
