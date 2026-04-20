FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
git \
curl \
wget \
build-essential \
python3.8 \
python3.8-dev \
python3.8-venv \
python3-pip \
libgl1-mesa-glx \
libglib2.0-0 \
ca-certificates \
xvfb

# make python3.8 default
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1

WORKDIR /app

# Copy only setup.sh and run it, improves docker caching
COPY scripts/setup.sh ./scripts/setup.sh
RUN chmod +x ./scripts/setup.sh

ARG THREADS=1

# Run setup during build as root
RUN ./scripts/setup.sh $THREADS

# Install mrtrix3 dependencies and build
RUN apt-get install -y libeigen3-dev libqt5svg5-dev qt5-default --fix-missing
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN export EIGEN_CFLAGS="-isystem /usr/include/eigen3" && \
    cd /apps/mrtrix3 && \
    ./configure && \
    ./build

# Add mrtrix3 to PATH
ENV PATH="/apps/mrtrix3/bin:$PATH"

# Install FSL
RUN apt-get install -y python2 python2-dev && \
    wget -O /tmp/fslinstaller.py "https://fsl.fmrib.ox.ac.uk/fsldownloads/fslinstaller.py" && \
    python2 /tmp/fslinstaller.py -d /apps/fsl -V 6.0.6

# Add FSL to PATH
ENV FSLDIR=/apps/fsl
ENV PATH="${FSLDIR}/bin:${PATH}"

COPY scripts/ ./scripts/
RUN chmod +x ./scripts/entrypoint.sh

ENTRYPOINT ["./scripts/entrypoint.sh"]
