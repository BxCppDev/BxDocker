====================================================================
BxDocker - Helper scripts to build Bayeux 3 docker images 
====================================================================


Supported systems:

* Ubuntu Linux 22.04
* Ubuntu Linux 24.04



Build Docker images for Ubuntu 22.04
===================================================
  

.. code:: shell
	  
   $ cd ubuntu22.04/
   $ bash make_images.bash
   $ docker image ls | grep ^bxcppdev-ubuntu22.04-
   bxcppdev-ubuntu22.04-base       1         a944e7ba4bf2   8 weeks ago    1GB
   bxcppdev-ubuntu22.04-bx3build   1         ebc4eaef2dfd   8 weeks ago    7.92GB
   bxcppdev-ubuntu22.04-bayeux     3.5.5     99758ab78363   8 weeks ago    8.2GB
..




Build Docker images for Ubuntu 24.04
===================================================
  

.. code:: shell
	  
   $ cd ubuntu24.04/
   $ bash make_images.bash
   $ docker image ls | grep ^bxcppdev-ubuntu24.04-
   bxcppdev-ubuntu24.04-base       1         f3468e75fd05   8 weeks ago    1.13GB
   bxcppdev-ubuntu24.04-bx3build   1         dad015c65f4f   8 weeks ago    8.46GB
   bxcppdev-ubuntu24.04-bayeux     3.5.5     feab7b4f6397   8 weeks ago    8.73GB
..


.. end
