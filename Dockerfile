FROM rhub/r-minimal:4.5.0
LABEL author="estat"
LABEL project="mongolite"

RUN [ "apk", "add", "--no-cache", \
  "curl-dev", \
  "cyrus-sasl-dev", \
  "fontconfig-dev", \
  "fribidi-dev", \
  "freetype-dev", \
  "font-liberation", \
  "g++", \
  "gcc", \
  "harfbuzz-dev", \
  "musl-dev", \
  "libgit2-dev", \
  "linux-headers", \
  "libxml2-dev", \
  "openssl-dev", \
  "tiff-dev" \
  ]

WORKDIR /usr/src/
RUN echo "n"
RUN [ "R", "-e", "install.packages(c('devtools'), repos = 'https://cloud.r-project.org/')" ]

COPY .Rbuildignore .
COPY NAMESPACE .
COPY DESCRIPTION .
COPY configure .

COPY man/ man/
COPY inst/ inst/
COPY test/ test/
COPY tests/ tests/
COPY src/ src/
COPY R/ R/

RUN [ "R", "CMD", "INSTALL", "." ]