USER root
FROM archlinux/base:latest
RUN pacman -Syu --needed --noconfirm \
    git \
    libffi \
    tesseract \
    openssl \
    bzip2 \
    zlib \
    readline \
    sqlite \
    fortune-mod \
    figlet \
    python-virtualenv \
    redis \
    libxslt \
    libxml2 \
    libpqxx \
    linux-api-headers \
    freetype2 \
    jpeg-archive \
    curl \
    wget \
    neofetch \
    sudo \
    gcc \
    gcc8 \
    imagemagick \
    libwebp \
    zbar \
    ffmpeg \
    file \
    procps-ng
RUN sed -e 's;^# \(%wheel.*NOPASSWD.*\);\1;g' -i /etc/sudoers
RUN useradd pagermaid -r -m -d /pagermaid
RUN usermod -aG wheel,users pagermaid
USER pagermaid
RUN mkdir /pagermaid/workdir
RUN git clone -b master https://github.com/xtaodada/PagerMaid-Modify.git /pagermaid/workdir
WORKDIR /pagermaid/workdir
RUN python3 -m virtualenv venv
RUN source venv/bin/activate; pip3 install -r requirements.txt
CMD ["sh","utils/docker-run.sh"]
