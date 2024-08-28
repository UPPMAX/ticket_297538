# ticket_297538

Notes for ticket 297538

## Attempt 1: from documentation

I start with this:

```
Bootstrap: docker
From: condaforge/miniforge3

%post
    # From https://github.com/brucemoran/Singularity/blob/8eb44591284ffb29056d234c47bf8b1473637805/shub/bases/recipe.CentOs7-R_3.5.2#L21
    echo 'export LANG=en_US.UTF-8 LANGUAGE=C LC_ALL=C LC_CTYPE=C LC_COLLATE=C  LC_TIME=C LC_MONETARY=C LC_PAPER=C LC_MEASUREMENT=C' >> $SINGULARITY_ENVIRONMENT

    # Must be done before a conda create
    conda init

    # create and activate virtual python environment
    conda create -n dna python=3.8
    conda activate dna

    # (optional if you would like to use flash attention)
    # install triton from source
    cd /opt
    git clone https://github.com/openai/triton.git
    cd triton/python
    pip install cmake; # build-time dependency
    pip install -e .

    # install required packages
    cd /opt
    git clone https://github.com/MAGICS-LAB/DNABERT_2
    cd DNABERT_2
    python3 -m pip install -r requirements.txt

%runscript
python3 "$@"
```

Build:

```
./create.sh
```

Gives:

```
[sudo] password for richel: 
INFO:    Starting build...
INFO:    Fetching OCI image...
26.2MiB / 26.2MiB [==================================================================================================================================================] 100 % 0.0 b/s 0s
119.3MiB / 119.3MiB [================================================================================================================================================] 100 % 0.0 b/s 0s
INFO:    Extracting OCI image...
INFO:    Inserting Singularity configuration...
INFO:    Running post scriptlet
+ echo export LANG=en_US.UTF-8 LANGUAGE=C LC_ALL=C LC_CTYPE=C LC_COLLATE=C  LC_TIME=C LC_MONETARY=C LC_PAPER=C LC_MEASUREMENT=C
+ conda init
no change     /opt/conda/condabin/conda
no change     /opt/conda/bin/conda
no change     /opt/conda/bin/conda-env
no change     /opt/conda/bin/activate
no change     /opt/conda/bin/deactivate
no change     /opt/conda/etc/profile.d/conda.sh
no change     /opt/conda/etc/fish/conf.d/conda.fish
no change     /opt/conda/shell/condabin/Conda.psm1
no change     /opt/conda/shell/condabin/conda-hook.ps1
no change     /opt/conda/lib/python3.10/site-packages/xontrib/conda.xsh
no change     /opt/conda/etc/profile.d/conda.csh
modified      /root/.bashrc

==> For changes to take effect, close and re-open your current shell. <==

+ conda create -n dna python=3.8
Channels:
 - conda-forge
Platform: linux-64
Collecting package metadata (repodata.json): done
Solving environment: done


==> WARNING: A newer version of conda exists. <==
    current version: 24.3.0
    latest version: 24.7.1

Please update conda by running

    $ conda update -n base -c conda-forge conda



## Package Plan ##

  environment location: /opt/conda/envs/dna

  added / updated specs:
    - python=3.8


The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    _libgcc_mutex-0.1          |      conda_forge           3 KB  conda-forge
    _openmp_mutex-4.5          |            2_gnu          23 KB  conda-forge
    bzip2-1.0.8                |       h4bc722e_7         247 KB  conda-forge
    ca-certificates-2024.7.4   |       hbcca054_0         151 KB  conda-forge
    ld_impl_linux-64-2.40      |       hf3520f5_7         691 KB  conda-forge
    libffi-3.4.2               |       h7f98852_5          57 KB  conda-forge
    libgcc-14.1.0              |       h77fa898_1         827 KB  conda-forge
    libgcc-ng-14.1.0           |       h69a702a_1          51 KB  conda-forge
    libgomp-14.1.0             |       h77fa898_1         449 KB  conda-forge
    libnsl-2.0.1               |       hd590300_0          33 KB  conda-forge
    libsqlite-3.46.0           |       hde9e2c9_0         845 KB  conda-forge
    libuuid-2.38.1             |       h0b41bf4_0          33 KB  conda-forge
    libxcrypt-4.4.36           |       hd590300_1          98 KB  conda-forge
    libzlib-1.3.1              |       h4ab18f5_1          60 KB  conda-forge
    ncurses-6.5                |       he02047a_1         868 KB  conda-forge
    openssl-3.3.1              |       hb9d3cd8_3         2.8 MB  conda-forge
    pip-24.2                   |     pyhd8ed1ab_0         1.2 MB  conda-forge
    python-3.8.19              |hd12c33a_0_cpython        21.3 MB  conda-forge
    readline-8.2               |       h8228510_1         275 KB  conda-forge
    setuptools-72.2.0          |     pyhd8ed1ab_0         1.4 MB  conda-forge
    tk-8.6.13                  |noxft_h4845f30_101         3.2 MB  conda-forge
    wheel-0.44.0               |     pyhd8ed1ab_0          57 KB  conda-forge
    xz-5.2.6                   |       h166bdaf_0         409 KB  conda-forge
    ------------------------------------------------------------
                                           Total:        34.9 MB

The following NEW packages will be INSTALLED:

  _libgcc_mutex      conda-forge/linux-64::_libgcc_mutex-0.1-conda_forge 
  _openmp_mutex      conda-forge/linux-64::_openmp_mutex-4.5-2_gnu 
  bzip2              conda-forge/linux-64::bzip2-1.0.8-h4bc722e_7 
  ca-certificates    conda-forge/linux-64::ca-certificates-2024.7.4-hbcca054_0 
  ld_impl_linux-64   conda-forge/linux-64::ld_impl_linux-64-2.40-hf3520f5_7 
  libffi             conda-forge/linux-64::libffi-3.4.2-h7f98852_5 
  libgcc             conda-forge/linux-64::libgcc-14.1.0-h77fa898_1 
  libgcc-ng          conda-forge/linux-64::libgcc-ng-14.1.0-h69a702a_1 
  libgomp            conda-forge/linux-64::libgomp-14.1.0-h77fa898_1 
  libnsl             conda-forge/linux-64::libnsl-2.0.1-hd590300_0 
  libsqlite          conda-forge/linux-64::libsqlite-3.46.0-hde9e2c9_0 
  libuuid            conda-forge/linux-64::libuuid-2.38.1-h0b41bf4_0 
  libxcrypt          conda-forge/linux-64::libxcrypt-4.4.36-hd590300_1 
  libzlib            conda-forge/linux-64::libzlib-1.3.1-h4ab18f5_1 
  ncurses            conda-forge/linux-64::ncurses-6.5-he02047a_1 
  openssl            conda-forge/linux-64::openssl-3.3.1-hb9d3cd8_3 
  pip                conda-forge/noarch::pip-24.2-pyhd8ed1ab_0 
  python             conda-forge/linux-64::python-3.8.19-hd12c33a_0_cpython 
  readline           conda-forge/linux-64::readline-8.2-h8228510_1 
  setuptools         conda-forge/noarch::setuptools-72.2.0-pyhd8ed1ab_0 
  tk                 conda-forge/linux-64::tk-8.6.13-noxft_h4845f30_101 
  wheel              conda-forge/noarch::wheel-0.44.0-pyhd8ed1ab_0 
  xz                 conda-forge/linux-64::xz-5.2.6-h166bdaf_0 


Proceed ([y]/n)? 

Downloading and Extracting Packages:
                                                                                                                                                                                       
Preparing transaction: done                                                                                                                                                            
Verifying transaction: done                                                                                                                                                            
Executing transaction: done                                                                                                                                                            
#                                                                                                                                                                                      
# To activate this environment, use                                                                                                                                                    
#                                                                                                                                                                                      
#     $ conda activate dna                                                                                                                                                             
#                                                                                                                                                                                      
# To deactivate an active environment, use                                                                                                                                             
#                                                                                                                                                                                      
#     $ conda deactivate                                                                                                                                                               
                                                                                                                                                                                       
+ conda activate dna                                                                                                                                                                   
                                                                                                                                                                                       
CondaError: Run 'conda init' before 'conda activate'                                                                                                                                   
                                                                                                                                                                                       
FATAL:   While performing build: while running engine: exit status 1       
```

Hmmm, how to do a `conda init` in a Singularity container?