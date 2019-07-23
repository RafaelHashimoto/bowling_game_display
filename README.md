## Getting Started

  This application was buit inside a docker container. So you'll need to put the files you want to load inside the /files folder.

### Requirements

- just docker :)

### Build the docker image

Inside the project's folder type:

`$ docker build -t bowling .`

### Run the docker container

`$ docker run -v [project_path]:/usr/src/app --name current_bowlin -it bowling`

After that you will be inside the IRB and able to type the name of the file you want to load.

To leave the termial just type `ctrl + c`

## Running Tests

This application was tested using RSpec.

To execute the tests is recommended that you access the running container from another terminal and execute the command below

`$ docker exec -it /bin/bash`

Inside the terminal type `rspec` to run all te test cases.