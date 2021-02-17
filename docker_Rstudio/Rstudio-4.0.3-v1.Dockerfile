# pull base image
FROM rocker/tidyverse:4.0.3

# build image: docker build -t corebioinf/dockrstudio:4.0.3-v1 -f Rstudio-4.0.3-v1.Dockerfile .
# for example: nohup docker build -t corebioinf/dockrstudio:4.0.3-v1 -f Rstudio-4.0.3-v1.Dockerfile . > "nohup_build_Rstudio-4.0.3-v1.log" 2>&1 &
# docker Rstudio template

# who maintains this image
LABEL maintainer Peter Repiscak "peter.repiscak@ccri.at"
LABEL version 4.0.3-v1

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes libcairo2-dev libxt-dev libcurl4-openssl-dev libcurl4 libxml2-dev libxt-dev openssl libssl-dev wget curl bzip2 libbz2-dev libpng-dev libhdf5-dev pigz

# example how to install packages
RUN install2.r --error Cairo XML RCurl R.utils digest optparse
RUN install2.r --error RColorBrewer data.table ggrepel pheatmap viridis fastcluster cowplot matrixStats reshape2 corrplot scatterplot3d fs stringdist factoextra fpc VGAM GGally 

# from github:
RUN installGithub.r kassambara/ggpubr
RUN installGithub.r jokergoo/ComplexHeatmap

# from bioconductor:
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes liblzma-dev
RUN R -e "BiocManager::install(c('DESeq2', 'limma'))"

#RUN wget -O ~/miniconda.sh "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh" && \
#	bash ~/miniconda.sh -b -p $HOME/miniconda

# # Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# should already be exposed by rstudio (on top of which tidyverse is build)?
#EXPOSE 8787 

#CMD ["R"]
#CMD ["/init"] # needed only when installing from scratch; e.g. r-ver; and rstudio, shiny

