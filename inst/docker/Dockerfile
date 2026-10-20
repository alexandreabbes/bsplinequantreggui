# Dockerfile

FROM rocker/shiny:4.6.0

# Installer les dépendances système
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    libssl-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    git \
    libgmp-dev \
    cmake \
    libwebpmux3 \
    && rm -rf /var/lib/apt/lists/*

# Rust pour CLARABEL
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Installer les packages
RUN R -e "install.packages(c('remotes', 'shiny', 'shinythemes', 'shinyjs', 'DT', 'plotly', 'colourpicker', 'png', 'devtools'))"
RUN R -e "install.packages(c('osqp', 'ECOSolveR', 'scs', 'clarabel'), repos = 'https://cloud.r-project.org/')"
RUN R -e "remotes::install_version('CVXR', version = '1.9.1', repos = 'https://cloud.r-project.org/', update='never')"

# Installer BsplineQuantReg depuis GitHub (version avec quartic)
RUN R -e "remotes::install_github('alexandreabbes/BsplineQuantReg', ref = 'with_quartic', upgrade='never')"

# Installer BsplineQuantRegGui (pour les dépendances)
RUN R -e "remotes::install_github('alexandreabbes/BsplineQuantRegGui', ref = 'main3', upgrade='never')


COPY . /app
WORKDIR /app

# Créer un script de lancement

RUN echo '#!/bin/bash\n\
if [ -z "$APP_VERSION" ]; then\n\
  APP_VERSION="advanced"\n\
fi\n\
echo "Launching app: $APP_VERSION"\n\
R -e "library(BsplineQuantRegGui); run_gui(level = \"$APP_VERSION\", brow = FALSE, host = \"0.0.0.0\", port = 3838)"' > /app/start.sh && chmod +x /app/start.sh

EXPOSE 3838

CMD ["/app/start.sh"]
