# a simple distro
FROM debian

RUN apt-get update; 

# globally used tools
# Add cmake?
RUN apt-get install -y \
    vim \
    git;

# Getting my barebones vimrc from github
RUN cd ~ && \
    git clone https://github.com/hearnderek/editors.git && \
    cp ./editors/my-vim.txt .vimrc;

# c compile tools (LLVM)
RUN apt-get ninja-build \
    clang;

# Todo: add swift compiler

# The source code
RUN cd ~ && git clone https://github.com/hearnderek/codewars.git;